import 'package:flutter/material.dart';

class ConsultarVeiculoPage extends StatelessWidget {
  const ConsultarVeiculoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Veículos'),
      ),
      body: const Center(
        child: Text('Você está na página de Consultar Veículos'),
      ),
    );
  }
}