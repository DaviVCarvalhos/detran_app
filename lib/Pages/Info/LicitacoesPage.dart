import 'package:flutter/material.dart';
import 'package:detranapp/Pages/PDFViewPage.dart';

class LicitacoesPage extends StatelessWidget {
  const LicitacoesPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> pdfs = [
      {
        'title': 'Aviso aos Licitantes - PE 07/2022',
        'path': 'assets/pdfs/AvisoLicitantesPE072022.pdf'
      },
      {'title': 'Edital PE 07/2022', 'path': 'assets/pdfs/EditalPE072022.pdf'},
      {
        'title': 'Aviso aos Licitantes - PE 08/2022',
        'path': 'assets/pdfs/AvisoPE082022.pdf'
      },
      {'title': 'Edital PE 08/2022', 'path': 'assets/pdfs/EditalPE082022.pdf'},
      {
        'title': 'REVOGAÇÃO PE 07/2022',
        'path': 'assets/pdfs/DOE_Revogacao.pdf'
      },
      {
        'title': 'Aviso aos Licitantes - PE 09/2022',
        'path': 'assets/pdfs/AvisoPE092022.pdf'
      },
      {'title': 'Edital PE 09/2022', 'path': 'assets/pdfs/EditalPE092022.pdf'},
      {
        'title': 'Aviso aos Licitantes - PE 05/2022',
        'path': 'assets/pdfs/AvisoPE052022.pdf'
      },
      {'title': 'Edital PE 05/2022', 'path': 'assets/pdfs/EditalPE052022.pdf'},
      {
        'title': 'Aviso aos Licitantes - PE 10/2022',
        'path': 'assets/pdfs/AvisoPE102022.pdf'
      },
    ];

    return PDFViewPage(
      pdfs: pdfs,
    );
  }
}
