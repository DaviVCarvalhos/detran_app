import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:detranapp/models/Infracao.dart';

class InfracaoProvider with ChangeNotifier {
  final String _baseUrl =
      'https://detranapp-75e56-default-rtdb.firebaseio.com/';
  List<Infracao> _infracoes = [];

  List<Infracao> get infracoes => _infracoes;

  // Função para carregar infrações do usuário logado
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
        notifyListeners();
      } else {
        throw Exception('Falha ao carregar infrações: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao carregar infrações: $e');
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
