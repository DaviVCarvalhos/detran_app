import 'Agendamento.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AgendamentoProvider with ChangeNotifier {
  final String _baseUrl =
      'https://detranapp-75e56-default-rtdb.firebaseio.com/';
  List<Agendamento> _agendamentos = [];

  List<Agendamento> get agendamentos => _agendamentos;

  Future<void> carregarAgendamentos(String userId) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/agendamentos.json'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        _agendamentos = data.entries.where((entry) {
          final agendamentoData = entry.value;

          final userIdValue = agendamentoData['userId'];

          return userIdValue != null && userIdValue == userId;
        }).map((entry) {
          final id = entry.key;
          final agendamentoData = entry.value;
          return Agendamento.fromJson(id, agendamentoData);
        }).toList();
        notifyListeners();
      } else {
        throw Exception(
            'Falha ao carregar agendamentos: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao carregar agendamentos: $e');
    }
  }

  Future<void> adicionarAgendamento(Agendamento agendamento) async {
    final url = Uri.parse('$_baseUrl/agendamentos.json');

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'categoria': agendamento.categoria,
          'data': agendamento.data,
          'horario': agendamento.horario,
          'servico': agendamento.servico,
          'userId': agendamento.userId,
          'local': agendamento.local,
        }),
      );

      if (response.statusCode == 200) {
        final id = json.decode(response.body)['name'];
        final newAgendamento = Agendamento.fromJson(id, {
          'categoria': agendamento.categoria,
          'data': agendamento.data,
          'horario': agendamento.horario,
          'servico': agendamento.servico,
          'userId': agendamento.userId,
          'local': agendamento.local,
        });

        _agendamentos.add(newAgendamento);
        notifyListeners();
      } else {
        throw Exception('Falha ao adicionar o agendamento');
      }
    } catch (e) {
      throw Exception('Erro ao adicionar agendamento: $e');
    }
  }

  Future<void> excluirAgendamento(String id) async {
    final url = Uri.parse('$_baseUrl/agendamentos/$id.json');

    try {
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        _agendamentos.removeWhere((agendamento) => agendamento.id == id);
        notifyListeners();
      } else {
        throw Exception('Falha ao excluir o agendamento');
      }
    } catch (e) {
      throw Exception('Erro ao excluir agendamento: $e');
    }
  }

  Future<void> editarAgendamento(String id, Agendamento agendamento) async {
    final url = Uri.parse('$_baseUrl/agendamentos/$id.json');

    try {
      final response = await http.patch(
        url,
        body: json.encode({
          'categoria': agendamento.categoria,
          'data': agendamento.data,
          'horario': agendamento.horario,
          'servico': agendamento.servico,
          'userId': agendamento.userId,
          'local': agendamento.local,
        }),
      );

      if (response.statusCode == 200) {
        notifyListeners();
      } else {
        throw Exception('Falha ao editar o agendamento');
      }
    } catch (e) {
      throw Exception('Erro ao editar agendamento: $e');
    }
  }
}
