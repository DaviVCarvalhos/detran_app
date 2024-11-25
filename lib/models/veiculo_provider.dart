import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'veiculo.dart';

class VeiculoProvider with ChangeNotifier {
  final _baseUrl = 'https://detranapp-75e56-default-rtdb.firebaseio.com/';
  Veiculo? veiculoPesquisado;

  Future<void> pesquisarVeiculo(String placa, String renavam) async {
    final url = Uri.parse('$_baseUrl/veiculos.json');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic>? data = json.decode(response.body);
      if (data != null) {
        for (final entry in data.entries) {
          final veiculo = Veiculo.fromJson(entry.key, entry.value);
          if (veiculo.placa == placa && veiculo.renavam == renavam) {
            veiculoPesquisado = veiculo;
            notifyListeners();
            return;
          }
        }
      }
    }
    veiculoPesquisado = null;
    notifyListeners();
  }

  Future<void> adicionarVeiculoAoUsuario(String userId, Veiculo veiculo) async {
    final url =
        Uri.parse('$_baseUrl/users/$userId/meusVeiculos/${veiculo.id}.json');

    final response = await http.put(
      url,
      body: json.encode(true),
    );

    if (response.statusCode == 200) {
      notifyListeners();
    } else {
      throw Exception('Erro ao adicionar veículo ao usuário');
    }
  }
}
