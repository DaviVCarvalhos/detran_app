import 'package:detranapp/models/App_User.dart';
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
  late App_User user;
  Veiculo? veiculoPesquisado;

  final TextEditingController placaController = TextEditingController();
  final TextEditingController renavamController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    placaController.dispose();
    renavamController.dispose();
    super.dispose();
  }

  Future<void> _pesquisarVeiculo(VeiculoProvider veiculoProvider) async {
    setState(() {
      isLoading = true;
    });

    try {
      veiculoPesquisado = await veiculoProvider.pesquisarVeiculo(
        placaController.text,
        renavamController.text,
      );
      setState(() {
        isLoading = false;
      });

      if (veiculoPesquisado == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Veículo não encontrado.')),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao buscar veículo: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final veiculoProvider = Provider.of<VeiculoProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Placa',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: placaController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Renavam',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: renavamController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () => _pesquisarVeiculo(veiculoProvider),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32.0,
                      vertical: 16.0,
                    ),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          'Consultar',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                ),
              ),
              if (veiculoPesquisado != null) ...[
                const SizedBox(height: 32),
                const Text(
                  'Detalhes do Veículo:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                VeiculoDetails(veiculoPesquisado!),
              ],
            ],
          ),
        ),
      ),
      floatingActionButton: (veiculoPesquisado != null &&
              veiculoPesquisado!.nomeProprietario == user.nome)
          ? FloatingActionButton(
              onPressed: () {
                veiculoProvider.adicionarVeiculoAoUsuario(
                  user.id,
                  veiculoPesquisado!,
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '${veiculoPesquisado!.modelo} adicionado com sucesso!',
                    ),
                  ),
                );
              },
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
