import 'package:flutter/material.dart';

class PostosAtendimentoPage extends StatelessWidget {
  const PostosAtendimentoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF17A2B8),
        title: const Text('Postos de Atendimento'),
      ),
      body: Container(
        color: Colors.white, // Cor de fundo da página
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SEDE-DETRAN/RN\n'
                'Endereço: Av. Perimetral Leste, 113, Cidade da Esperança, Natal/RN, 59071-445\n'
                'Horário de Funcionamento: Segunda a Sexta, das 8 às 14h.\n\n',
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
              Text(
                'CENTRAL DO CIDADÃO ZONA SUL\n'
                'Endereço: Avenida Governador José Varela, nº 2900, Capim Macio (por trás da Comjol, da Av. Engenheiro Roberto Freire)\n'
                'Horário de Funcionamento: Segunda a Sexta, das 07h às 18h.\n\n',
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
              Text(
                'CENTRAL DO CIDADÃO ALECRIM\n'
                'Endereço: Av. Coronel Estevam, 1233, Alecrim, Natal/RN, 59.030-000\n'
                'Horário de Funcionamento: Segunda a Sexta, das 07h às 17h.\n\n',
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
              Text(
                'CENTRAL DO CIDADÃO ZONA NORTE\n'
                'Endereço: Av. Doutor Joao Medeiros Filho, 896, Potengi (em frente à área de lazer do Panatis)\n'
                'Horário de Funcionamento: Segunda a Sexta, das 07h às 19h.\n\n',
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
              Text(
                '3ª CIRETRAN - PARNAMIRIM\n'
                'Endereço: Av. Tenente Medeiros, s/n, Centro, Parnamirim/RN, 59.140-000\n'
                'Horário de Funcionamento: Segunda a Sexta, das 08h às 14h.\n',
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
