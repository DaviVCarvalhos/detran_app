import 'package:firebase_database/firebase_database.dart';

class Leilao {
  final String dataleilao;
  final String descricao;

  Leilao({required this.dataleilao, required this.descricao});

  factory Leilao.fromJson(Map<String, dynamic> json) {
    return Leilao(
      dataleilao: json['dataleilao'] as String,
      descricao: json['descricao'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dataleilao': dataleilao,
      'descricao': descricao,
    };
  }

  void adicionarLeiloesAoFirebase() async {
    // Instância de referência ao Realtime Database
    final DatabaseReference dbRef = FirebaseDatabase.instance.ref('leilao');

    // Lista de leilões
    final List<Leilao> leiloes = [
      Leilao(
          dataleilao: '28/02/2023',
          descricao:
              'LEILÃO DE VEICULOS 2024 - 08º (Edital 008/2024) DETRAN-CREDENCIADA- SEI: 02910034.001604/2024-05'),
      Leilao(
          dataleilao: '12/12/2022',
          descricao:
              'LEILÃO DE VEICULOS 2024 - 04º (Edital 004/2024) DETRAN-CREDENCIADA'),
      Leilao(
          dataleilao: '30/11/2022',
          descricao:
              'LEILÃO DE VEICULOS 2022 - 5º (Edital 005/2022) DETRAN-DEGEPOL'),
      Leilao(
          dataleilao: '30/11/2022',
          descricao:
              'LEILÃO DE VEICULOS 2022 - 5º (Edital 005/2022) DETRAN-DEGEPOL'),
      Leilao(
          dataleilao: '30/11/2022',
          descricao:
              'LEILÃO DE VEICULOS 2022 - 5º (Edital 005/2022) DETRAN-DEGEPOL'),
      Leilao(
          dataleilao: '30/11/2022',
          descricao:
              'LEILÃO DE VEICULOS 2022 - 5º (Edital 005/2022) DETRAN-DEGEPOL'),
      Leilao(
          dataleilao: '30/11/2022',
          descricao:
              'LEILÃO DE VEICULOS 2022 - 5º (Edital 005/2022) DETRAN-DEGEPOL'),
      Leilao(
          dataleilao: '30/11/2022',
          descricao:
              'LEILÃO DE VEICULOS 2022 - 5º (Edital 005/2022) DETRAN-DEGEPOL'),
    ];

    // Adiciona os leilões ao Firebase
    for (Leilao leilao in leiloes) {
      await dbRef.push().set(leilao.toJson());
    }

    print("Leilões adicionados ao Firebase com sucesso!");
  }
}
