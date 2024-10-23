import 'package:detranapp/models/Leilao.dart';
import 'package:flutter/material.dart';

class LeilaoPage extends StatefulWidget {
   LeilaoPage({super.key});

  @override
  State<LeilaoPage> createState() => _LeilaoPageState();
}

class _LeilaoPageState extends State<LeilaoPage> {
  final List<Leilao> leiloes = [
    Leilao(dataleilao: '2024-10-14', descricao: 'Leilão de Carros'),
    Leilao(dataleilao: '2024-10-15', descricao: 'Leilão de Imóveis'),
    Leilao(dataleilao: '2024-10-16', descricao: 'Leilão de Motos'),
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

    // Atualiza o estado com a lista filtrada
    setState(() {
      filteredLeiloes = results;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leilão',
        style: TextStyle(
          
          color: Colors.white,
        ),
        
        ),
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
