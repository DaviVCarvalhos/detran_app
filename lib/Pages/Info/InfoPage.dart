import 'package:detranapp/Pages/Info/FAQPage.dart';
import 'package:detranapp/Pages/Info/FiscalizacaoPage.dart';
import 'package:detranapp/Pages/Info/PostosAtendimentosPage.dart';
import 'package:detranapp/Pages/Info/PostosInteriorPage.dart';
import 'package:detranapp/Pages/Info/LicitacoesPage.dart';
import 'package:flutter/material.dart';
import 'package:detranapp/widgets/DetranTitle.dart';
import 'package:detranapp/Pages/WebViewPage.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  Widget _currentPage = PostosAtendimentoPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: DetranTitle(),
        backgroundColor: Color(0xFF17A2B8),
        leading: BackButton(
          color: Colors.white,
        ),
         iconTheme: IconThemeData(
    color: Colors.white, // Cor do ícone do Drawer
  ),
        centerTitle: true,
      ),
      endDrawer: Drawer(
        backgroundColor: Color(0xFFBEE5EB),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF17A2B8),
              ),
              child: Text(
                'Outras Informações',
                style: TextStyle(
                  color: Color(0xFFBEE5EB),
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.arrow_circle_right_outlined),
              title: Text('Postos de atendimento na Grande Natal'),
              onTap: () {
                setState(() {
                  _currentPage = PostosAtendimentoPage();
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.arrow_circle_right_outlined),
              title: Text('Postos de atendimento no Interior'),
              onTap: () {
                setState(() {
                  _currentPage = PostosInteriorPage();
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.arrow_circle_right_outlined),
              title: Text('Licitações'),
              onTap: () {
                setState(() {
                  _currentPage = LicitacoesPage();
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.arrow_circle_right_outlined),
              title: Text('Fiscalização'),
              onTap: () {
                setState(() {
                  _currentPage = FiscalizacaoPage();
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.open_in_new),
              title: Text('Ouvidoria'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WebViewPage(
                      url: 'https://falabr.cgu.gov.br/web/home',
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.arrow_circle_right_outlined),
              title: Text('Fale Conosco'),
              onTap: () {
                setState(() {
                  _currentPage = FAQPage();
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.smart_display),
              title: Text('Dúvidas cadastro'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WebViewPage(
                      url: 'https://www.youtube.com/watch?v=cYA8-QpEHT4',
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: _currentPage,
    );
  }
}
