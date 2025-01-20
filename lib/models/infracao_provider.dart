import 'dart:convert';
import 'package:detranapp/util/infracao_db.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:detranapp/models/Infracao.dart';

class InfracaoProvider with ChangeNotifier {
  final String _baseUrl =
      'https://detranapp-75e56-default-rtdb.firebaseio.com/';
  List<Infracao> _infracoes = [];

  List<Infracao> get infracoes => _infracoes;

  final InfracaoDb _infracaoDb = InfracaoDb();

  Future<void> carregarInfracoes(String userId) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/infracoes.json'));

      if (response.statusCode == 200) {
        final Map<String, dynamic>? data = json.decode(response.body);
        _infracoes = (data?.entries ?? []).where((entry) {
          final infracaoData = entry.value;
          final userIdValue = infracaoData['userId'];
          return userIdValue != null && userIdValue == userId;
        }).map((entry) {
          final id = entry.key;
          final infracaoData = entry.value;
          return Infracao.fromJson(id, infracaoData);
        }).toList();

        await _syncWithLocalDb(_infracoes, userId);
      } else {
        throw Exception('Falha ao carregar infracoes do Firebase');
      }
    } catch (e) {
      try {
        _infracoes = await _infracaoDb.recuperarInfracoes(userId);
      } catch (localError) {
        throw Exception(
            'Erro ao carregar infrações: $e\nLocal error: $localError');
      }
    }
    notifyListeners();
  }

  Future<void> _syncWithLocalDb(List<Infracao> infracoes, String userId) async {
    try {
      final existingInfracoes = await _infracaoDb.recuperarInfracoes(userId);
      for (var infracao in existingInfracoes) {
        await _infracaoDb.excluirInfracao(infracao.id);
      }

      for (var infracao in infracoes) {
        await _infracaoDb.adicionarInfracao(infracao);
      }
    } catch (e) {
      print('Error syncing with local database: $e');
    }
  }

  Future<void> excluirInfracao(String id) async {
    final url = Uri.parse('$_baseUrl/infracoes/$id.json');

    try {
      final infracao = _infracoes.firstWhere((inf) => inf.id == id);
      if (!infracao.quitada) {
        throw Exception(
            'A infração não pode ser excluída porque não está quitada.');
      }

      final response = await http.delete(url);

      if (response.statusCode == 200) {
        _infracoes.removeWhere((inf) => inf.id == id);
        notifyListeners();
      } else {
        throw Exception('Falha ao excluir a infração.');
      }
    } catch (e) {
      throw Exception('Erro ao excluir infração: $e');
    }
  }
}
