import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class PDFViewPage extends StatelessWidget {
  final List<Map<String, String>> pdfs;

  const PDFViewPage({super.key, required this.pdfs});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFBEE5EB),
        child: ListView.builder(
          padding: EdgeInsets.all(5.0),
          itemCount: pdfs.length,
          itemBuilder: (context, index) {
            final pdf = pdfs[index];
            return buildPdfCard(pdf['title']!, pdf['path']!);
          },
        ),
      ),
    );
  }

  Widget buildPdfCard(String title, String pdfPath) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontSize: 16.0),
        ),
        trailing: Icon(
          Icons.picture_as_pdf,
          color: Colors.red,
        ),
        onTap: () async {
          final tempFilePath = await _copyAssetToLocal(pdfPath);
          if (tempFilePath != null) {
            final result = await OpenFilex.open(tempFilePath);
            if (result.type != ResultType.done) {
              print('Erro ao abrir o PDF: ${result.message}');
            }
          }
        },
      ),
    );
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
