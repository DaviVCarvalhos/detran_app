import 'package:detranapp/Pages/LoginPage.dart';
import 'package:detranapp/Pages/Veiculo/ConsultarVeiculoPage.dart';
import 'package:detranapp/Pages/Veiculo/MeusVeiculosPage.dart';
import 'package:detranapp/models/user_provider.dart';
import 'package:detranapp/models/veiculo_provider.dart';
import 'package:detranapp/widgets/DetranTitle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VeiculoPage extends StatefulWidget {
  const VeiculoPage({super.key});

  @override
  State<VeiculoPage> createState() => _VeiculoPageState();
}

class _VeiculoPageState extends State<VeiculoPage> {
  Widget? _conteudoAtual;
  bool _isLoading = true; // Adicionando um estado de carregamento

  @override
  void initState() {
    super.initState();
    _atualizarConteudoInicial();
  }

  void _atualizarConteudoInicial() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final veiculoProvider =
        Provider.of<VeiculoProvider>(context, listen: false);

    final user = userProvider.app_user;
    if (user != null) {
      // Chama a busca de veículos de forma assíncrona
      await veiculoProvider.buscarVeiculosDoUsuario(user.id);
    }

    // Atualiza o estado após a busca para mostrar o conteúdo correto
    setState(() {
      _isLoading = false;
      if (veiculoProvider.meusVeiculos.isNotEmpty) {
        _conteudoAtual =
            MeusVeiculosPage(veiculos: veiculoProvider.meusVeiculos);
      } else {
        _conteudoAtual = _buildEmptyState();
      }
    });
  }

  Widget _buildEmptyState() {
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
              final userProvider =
                  Provider.of<UserProvider>(context, listen: false);
              if (userProvider.app_user != null) {
                setState(() {
                  _conteudoAtual = ConsultarVeiculoPage();
                });
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
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

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final veiculoProvider = Provider.of<VeiculoProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2196F3),
        title: DetranTitle(),
      ),
      endDrawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 150, 199, 239),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF2196F3),
              ),
              child: Center(
                child: Text(
                  'Serviços e Taxas',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                  userProvider.app_user != null ? Icons.lock_open : Icons.lock),
              title: const Text("Meus Veículos"),
              onTap: () {
                if (userProvider.app_user != null &&
                    veiculoProvider.meusVeiculos.isNotEmpty) {
                  setState(() {
                    _conteudoAtual = MeusVeiculosPage(
                        veiculos: veiculoProvider.meusVeiculos);
                  });
                } else {
                  setState(() {
                    _conteudoAtual = _buildEmptyState();
                  });
                }
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                  userProvider.app_user != null ? Icons.lock_open : Icons.lock),
              title: const Text('Consulta de Veículo'),
              onTap: () {
                if (userProvider.app_user != null) {
                  setState(() {
                    _conteudoAtual = ConsultarVeiculoPage();
                  });
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                }
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(), // Mostra o carregamento
            )
          : _conteudoAtual ?? _buildEmptyState(),
    );
  }
}
