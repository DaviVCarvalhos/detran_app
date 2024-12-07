import 'package:detranapp/models/Veiculo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VeiculoProvider with ChangeNotifier {
  final _baseUrl = 'https://detranapp-75e56-default-rtdb.firebaseio.com/';
  Veiculo? veiculoPesquisado;

  List<Veiculo> _veiculos = [];
  List<Veiculo> get veiculos => _veiculos;

  // Future<List<Veiculo>> getVeiculosFromUser(String userId) {}

  Future<void> adicionarVeiculo(Veiculo veiculo) async {
    final response = await http.post(Uri.parse('$_baseUrl/veiculos.json'),
        body: json.encode(veiculo.toJson()));
    notifyListeners();
    if (response.statusCode != 200) {
      throw Exception('Failed to add veiculo');
    }
  }

  Future<Veiculo> pesquisarVeiculo(String placa, String renavam) async {
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
            return veiculo;
          }
        }
      }
    }
    throw Exception('Veículo não encontrado.');
  }

  Future<List<Veiculo>> buscarVeiculosDoUsuario(String userId) async {
    final url = Uri.parse('$_baseUrl/users/$userId/meusVeiculos.json');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // Se não há veículos, retorna lista vazia
        if (response.body == 'null') {
          return [];
        }

        // Converte o JSON de meusVeiculos para identificar os IDs dos veículos
        Map<String, dynamic> meusVeiculosMap = json.decode(response.body);

        // Filtra os IDs dos veículos que o usuário possui (valor = true)
        List<String> veiculosIds = meusVeiculosMap.keys
            .where((key) => meusVeiculosMap[key] == true)
            .toList();

        // Se não há veículos, retorna lista vazia
        if (veiculosIds.isEmpty) {
          return [];
        }

        // Busca os detalhes de cada veículo
        List<Veiculo> veiculos = [];
        for (String veiculoId in veiculosIds) {
          final veiculoUrl = Uri.parse('$_baseUrl/veiculos/$veiculoId.json');
          final veiculoResponse = await http.get(veiculoUrl);

          if (veiculoResponse.statusCode == 200) {
            // Verifica se o corpo não é nulo
            if (veiculoResponse.body != 'null') {
              Map<String, dynamic> veiculoData =
                  json.decode(veiculoResponse.body);
              veiculos.add(Veiculo.fromJson(veiculoId, veiculoData));
            }
          }
        }

        return veiculos;
      } else {
        throw Exception('Erro ao buscar veículos do usuário');
      }
    } catch (e) {
      print('Erro na busca de veículos: $e');
      return [];
    }
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
