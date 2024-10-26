import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:detranapp/Pages/Info/PDFViewPage.dart';

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

    return Scaffold(
      body: Container(
        color: Color(0xFFBEE5EB), // Cor de fundo do Container
        child: ListView.builder(
          padding: EdgeInsets.all(5.0),
          itemCount: pdfs.length,
          itemBuilder: (context, index) {
            final pdf = pdfs[index];
            return buildPdfCard(context, pdf['title']!,
                pdf['path']!); // Constrói o cartão para cada PDF
          },
        ),
      ),
    );
  }

  Widget buildPdfCard(BuildContext context, String title, String pdfPath) {
    return Card(
        margin: EdgeInsets.symmetric(vertical: 5.0),
        child: SizedBox(
          height: 60.0,
          child: ListTile(
            title: Text(
              title,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
            ),
            trailing: Icon(
              Icons.picture_as_pdf,
              color: Colors.red,
            ),
            onTap: () async {
              final tempFilePath = await _copyAssetToLocal(pdfPath);
              if (tempFilePath != null) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => PDFViewPage(filePath: tempFilePath),
                  ),
                );
              }
            },
          ),
        ));
  }

  Future<String?> _copyAssetToLocal(String assetPath) async {
    try {
      final byteData = await rootBundle.load(assetPath);
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/${assetPath.split('/').last}');
      await file.writeAsBytes(byteData.buffer.asUint8List());
      return file.path;
    } catch (e) {
      print('Erro ao copiar o arquivo: $e');
      return null;
    }
  }
}
