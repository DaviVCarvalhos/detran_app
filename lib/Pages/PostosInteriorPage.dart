import 'package:flutter/material.dart';

class PostosInteriorpage extends StatelessWidget {
  const PostosInteriorpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF17A2B8),
        title: const Text('Postos de Atendimento no Interior'),
      ),
      body: Container(
        color: Colors.white, // Cor de fundo da página
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                '1ª CIRETRAN - MOSSORÓ\n'
                'Endereço: Centro Administrativo Integrado Diran dos Ramos Amaral, Av. do Contorno, nº 1020, DixSept Rosado, 59.607-042\n'
                'Horário de Funcionamento: Segunda a Sexta, das 07h às 13h.\n\n',
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
              Text(
                '2ª CIRETRAN - CAICÓ\n'
                'Endereço: Rua Marina Neves Dantas, nº 35, Central do Cidadão, Maynard, 59.300-000\n'
                'Horário de Funcionamento: Segunda a Sexta, das 07h às 13h.\n\n',
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
              Text(
                '4ª CIRETRAN - CURRAIS NOVOS\n'
                'Endereço: Rua Tomaz do "O", nº 18, JK, 59.380-000\n'
                'Horário de Funcionamento: Segunda a Sexta, das 07h às 13h.\n\n',
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
              Text(
                '5ª CIRETRAN - PAU DOS FERROS\n'
                'Endereço: Praça Cristo Reis, nº 18, Centro, 59.900-000\n'
                'Horário de Funcionamento: Segunda a Sexta, das 07h às 13h.\n\n',
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
              Text(
                'ANGICOS\n'
                'Endereço: Rua Vicente Ferreira Barbosa, Alto da Esperança, 59.515-000\n'
                'Horário de Funcionamento: Segunda a Sexta, das 08h às 13h.\n\n',
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
              Text(
                'APODI\n'
                'Endereço: Rua Deputado Dalton Cunha, 41, Portal da Chapada, 59.700-000\n'
                'Horário de Funcionamento: Segunda a Sexta, das 07h às 13h.\n\n',
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
              Text(
                'ASSU\n'
                'Endereço: Rua Senador João Câmara, s/n, Centro, 59.650-000\n'
                'Horário de Funcionamento: Segunda a Sexta, das 07h às 13h.\n\n',
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
              Text(
                'ALEXANDRIA\n'
                'Endereço: Travessa Benício de Paiva, s/n, Centro, 59.965-000\n'
                'Horário de Funcionamento: Segunda a Sexta, das 07h às 13h.\n\n',
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
              Text(
                'ALTO DO RODRIGUES\n'
                'Endereço: Av. Ângelo Varela, nº 1023 A, Centro, 59.507-000\n'
                'Horário de Funcionamento: Segunda a Sexta, das 07h às 13h.\n\n',
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
              Text(
                'CANGUARETAMA\n'
                'Endereço: Av. Jeronimo de Albuquerque, s/n, Cercado Grande, 59.190-000\n'
                'Horário de Funcionamento: Segunda a Sexta, das 08h às 14h.\n\n',
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
              Text(
                'CARAÚBAS\n'
                'Endereço: Travessa Miguel Câmara, nº 22 A, Centro, 59.780-000\n'
                'Horário de Funcionamento: Segunda a Sexta, das 07h às 13h.\n\n',
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
              Text(
                'CEARÁ-MIRIM\n'
                'Endereço: Av. Eneias Cavalcante, n° 1820, Centro, 59.570-000\n'
                'Horário de Funcionamento: Segunda a Sexta, das 07h às 13h.\n\n',
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
              Text(
                'JUCURUTU\n'
                'Endereço: Rua Vicente Dutra de Souza, nº 244, Centro, 59.330-000\n'
                'Horário de Funcionamento: Segunda a Sexta, das 07h às 13h.\n\n',
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
              Text(
                'MACAÍBA\n'
                'Endereço: Av. Jundiai, n° 56, Centro, 59.280-000\n'
                'Horário de Funcionamento: Segunda a Sexta, das 07h às 13h.\n\n',
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
              Text(
                'MACAU\n'
                'Endereço: Rua Padre João, s/n, Centro (Central do Cidadão), 59.500-000\n'
                'Horário de Funcionamento: Segunda a Sexta, das 07h às 13h.\n\n',
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
              Text(
                'NOVA CRUZ\n'
                'Endereço: Praça Dix-Sept Rosado, nº 125, Centro, 59.215-000\n'
                'Horário de Funcionamento: Segunda a Sexta, das 07h às 13h.\n\n',
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
              Text(
                'PARELHAS\n'
                'Endereço: Rua Isidoro Gomes Meira, nº 42, Centro, 59.360-000\n'
                'Horário de Funcionamento: Segunda a Sexta, das 07h às 13h.\n\n',
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
              Text(
                'PATU\n'
                'Endereço: Av. Antônio Suassuna, s/n, Nova Brasília, 59.770-000\n'
                'Horário de Funcionamento: Segunda a Sexta, das 07h às 13h.\n\n',
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
              Text(
                'SANTA CRUZ\n'
                'Endereço: Rua São Félix, n° 189, Conjunto Conego Monte, 59.200-000\n'
                'Horário de Funcionamento: Segunda a Sexta, das 07h às 13h.\n\n',
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
              Text(
                'SÃO JOSÉ DE MIPIBU\n'
                'Endereço: Praça Capitão José da Penha, n° 31, Centro, 59.162-000\n'
                'Horário de Funcionamento: Segunda a Sexta, das 07h às 13h.\n\n',
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
              Text(
                'SÃO MIGUEL\n'
                'Endereço: Rua Treze de Maio, n° 12, Centro, 59.920-000\n'
                'Horário de Funcionamento: Segunda a Sexta, das 07h às 13h.\n\n',
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
              Text(
                'SÃO PAULO DO POTENGI\n'
                'Endereço: Rua Otávio Lamartine, nº 89, Centro, 59.370-000\n'
                'Horário de Funcionamento: Segunda a Sexta, das 07h às 13h.\n\n',
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
              Text(
                'TENENTE ANANIAS\n'
                'Endereço: Rua José Gomes de Oliveira, s/n, Centro, 59.190-000\n'
                'Horário de Funcionamento: Segunda a Sexta, das 08h às 14h.\n\n',
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
              Text(
                'TOUROS\n'
                'Endereço: Av. Pedro Nascimento, s/n, Centro, 59.780-000\n'
                'Horário de Funcionamento: Segunda a Sexta, das 07h às 13h.\n\n',
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
