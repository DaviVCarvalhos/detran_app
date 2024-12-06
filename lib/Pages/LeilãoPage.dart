import 'package:detranapp/models/Leilao.dart';
import 'package:detranapp/widgets/DetranTitle.dart';
import 'package:detranapp/widgets/ListaLeilaiView.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class LeilaoPage extends StatefulWidget {
  LeilaoPage({super.key});

  @override
  State<LeilaoPage> createState() => _LeilaoPageState();
}

class _LeilaoPageState extends State<LeilaoPage> {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref('leilao');
  List<Leilao> leiloes = [];
  List<Leilao> filteredLeiloes = [];

  @override
  void initState() {
    super.initState();
    _fetchLeiloes();
  }

  // Busca os dados do Firebase
  void _fetchLeiloes() {
    _dbRef.onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;

      if (data != null) {
        final fetchedLeiloes = data.entries
            .map((e) => Leilao.fromJson(Map<String, dynamic>.from(e.value)))
            .toList();

        setState(() {
          leiloes = fetchedLeiloes;
          filteredLeiloes = leiloes;
        });
      }
    });
  }

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
        backgroundColor: const Color.fromARGB(255, 52, 58, 64),
        leading: BackButton(color: Colors.white),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _filterLeiloes,
              decoration: InputDecoration(
                labelText: 'Buscar Leilões',
                prefixIcon: Icon(Icons.search,
                    color: const Color.fromARGB(255, 52, 58, 64)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide:
                      BorderSide(color: const Color.fromARGB(255, 52, 58, 64)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                      BorderSide(color: const Color.fromARGB(255, 52, 58, 64)),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListaLeilaoView(filteredLeiloes: filteredLeiloes),
          ),
        ],
      ),
    );
  }
}
