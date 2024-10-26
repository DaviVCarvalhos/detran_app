import 'package:flutter/material.dart';

class InfracoesPage extends StatelessWidget {
  const InfracoesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFdc3545),
        title: const Text('Consultar Infração'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(12.0),
                color: const Color(0xFFD1ECF1),
                child: const Text(
                  'Digite as informações abaixo sem pontos nem hifens.',
                  style: TextStyle(color: Color(0xFF0C5460)),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12.0),
                color: const Color(0xFFD1ECF1),
                child: const Text(
                  'Informe o número do auto de infração igualmente a sua notificação de autuação.',
                  style: TextStyle(color: Color(0xFF0C5460)),
                ),
              ),
              const SizedBox(height: 16),
              const TextField(
                  decoration:
                      InputDecoration(labelText: 'Placa', hintText: '')),
              const SizedBox(height: 16),
              const TextField(
                  decoration:
                      InputDecoration(labelText: 'Renavam', hintText: '')),
              const SizedBox(height: 16),
              const TextField(
                decoration: InputDecoration(
                  labelText: "CPF ou CNPJ do Proprietário",
                  hintText: "",
                ),
              ),
              const SizedBox(height: 8),
              const TextField(
                  decoration: InputDecoration(
                labelText:
                    "DIGITAR O Nº DO AUTO DE INFRAÇÃO EXATAMENTE IGUAL AO DA NOTIFICAÇÃO",
                hintText: "",
              )),
              const SizedBox(height: 16),
              const Text(
                'Número do Auto de Infração - Exemplos de autos aceitáveis: X 00000000 (digitar o espaço) | XX00000000',
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Função para realizar a consulta
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF007bff),
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Consultar',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}