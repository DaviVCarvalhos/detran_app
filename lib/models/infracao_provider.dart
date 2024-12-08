import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:detranapp/models/Infracao.dart';

class InfracaoProvider with ChangeNotifier {
  List<Infracao> _infracoes = [];
  List<Infracao> get infracoes => _infracoes;

  // Definindo o método de busca com filtros
  Future<void> fetchInfracoesComFiltros({
    String? numeroInfracao,
    String? cpf,
    String? renavam,
    String? placa,
  }) async {
    final databaseReference = FirebaseDatabase.instance.ref('infracoes');

    try {
      final snapshot = await databaseReference.get();

      if (snapshot.exists) {
        _infracoes = []; // Limpando as infrações atuais antes de adicionar as novas

        for (var entry in snapshot.children) {
          final infracao = Infracao.fromJson(entry.key!, Map<String, dynamic>.from(entry.value as Map));

          // Verificando os filtros
          if ((numeroInfracao == null || numeroInfracao.isEmpty || infracao.nInfracao == numeroInfracao) &&
              (cpf == null || cpf.isEmpty || infracao.cpf == cpf) &&
              (renavam == null || renavam.isEmpty || infracao.renavam == renavam) &&
              (placa == null || placa.isEmpty || infracao.placa == placa)) {
            _infracoes.add(infracao);
          }
        }

        notifyListeners(); // Atualiza os ouvintes após a busca
      } else {
        _infracoes = [];
        notifyListeners();
      }
    } catch (e) {
      print('Erro ao buscar infrações: $e');
    }
  }

  // Marca a infração como quitada
  Future<void> marcarComoQuitada(String id) async {
    final databaseReference = FirebaseDatabase.instance.ref('infracoes/$id');

    try {
      await databaseReference.update({'quitada': true});
      _infracoes = _infracoes.map((infracao) {
        if (infracao.id == id) {
          return infracao.copyWith(quitada: true);  // Usando copyWith para simplificar a atualização
        }
        return infracao;
      }).toList();
      notifyListeners();
    } catch (e) {
      print('Erro ao marcar infração como quitada: $e');
    }
  }

  // Exclui uma infração do Firebase
  Future<void> deletarInfracao(String id) async {
    final databaseReference = FirebaseDatabase.instance.ref('infracoes/$id');

    try {
      await databaseReference.remove();
      _infracoes.removeWhere((infracao) => infracao.id == id);
      notifyListeners();
    } catch (e) {
      print('Erro ao deletar infração: $e');
    }
  }
}

