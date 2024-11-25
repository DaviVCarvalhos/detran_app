import 'package:detranapp/models/User.dart';
import 'package:detranapp/models/Veiculo.dart';
import 'package:detranapp/models/veiculo_provider.dart';
import 'package:detranapp/widgets/VeiculoDetails.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConsultarVeiculoPage extends StatefulWidget {
  const ConsultarVeiculoPage({super.key});

  @override
  State<ConsultarVeiculoPage> createState() => _ConsultarVeiculoPageState();
}

class _ConsultarVeiculoPageState extends State<ConsultarVeiculoPage> {
  late User user;
  @override
  Widget build(BuildContext context) {
    final veiculoProvider = Provider.of<VeiculoProvider>(context);
    final placaController = TextEditingController();
    final renavamController = TextEditingController();

    return SingleChildScrollView(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Placa',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                TextField(
                  controller: placaController,
                  decoration:
                      const InputDecoration(border: OutlineInputBorder()),
                ),
                const SizedBox(height: 16),
                const Text('Renavam',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                TextField(
                  controller: renavamController,
                  decoration:
                      const InputDecoration(border: OutlineInputBorder()),
                ),
                const SizedBox(height: 32),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      await veiculoProvider.pesquisarVeiculo(
                        placaController.text,
                        renavamController.text,
                      );
                      if (veiculoProvider.veiculoPesquisado == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Veículo não encontrado.')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32.0, vertical: 16.0),
                    ),
                    child: const Text('Consultar',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                ),
                if (veiculoProvider.veiculoPesquisado != null) ...[
                  const SizedBox(height: 32),
                  const Text('Detalhes do Veículo:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  if (veiculoProvider.veiculoPesquisado != null)
                    VeiculoDetails(
                        veiculoProvider.veiculoPesquisado! as Veiculo),
                ],
              ],
            ),
          ),
          if (veiculoProvider.veiculoPesquisado != null &&
              veiculoProvider.veiculoPesquisado!.nomeProprietario == user.nome)
            Positioned(
              right: 16,
              bottom: 16,
              child: FloatingActionButton(
                onPressed: () {
                  veiculoProvider.adicionarVeiculoAoUsuario(
                      user.id as String, veiculoProvider.veiculoPesquisado!);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          '${veiculoProvider.veiculoPesquisado!.modelo} adicionado com sucesso!'),
                    ),
                  );
                },
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.add),
              ),
            ),
        ],
      ),
    );
  }
}
