import 'package:detranapp/models/User.dart';
import 'package:detranapp/models/Veiculo.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UserProvider extends ChangeNotifier {
  User? _user;

  List<Veiculo> _veiculos = [];

  Future<void> fetchVeiculosByUserId(int userId) async {
    try {
      final url = Uri.parse('https://seuservidor.com/api/veiculos');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> _veiculosJson = jsonDecode(response.body);

        _veiculosJson.forEach((id, veiculo) {
          if (veiculo.nomeProprietario == _user!.nome) {
            veiculos.add(Veiculo.fromJson(id, veiculo));
          }
        });
        if (veiculos.isNotEmpty) notifyListeners();
      } else {
        throw Exception('Erro ao carregar os veículos');
      }
    } catch (e) {
      throw Exception('Erro ao buscar os veículos: $e');
    }
  }

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void addVeiculo(Veiculo veiculo) {
    _veiculos.add(veiculo);
    notifyListeners();
  }

  User? get user => _user;

  List<Veiculo> get veiculos => _veiculos;
}
