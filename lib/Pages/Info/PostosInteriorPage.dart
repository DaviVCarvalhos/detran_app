import 'package:flutter/material.dart';

class PostosInteriorPage extends StatelessWidget {
  const PostosInteriorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFBEE5EB),
      padding: EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildInfoCard(
              '1ª CIRETRAN - MOSSORÓ',
              'Centro Administrativo Integrado Diran dos Ramos Amaral, Av. do Contorno, nº 1020, DixSept Rosado, 59.607-042 ',
              'Segunda a Sexta, das 07h às 13h. ',
            ),
            buildInfoCard(
              '2ª CIRETRAN - CAICÓ',
              'Rua Marina Neves Dantas, nº 35, Central do Cidadão, Maynard, 59.300-000',
              'Segunda a Sexta, das 07h às 13h. ',
            ),
            buildInfoCard(
              '3ª CIRETRAN - NOVA CRUZ',
              'Rua Senador Georgino Avelino, nº 42, Frei Damião, 59.200-000',
              'Segunda a Sexta, das 07h às 13h.',
            ),
            buildInfoCard(
              '4ª CIRETRAN - CURRAIS NOVOS',
              'Rua Tomaz do O, nº 18, JK, 59.380-000',
              'Segunda a Sexta, das 07h às 13h.',
            ),
            buildInfoCard(
              '5ª CIRETRAN - PAU DOS FERROS',
              'Praça Cristo Rei, nº 18, Centro, 59.900-000',
              'Segunda a Sexta, das 07h às 13h.',
            ),
            buildInfoCard(
              'ANGICOS',
              'Rua Vicente Ferreira Barbosa, Alto da Esperança, 59.515-000',
              'Segunda a Sexta, das 08h às 13h.',
            ),
            buildInfoCard(
              'APODI',
              'Rua Deputado Dalton Cunha, nº 41, Portal da Chapada, 59.700-000',
              'Segunda a Sexta, das 07h às 13h.',
            ),
            buildInfoCard(
              'AREIA BRANCA',
              'Rua Jorge Caminha, s/n, Centro, 59.625-000',
              'Segunda a Sexta, das 07h às 13h.',
            ),
            buildInfoCard(
              'ASSÚ',
              'Av. Senador João Câmara, nº 500, Bairro Frutilândia, 59.650-000',
              'Segunda a Sexta, das 07h às 13h.',
            ),
            buildInfoCard(
              'CANGUARETAMA',
              'Rua Nossa Senhora da Conceição, nº 44, Centro, 59.180-000',
              'Segunda a Sexta, das 07h às 13h.',
            ),
            buildInfoCard(
              'CARAÚBAS',
              'Rua Epitácio Pessoa, nº 234, Centro, 59.780-000',
              'Segunda a Sexta, das 07h às 13h.',
            ),
            buildInfoCard(
              'CEARÁ-MIRIM',
              'Rua Luiz Lopes Varela, nº 290, Centro, 59.570-000',
              'Segunda a Sexta, das 07h às 13h.',
            ),
            buildInfoCard(
              'GOIANINHA',
              'Rua João Tibúrcio, nº 19, Centro, 59.180-000',
              'Segunda a Sexta, das 07h às 13h.',
            ),
            buildInfoCard(
              'JOÃO CÂMARA',
              'Rua Pedro Siqueira, nº 91, Centro, 59.550-000',
              'Segunda a Sexta, das 07h às 13h.',
            ),
            buildInfoCard(
              'JUCURUTU',
              'Av. Doutor José Bezerra de Araújo, nº 245, Centro, 59.390-000',
              'Segunda a Sexta, das 07h às 13h.',
            ),
            buildInfoCard(
              'LAJES',
              'Rua Francisco Pedro de Góes, nº 5, Centro, 59.555-000',
              'Segunda a Sexta, das 07h às 13h.',
            ),
            buildInfoCard(
              'MACAÍBA',
              'Rua da Conceição, nº 124, Centro, 59.270-000',
              'Segunda a Sexta, das 07h às 13h.',
            ),
            buildInfoCard(
              'MACAU',
              'Rua Augusto Severo, nº 15, Centro, 59.595-000',
              'Segunda a Sexta, das 07h às 13h.',
            ),
            buildInfoCard(
              'PARELHAS',
              'Rua Laurentino Bezerra, nº 160, Centro, 59.300-000',
              'Segunda a Sexta, das 07h às 13h.',
            ),
            buildInfoCard(
              'PATU',
              'Rua Doutor José Augusto, nº 54, Centro, 59.780-000',
              'Segunda a Sexta, das 07h às 13h.',
            ),
            buildInfoCard(
              'SANTA CRUZ',
              'Rua Santo Antônio, nº 83, Centro, 59.200-000',
              'Segunda a Sexta, das 07h às 13h.',
            ),
            buildInfoCard(
              'SÃO PAULO DO POTENGI',
              'Rua Antônio Lopes da Silva, nº 215, Centro, 59.400-000',
              'Segunda a Sexta, das 07h às 13h.',
            ),
            buildInfoCard(
              'SÃO JOSÉ DE MIPIBU',
              'Av. Pedro Ferreira, nº 1, Bairro Centro, 59.230-000',
              'Segunda a Sexta, das 07h às 13h.',
            ),
            buildInfoCard(
              'SÃO MIGUEL',
              'Rua Deputado Hesíquio Fernandes, nº 146, Centro, 59.920-000',
              'Segunda a Sexta, das 07h às 13h.',
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
      margin: EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.blue),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    address,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.access_time, color: Colors.blue),
                SizedBox(width: 8),
                Text(
                  hours,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
