

import 'package:flutter/material.dart';
import '/Pages/LeilãoPage.dart';
class LeilaoButton extends StatelessWidget {
  final double width;
  final double height;

  const LeilaoButton({
    super.key,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.gavel),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LeilaoPage()),
        );
      },
      iconSize: height, // O tamanho do ícone agora é baseado na altura disponível do widget
      color: Colors.white,
    );
  }
}