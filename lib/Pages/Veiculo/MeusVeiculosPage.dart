import 'package:detranapp/Pages/LoginPage.dart';
import 'package:detranapp/models/App_User.dart';
import 'package:detranapp/models/Veiculo.dart';
import 'package:detranapp/models/user_provider.dart';
import 'package:detranapp/models/veiculo_provider.dart';
import 'package:detranapp/widgets/VeiculoDetails.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MeusVeiculosPage extends StatelessWidget {
  final List<Veiculo> veiculos;

  const MeusVeiculosPage({Key? key, required this.veiculos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: veiculos.isNotEmpty
            ? ListView.builder(
                itemCount: veiculos.length,
                itemBuilder: (context, index) {
                  final veiculo = veiculos[index];
                  return Card(
                    child: InkWell(
                      onTap: () {
                        _showVeiculoBottomSheet(context, veiculo);
                      },
                      child: ListTile(
                        title: Text(veiculo.modelo),
                        subtitle: Text('Placa: ${veiculo.placa}'),
                      ),
                    ),
                  );
                },
              )
            : const Center(child: Text('Nenhum veículo cadastrado.')),
      ),
    );
  }

  void _showVeiculoBottomSheet(BuildContext context, Veiculo veiculo) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return VeiculoDetails(veiculo);
      },
    );
  }
}
