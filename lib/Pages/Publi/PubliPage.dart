import 'package:detranapp/Pages/Publi/EditalDiarioPage.dart';
import 'package:detranapp/Pages/Publi/ListDevolucoesPage.dart';
import 'package:detranapp/Pages/Publi/NenhumEditalPage.dart';
import 'package:detranapp/Pages/Publi/NenhumPubliPage.dart';
import 'package:detranapp/Pages/Publi/PubliCetranPage.dart';
import 'package:flutter/material.dart';
import 'package:detranapp/widgets/DetranTitle.dart';

class Publipage extends StatefulWidget {
  const Publipage({super.key});

  @override
  _PubliPageState createState() => _PubliPageState();
}

class _PubliPageState extends State<Publipage> {
  Widget _currentPage = Publicetranpage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: DetranTitle(),
        backgroundColor: Color(0xFF6D7C8C),
        leading: BackButton(
          color: Colors.white,
        ),
        centerTitle: true,
      ),
      endDrawer: Drawer(
        backgroundColor: Color(0xFFC6D1DC),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF6D7C8C),
              ),
              child: Text(
                'Publicações Detran',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'Publicações',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.arrow_circle_right_outlined),
              title: Text('Editais Saldo Remanescente'),
              onTap: () {
                setState(() {
                  _currentPage = Nenhumeditalpage();
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.arrow_circle_right_outlined),
              title: Text('Publicações Jari'),
              onTap: () {
                setState(() {
                  _currentPage = Nenhumpublipage();
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.arrow_circle_right_outlined),
              title: Text('Publicações Cetran'),
              onTap: () {
                setState(() {
                  _currentPage = Publicetranpage();
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.arrow_circle_right_outlined),
              title: Text('Outras Publicações'),
              onTap: () {
                setState(() {
                  _currentPage = Nenhumpublipage();
                });
                Navigator.pop(context);
              },
            ),
            Divider(
              thickness: 2.0,
              color: Color(0xFF6D7C8C),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'Acordo Judicial Detran Ministério Público Estadual',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.arrow_circle_right_outlined),
              title: Text('Edital Diário'),
              onTap: () {
                setState(() {
                  _currentPage = Editaldiariopage();
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.arrow_circle_right_outlined),
              title: Text('Listagem de Devoluções'),
              onTap: () {
                setState(() {
                  _currentPage = ListDevolucoesPage();
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.arrow_circle_right_outlined),
              title: Text('Requerimento de Devoluções'),
              onTap: () {
                setState(() {
                  _currentPage = Publicetranpage();
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
