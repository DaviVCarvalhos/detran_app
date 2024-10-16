import 'package:detranapp/models/Leilao.dart';
import 'package:detranapp/widgets/DetranTitle.dart';
import 'package:flutter/material.dart';

class LeilaoPage extends StatefulWidget {
   LeilaoPage({super.key});

  @override
  State<LeilaoPage> createState() => _LeilaoPageState();
}

class _LeilaoPageState extends State<LeilaoPage> {
  final List<Leilao> leiloes = [
    Leilao(dataleilao: '28/02/2023', descricao: 'LEILÃO DE VEICULOS 2024 - 08º (Edital 008/2024) DETRAN-CREDENCIADA- SEI: 02910034.001604/2024-05'),
    Leilao(dataleilao: '12/12/2022', descricao: 'LEILÃO DE VEICULOS 2024 - 04º (Edital 004/2024) DETRAN-CREDENCIADA'),
    Leilao(dataleilao: '30/11/2022', descricao: 'LEILÃO DE VEICULOS 2022 - 5º (Edital 005/2022) DETRAN-DEGEPOL'),
    Leilao(dataleilao: '30/11/2022', descricao: 'LEILÃO DE VEICULOS 2022 - 5º (Edital 005/2022) DETRAN-DEGEPOL'),
    Leilao(dataleilao: '30/11/2022', descricao: 'LEILÃO DE VEICULOS 2022 - 5º (Edital 005/2022) DETRAN-DEGEPOL'),
    Leilao(dataleilao: '30/11/2022', descricao: 'LEILÃO DE VEICULOS 2022 - 5º (Edital 005/2022) DETRAN-DEGEPOL'),
    Leilao(dataleilao: '30/11/2022', descricao: 'LEILÃO DE VEICULOS 2022 - 5º (Edital 005/2022) DETRAN-DEGEPOL'),
    Leilao(dataleilao: '30/11/2022', descricao: 'LEILÃO DE VEICULOS 2022 - 5º (Edital 005/2022) DETRAN-DEGEPOL'),
  ];
List<Leilao> filteredLeiloes = [];

@override
  void initState() {
    super.initState();
    
    filteredLeiloes = leiloes;
  }

// Função para filtrar a lista com base na pesquisa
  void _filterLeiloes(String query) {
    List<Leilao> results = [];
    if (query.isEmpty) {
      
      results = leiloes;
    } else {
      results = leiloes
          .where((leilao) =>
              leilao.descricao.toLowerCase().contains(query.toLowerCase()) ||
              leilao.dataleilao.contains(query))
          .toList();
    }

    
    setState(() {
      filteredLeiloes = results;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: DetranTitle(),
        
        backgroundColor:  const Color.fromARGB(255, 0, 128, 198),
        leading: BackButton(color: Colors.white,),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                _filterLeiloes(value); 
              },
              decoration: InputDecoration(
                labelText: 'Buscar Leilões',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
              ),
            ),
          ),
          Expanded(
        child: ListView.builder(
          itemCount: filteredLeiloes.length, 
          itemBuilder: (context, index) {
            
            return Card(
              child: ListTile(
                title: Text(filteredLeiloes[index].descricao),
                subtitle: Text(filteredLeiloes[index].dataleilao),
              ),
            );
          },
        ),
      ),
        ]
      )
    );
  }
}
