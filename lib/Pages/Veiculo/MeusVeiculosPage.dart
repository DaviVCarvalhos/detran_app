import 'package:detranapp/Pages/LoginPage.dart';
import 'package:detranapp/models/Veiculo.dart';
import 'package:detranapp/models/user_provider.dart';
import 'package:detranapp/models/veiculo_provider.dart';
import 'package:detranapp/widgets/VeiculoDetails.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MeusVeiculosPage extends StatelessWidget {
  const MeusVeiculosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final veiculoProvider = Provider.of<VeiculoProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.app_user;

    if (user == null) {
      Future.microtask(() {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      });
    }

    return Scaffold(
      body: user == null
          ? const Center(child: Text('Usuário não autenticado'))
          : FutureBuilder<List<Veiculo>>(
              future: veiculoProvider.buscarVeiculosDoUsuario(user.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text('Erro ao carregar veículos: ${snapshot.error}'),
                  );
                }

                final veiculos = snapshot.data ?? [];

                return Container(
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
                );
              },
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
