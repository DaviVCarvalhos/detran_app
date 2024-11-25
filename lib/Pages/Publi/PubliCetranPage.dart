import 'package:flutter/material.dart';
import 'package:detranapp/Pages/PDFViewPage.dart';

class Publicetranpage extends StatelessWidget {
  const Publicetranpage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> pdfs = [
      {
        'title': 'Resolução CETRAN Nº 001-2024',
        'path': 'assets/pdfs/RESOLUCAO_CETRAN_001-2024_SDOE_08_08.pdf'
      },
      {
        'title': 'Fluxograma de Acidentes de Trânsito com Vítimas Fatais',
        'path': 'assets/pdfs/FLUXO_COM_VÍTIMAS_FATAIS.pdf'
      },
      {
        'title': 'Fluxograma de Acidentes de Trânsito com Vítimas',
        'path': 'assets/pdfs/FLUXO_COM_VÍTIMAS.pdf'
      },
      {
        'title': 'Fluxograma de Acidentes de Trânsito sem Vítimas',
        'path': 'assets/pdfs/FLUXO_SEM_VÍTIMAS.pdf'
      }
    ];
    return PDFViewPage(
      pdfs: pdfs,
    );
  }
}
