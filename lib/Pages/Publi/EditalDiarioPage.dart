import 'package:flutter/material.dart';
import 'package:detranapp/Pages/PDFViewPage.dart';

class Editaldiariopage extends StatelessWidget {
  const Editaldiariopage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> pdfs = [
      {
        'title': 'Edital de Chamamento Devolução de Valores Pagos de Multa',
        'path':
            'assets/pdfs/Edital_de_Chamamento_Devolução_de_Valores_Pagos_de_Multa.pdf'
      },
    ];
    return PDFViewPage(
      pdfs: pdfs,
    );
  }
}
