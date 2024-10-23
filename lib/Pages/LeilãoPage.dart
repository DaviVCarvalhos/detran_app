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
        
        backgroundColor:   const Color.fromARGB(255, 52, 58, 64),
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
                  labelStyle: TextStyle(color: const Color.fromARGB(255, 52, 58, 64),),
                  prefixIcon: Icon(Icons.search,
                  color:const Color.fromARGB(255, 52, 58, 64),
                  
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    borderSide: BorderSide(color: const Color.fromARGB(255, 52, 58, 64), )
                    
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    borderSide: BorderSide(color: const Color.fromARGB(255, 52, 58, 64), )
                  )
                ),
            ),
          ),
          Expanded(
        child: ListaLeilaoView(filteredLeiloes: filteredLeiloes),
      ),
        ]
      )
    );
  }
}

class ListaLeilaoView extends StatelessWidget {
  const ListaLeilaoView({
    super.key,
    required this.filteredLeiloes,
  });

  final List<Leilao> filteredLeiloes;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: filteredLeiloes.length,
      itemBuilder: (context, index) {
        return Card(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              color: Colors.black54, // Cor de fundo geral do card
              child: Column(
                children: [
                  // Título com fundo separado
                  Container(
                     // Cor de fundo do título
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      filteredLeiloes[index].dataleilao,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Cor do texto do título
                        fontSize: 18.0,
                      ),
                    ),
                  ),
            
                  // Linha divisória
                  Divider(
                    
                    thickness: 0.5, 
                    height: 0, 
                  ),
            
                  // Subtítulo com fundo separado
                  Container(
                    color: Colors.black38, // Cor de fundo do subtítulo
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      filteredLeiloes[index].descricao,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Cor do texto do subtítulo
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}