import 'package:flutter/material.dart';

class Nenhumeditalpage extends StatelessWidget {
  const Nenhumeditalpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Nenhum edital foi encontrado',
          style: TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }
}
