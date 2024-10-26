import 'package:flutter/material.dart';

class PostosAtendimentoPage extends StatelessWidget {
  const PostosAtendimentoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFBEE5EB),
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildInfoCard(
              'SEDE-DETRAN/RN',
              'Av. Perimetral Leste, 113, Cidade da Esperança, Natal/RN, 59071-445',
              'Segunda a Sexta, das 8 às 14h.',
            ),
            buildInfoCard(
              'CENTRAL DO CIDADÃO ZONA SUL',
              'Avenida Governador José Varela, nº 2900, Capim Macio (por trás da Comjol, da Av. Engenheiro Roberto Freire)',
              'Segunda a Sexta, das 07h às 18h.',
            ),
            buildInfoCard(
              'CENTRAL DO CIDADÃO ALECRIM',
              'Av. Coronel Estevam, 1233, Alecrim, Natal/RN, 59.030-000',
              'Segunda a Sexta, das 07h às 17h.',
            ),
            buildInfoCard(
              'CENTRAL DO CIDADÃO ZONA NORTE',
              'Av. Doutor João Medeiros Filho, 896, Potengi (em frente à área de lazer do Panatis)',
              'Segunda a Sexta, das 07h às 19h.',
            ),
            buildInfoCard(
              '3ª CIRETRAN - PARNAMIRIM',
              'Av. Tenente Medeiros, s/n, Centro, Parnamirim/RN, 59.140-000',
              'Segunda a Sexta, das 08h às 14h.',
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInfoCard(String title, String address, String hours) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.blue),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    address,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.access_time, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  hours,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
