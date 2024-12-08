import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:detranapp/models/infracao_provider.dart';

class InfracoesPage extends StatefulWidget {
  @override
  _InfracoesPageState createState() => _InfracoesPageState();
}

class _InfracoesPageState extends State<InfracoesPage> {
  // Controladores para os campos de texto
  final TextEditingController _numeroInfracaoController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _renavamController = TextEditingController();
  final TextEditingController _placaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final infracaoProvider = Provider.of<InfracaoProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Consultar Infrações'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Campos de texto para consulta
            TextField(
              controller: _numeroInfracaoController,
              decoration: InputDecoration(labelText: 'Número da Infração'),
            ),
            TextField(
              controller: _cpfController,
              decoration: InputDecoration(labelText: 'CPF'),
            ),
            TextField(
              controller: _renavamController,
              decoration: InputDecoration(labelText: 'Renavam'),
            ),
            TextField(
              controller: _placaController,
              decoration: InputDecoration(labelText: 'Placa'),
            ),
            SizedBox(height: 16),

            // Botão de busca
            ElevatedButton(
              onPressed: () {
                infracaoProvider.fetchInfracoesComFiltros(
                  numeroInfracao: _numeroInfracaoController.text.trim(),
                  cpf: _cpfController.text.trim(),
                  renavam: _renavamController.text.trim(),
                  placa: _placaController.text.trim(),
                );
              },
              child: Text('Buscar'),
            ),

            SizedBox(height: 16),

            // Exibir lista de infrações filtradas
            Expanded(
              child: Consumer<InfracaoProvider>(
                builder: (context, provider, child) {
                  if (provider.infracoes.isEmpty) {
                    return Center(child: Text('Nenhuma infração encontrada.'));
                  }

                  return ListView.builder(
                    itemCount: provider.infracoes.length,
                    itemBuilder: (context, index) {
                      final infracao = provider.infracoes[index];
                      return ListTile(
                        title: Text('Infração: ${infracao.nInfracao}'),
                        subtitle: Text(
                          'CPF: ${infracao.cpf}\n'
                          'Renavam: ${infracao.renavam}\n'
                          'Placa: ${infracao.placa}\n'
                          'Quitada: ${infracao.quitada ? 'Sim' : 'Não'}',
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
