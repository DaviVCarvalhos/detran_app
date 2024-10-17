import 'package:detranapp/Pages/Info/PostosAtendimentosPage.dart';
import 'package:detranapp/Pages/Info/PostosInteriorPage.dart';
import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF17A2B8),
        title: const Text('Informações'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: const Color(0xFFBEE5EB),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              ListTile(
                trailing: const Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                ),
                title: const Text(
                  'Postos de atendimento na Grande Natal',
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PostosAtendimentoPage(),
                    ),
                  );
                },
              ),
              ListTile(
                trailing: const Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                ),
                title: const Text(
                  'Postos de atendimento no Interior',
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PostosInteriorpage(),
                    ),
                  );
                },
              ),
              ListTile(
                trailing: const Icon(
                  Icons.arrow_forward,
                  color: Colors.black,
                ),
                title: const Text(
                  'Licitações',
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PostosInteriorpage(),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
