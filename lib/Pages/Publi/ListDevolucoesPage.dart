import 'package:flutter/material.dart';

class ListDevolucoesPage extends StatefulWidget {
  const ListDevolucoesPage({super.key});

  @override
  _ListDevolucoesPageState createState() => _ListDevolucoesPageState();
}

class _ListDevolucoesPageState extends State<ListDevolucoesPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';

  List<Map<String, String>> devolucoes = [
    {
      'placa': 'MXR8494',
      'descricao': 'DETRAN-120100-F 17524570-6050',
      'documento': '08.288.326/0001-78',
      'proprietario': 'A AZEVEDO EMPREEND E PARTIC LTDA',
      'valorIpca': 'R\$ 738,60',
      'valorMulta': 'R\$ 173,00',
      'valorDesconto': 'R\$ 443,16'
    },
    {
      'placa': 'MXX0094',
      'descricao': 'DETRAN-120100-F 17523094-6050',
      'documento': '09.090.275/0001-38',
      'proprietario': 'A AZEVEDO HOTEIS E TURISMO LTDA',
      'valorIpca': 'R\$ 738,60',
      'valorMulta': 'R\$ 173,00',
      'valorDesconto': 'R\$ 443,16'
    },
    {
      'placa': 'MXW9885',
      'descricao': 'DETRAN-120100-F 17567388-5673',
      'documento': '09.090.275/0001-38',
      'proprietario': 'A AZEVEDO HOTEIS E TURISMO LTDA',
      'valorIpca': 'R\$ 341,30',
      'valorMulta': 'R\$ 85,12',
      'valorDesconto': 'R\$ 204,78'
    },
    {
      'placa': 'MXX2662',
      'descricao': 'DETRAN-120100-F 17516601-6050',
      'documento': '09.090.275/0001-38',
      'proprietario': 'A AZEVEDO HOTEIS E TURISMO LTDA',
      'valorIpca': 'R\$ 738,60',
      'valorMulta': 'R\$ 173,00',
      'valorDesconto': 'R\$ 443,16'
    },
    {
      'placa': 'MNY9798',
      'descricao': 'DETRAN-120100-R 17724987-6211',
      'documento': '00.986.701/0001-41',
      'proprietario': 'A B IMPLEMENTOS RODOVIARIOS LTDA',
      'valorIpca': 'R\$ 332,70',
      'valorMulta': 'R\$ 127,69',
      'valorDesconto': 'R\$ 199,62'
    },
    {
      'placa': 'MXR7573',
      'descricao': 'DETRAN-120100-F 17571183-6050',
      'documento': '01.487.778/0001-30',
      'proprietario': 'A C VILLARIM ME',
      'valorIpca': 'R\$ 724,68',
      'valorMulta': 'R\$ 191,53',
      'valorDesconto': 'R\$ 434,81'
    },
    {
      'placa': 'MXR7573',
      'descricao': 'DETRAN-120100-F 17574834-6050',
      'documento': '01.487.778/0001-30',
      'proprietario': 'A C VILLARIM ME',
      'valorIpca': 'R\$ 606,90',
      'valorMulta': 'R\$ 191,53',
      'valorDesconto': 'R\$ 364,14'
    },
    {
      'placa': 'MXH9907',
      'descricao': 'DETRAN-120100-F 17524128-6050',
      'documento': '08.484.008/0001-82',
      'proprietario': 'A CANDELARIA LTDA',
      'valorIpca': 'R\$ 739,95',
      'valorMulta': 'R\$ 191,53',
      'valorDesconto': 'R\$ 443,97'
    },
    {
      'placa': 'MXH9907',
      'descricao': 'DETRAN-120100-F 17567689-5673',
      'documento': '08.484.008/0001-82',
      'proprietario': 'A CANDELARIA LTDA',
      'valorIpca': 'R\$ 273,05',
      'valorMulta': 'R\$ 85,12',
      'valorDesconto': 'R\$ 163,83'
    },
    {
      'placa': 'MXH9907',
      'descricao': 'DETRAN-120100-F 17545136-6050',
      'documento': '08.484.008/0001-82',
      'proprietario': 'A CANDELARIA LTDA',
      'valorIpca': 'R\$ 739,67',
      'valorMulta': 'R\$ 176,00',
      'valorDesconto': 'R\$ 443,80'
    },
  ];

  List<Map<String, String>> get filteredDevolucoes {
    if (_searchText.isEmpty) return devolucoes;
    return devolucoes.where((item) {
      return item.values.any(
        (value) => value.toLowerCase().contains(_searchText.toLowerCase()),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Pesquisar',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (text) {
                setState(() {
                  _searchText = text;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredDevolucoes.length,
              itemBuilder: (context, index) {
                final item = filteredDevolucoes[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 10.0),
                  color: Color(0xFF6D7C8C),
                  elevation: 4.0,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Placa: ${item['placa']}',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 6.0),
                        Text('Descrição: ${item['descricao']}'),
                        Text('Documento Identificação: ${item['documento']}'),
                        Text('Proprietário na Época: ${item['proprietario']}'),
                        Text(
                            'Valor Atualização IPCA até 2022: ${item['valorIpca']}'),
                        Text('Valor Multa Detran: ${item['valorMulta']}'),
                        Text('Valor Com Desconto: ${item['valorDesconto']}'),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
