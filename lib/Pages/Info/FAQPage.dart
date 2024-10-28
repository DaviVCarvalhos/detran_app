import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFBEE5EB),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
              child: Text(
                'Perguntas Frequentes',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          buildFAQCategory(
            context,
            'Cadastrei meu e-mail errado, como proceder?',
            [
              {
                'answer': '''
Se você cadastrou errado seu e-mail incorretamente, espere 2 horas da hora que você se cadastrou e se cadastre novamente, pois seu cadastro só será efetuado quando confirmar o e-mail recebido.

Caso ainda assim, não conseguir se cadastrar:

Envie um e-mail para: portal@detran.rn.gov.br com o Assunto/Titulo do e-mail como:
"E-mail cadastrado incorretamente, problema persistiu", contendo os dados abaixo no corpo do e-mail:

  - Nome completo
  - CPF
  - E-mail correto
  - Telefone
  - Documentação de Identificação
    - Selfie segurando o documento
    - Foto do documento
                '''
              },
            ],
            1,
          ),
          buildFAQCategory(
            context,
            'Tentei me cadastrar, mas meu CPF já foi cadastrado e não foi eu que me cadastrei, como proceder?',
            [
              {
                'answer': '''
Envie um e-mail para: portal@detran.rn.gov.br com o Assunto/Titulo do e-mail como:
"Meu CPF foi cadastrado e não foi eu", contendo os dados abaixo no corpo do e-mail:

  - Nome completo
  - CPF
  - E-mail
  - Telefone
  - Documentação de Identificação
    - Selfie segurando o documento
    - Foto do documento
                '''
              },
            ],
            2,
          ),
          buildFAQCategory(
            context,
            'Tentei me cadastrar, mas meu E-mail já foi cadastrado e não foi eu que me cadastrei, como proceder? ',
            [
              {
                'answer': '''
Envie um e-mail para: portal@detran.rn.gov.br com o Assunto/Titulo do e-mail como:
Meu e-mail foi cadastrado e não foi eu, contendo os dados abaixo no corpo do e-mail:

    O nome completo

    CPF

    E-mail

    Telefone

    Documentação de Identificação

        –  Selfie segurando o documento

        –  Foto do documento
                '''
              },
            ],
            3,
          ),
          buildFAQCategory(
            context,
            'Meu problema não está relatado aqui, como proceder?  ',
            [
              {
                'answer': '''
Estamos felizes em ajudar!

Para problemas relacionados ao cadastro de conta no Meu Detran tais como:

    Tentei me cadastrar e apareceu que o meu CPF já está sendo utilizado

    Tentei me cadastrar e apareceu que o meu e-mail já está sendo utilizado

    Não recebi o e-mail com com a senha no meu e-mail, o que fazer?

        –  Visualizar no SPAM, se mesmo assim não chegar, solicitar no esqueci senha e verificar se o email está correto

Envie um E-mail para: portal@detran.rn.gov.br com a descrição do problema que você está enfrentando contendo os dados abaixo:

    O nome completo

    CPF

    E-mail

    Telefone

    Documentação de Identificação

        –  Selfie segurando o documento

        –  Foto do documento
                '''
              },
            ],
            4,
          ),
        ],
      ),
    );
  }

  Widget buildFAQCategory(BuildContext context, String categoryTitle,
      List<Map<String, String>> questions, int number) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ExpansionTile(
        leading: CircleAvatar(
          radius: 15.0,
          backgroundColor: Color(0xFFE91E63),
          child: Text(
            number.toString(),
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(
          categoryTitle,
          style: TextStyle(fontSize: 18.0),
        ),
        children: questions.map((question) {
          return ListTile(
            title: Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(question['answer']!),
            ),
          );
        }).toList(),
      ),
    );
  }
}
