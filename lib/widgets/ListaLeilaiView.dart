import 'package:detranapp/models/Leilao.dart';
import 'package:flutter/material.dart';

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
              color: Colors.black54,
              child: Column(
                children: [
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
