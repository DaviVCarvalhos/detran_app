import 'package:flutter/material.dart';
import 'package:detranapp/Pages/PDFViewPage.dart';

class FiscalizacaoPage extends StatelessWidget {
  const FiscalizacaoPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista de PDFs específicos para Licitações
    List<Map<String, String>> pdfs = [
      {
        'title': 'Planilha de Resolução',
        'path': 'assets/pdfs/PLANILHA_RESOL_798_RN 301.pdf'
      },
    ];
    return PDFViewPage(
      pdfs: pdfs,
    );
  }
}
