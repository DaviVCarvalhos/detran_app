


import 'package:flutter/material.dart';
import '/Pages/ConsultarVeiculoPage.dart';
class ConsultarVeiculoButton extends StatelessWidget {
  final double width;
  final double height;

  const ConsultarVeiculoButton({
    super.key,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.directions_car),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  const ConsultarVeiculoPage()),
        );
      },
      iconSize: height, // O tamanho do ícone agora é baseado na altura disponível do widget
      color: Colors.white,
    );
  }
}