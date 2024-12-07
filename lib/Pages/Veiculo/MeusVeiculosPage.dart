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
  const MeusVeiculosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final veiculoProvider = Provider.of<VeiculoProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.app_user;

    return Scaffold(
      body: user == null
          ? _buildEmptyState(context, user)
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

  Widget _buildEmptyState(context, App_User? user) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.directions_car, size: 80, color: Colors.grey),
          const SizedBox(height: 20),
          Text(
            'Nenhum veículo cadastrado.',
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            onPressed: () {
              if (user == null) {
                Future.microtask(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                });
              }
            },
            child: const Text(
              'Consultar Veículo',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
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
