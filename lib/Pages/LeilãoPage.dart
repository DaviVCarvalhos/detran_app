import 'package:flutter/material.dart';

class LeilaoPage extends StatelessWidget {
  const LeilaoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leilão'),
      ),
      body: const Center(
        child: Text('Você está na página de leilão'),
      ),
    );
  }
}