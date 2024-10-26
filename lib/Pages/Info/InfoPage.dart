import 'package:detranapp/Pages/Info/PostosAtendimentosPage.dart';
import 'package:detranapp/Pages/Info/PostosInteriorPage.dart';
import 'package:detranapp/Pages/Info/LicitacoesPage.dart';
import 'package:flutter/material.dart';
import 'package:detranapp/widgets/DetranTitle.dart';

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
              title: Text('Postos de atendimento na Grande Natal'),
              onTap: () {
                setState(() {
                  _currentPage = PostosAtendimentoPage();
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Postos de atendimento no Interior'),
              onTap: () {
                setState(() {
                  _currentPage = PostosInteriorPage();
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Licitações'),
              onTap: () {
                setState(() {
                  _currentPage = LicitacoesPage();
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: _currentPage,
    );
  }
}
