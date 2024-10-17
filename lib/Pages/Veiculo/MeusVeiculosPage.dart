import 'package:detranapp/models/Veiculo.dart';
import 'package:flutter/material.dart';

class MeusVeiculosPage extends StatelessWidget {
  final List<Veiculo> veiculos;

  const MeusVeiculosPage({Key? key, required this.veiculos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      // Add Material widget instead of Scaffold
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: veiculos.isNotEmpty
            ? ListView.builder(
                itemCount: veiculos.length,
                itemBuilder: (context, index) {
                  final veiculo = veiculos[index];
                  return Card(
                    child: ListTile(
                      title: Text(veiculo.modelo),
                      subtitle: Text('Placa: ${veiculo.placa}'),
                    ),
                  );
                },
              )
            : const Center(child: Text('Nenhum veículo cadastrado.')),
      ),
    );
  }
}
