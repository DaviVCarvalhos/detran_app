import 'package:flutter/material.dart';
import '/Pages/InfracoesPage.dart';

class InfracoesButton extends StatelessWidget {
  final double width;
  final double height;

  const InfracoesButton({
    super.key,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.local_police,
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => InfracoesPage()),
        );
      },
      iconSize:
          height, // O tamanho do ícone agora é baseado na altura disponível do widget
      color: Colors.white,
    );
  }
}
