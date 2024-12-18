import 'package:detranapp/Pages/Veiculo/ConsultarVeiculoPage.dart';
import 'package:detranapp/Pages/LoginPage.dart';
import 'package:detranapp/Pages/Veiculo/MeusVeiculosPage.dart';
import 'package:detranapp/models/User.dart';
import 'package:detranapp/models/Veiculo.dart';
import 'package:detranapp/models/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VeiculoPage extends StatefulWidget {
  const VeiculoPage({super.key, required user});

  @override
  State<VeiculoPage> createState() => _VeiculoPageState();
}

class _VeiculoPageState extends State<VeiculoPage> {
  Widget? _conteudoAtual;
  String? _tituloAtual;

  @override
  void initState() {
    super.initState();
    final user = Provider.of<UserProvider>(context, listen: false).user;

    if (user?.veiculos.isNotEmpty ?? false) {
      _conteudoAtual = MeusVeiculosPage(veiculos: user!.veiculos);
      _tituloAtual = 'Meus Veículos';
    } else {
      _conteudoAtual = _buildEmptyState();
      _tituloAtual = 'Meus Veículos';
    }
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
              if (userProvider.user != null) {
                setState(() {
                  _conteudoAtual = ConsultarVeiculoPage();
                  _tituloAtual = 'Consulta de Veículo';
                });
              } else {
                setState(() {
                  _conteudoAtual = const LoginPage();
                  _tituloAtual = 'Login';
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

  @override
  Widget build(BuildContext context) {
    Widget isLoggedInIcon =
        isUserLoggedIn() ? const Icon(Icons.lock_open) : const Icon(Icons.lock);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2196F3),
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            _tituloAtual!,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        iconTheme: IconThemeData(
          color: Colors.white, // Cor do ícone do Drawer
        ),
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
              leading: isLoggedInIcon,
              title: const Text("Meus Veículos"),
              onTap: () {
                final user =
                    Provider.of<UserProvider>(context, listen: false).user;
                if (isUserLoggedIn() && user != null) {
                  setState(() {
                    if (user.veiculos.isNotEmpty) {
                      _conteudoAtual =
                          MeusVeiculosPage(veiculos: user.veiculos);
                      _tituloAtual = 'Meus Veículos';
                    } else {
                      _conteudoAtual = _buildEmptyState();
                      _tituloAtual = 'Meus Veículos';
                    }
                  });
                } else {
                  setState(() {
                    _conteudoAtual = const LoginPage();
                  });
                }
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: isLoggedInIcon,
              title: const Text('Consulta de Veículo'),
              onTap: () {
                final user =
                    Provider.of<UserProvider>(context, listen: false).user;
                if (isUserLoggedIn() && user != null) {
                  setState(() {
                    _conteudoAtual = ConsultarVeiculoPage();
                    _tituloAtual = 'Consulta de Veículo';
                  });
                } else {
                  setState(() {
                    _conteudoAtual = const LoginPage();
                  });
                }
                Navigator.pop(context); // Fecha o drawer
              },
            ),
            ListTile(
              leading: isLoggedInIcon,
              title: const Text('ATPV-e Acompanhamento'),
              // onTap: () {
              //   if (isUserLoggedIn()) {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => const ConsultarVeiculoPage()),
              //     );
              //   } else {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => const LoginPage()),
              //     );
              //   }
              // },
            ),
            ListTile(
              leading: isLoggedInIcon,
              title: const Text('ATPV-e Intenção de Venda'),
              // onTap: () {
              //   if (isUserLoggedIn()) {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => const ConsultarVeiculoPage()),
              //     );
              //   } else {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => const LoginPage()),
              //     );
              //   }
              // },
            ),
            ListTile(
              leading: isLoggedInIcon,
              title: const Text('Comunicação de Venda'),
              // onTap: () {
              //   if (isUserLoggedIn()) {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => const ConsultarVeiculoPage()),
              //     );
              //   } else {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => const LoginPage()),
              //     );
              //   }
              // },
            ),
            ListTile(
              leading: isLoggedInIcon,
              title: const Text('Consulta Registro de Contrato'),
              // onTap: () {
              //   if (isUserLoggedIn()) {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => const ConsultarVeiculoPage()),
              //     );
              //   } else {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => const LoginPage()),
              //     );
              //   }
              // },
            ),
            const ListTile(
              leading: Icon(Icons.arrow_forward),
              title: Text('Liberação de Veículo'),
              // onTap: () {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => PaginaSemLogin()),
              //   );
              // },
            ),
            const ListTile(
              leading: Icon(Icons.arrow_forward),
              title: Text('Licenciamento Anual'),
              // onTap: () {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => PaginaSemLogin()),
              //   );
              // },
            ),
            const ListTile(
              leading: Icon(Icons.arrow_forward),
              title: Text('Primeiro Emplacamento'),
              // onTap: () {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => PaginaSemLogin()),
              //   );
              // },
            ),
            const ListTile(
              leading: Icon(Icons.arrow_forward),
              title: Text('Transferência de Propriedade'),
              // onTap: () {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => PaginaSemLogin()),
              //   );
              // },
            ),
            const ListTile(
              leading: Icon(Icons.arrow_forward),
              title: Text('Download de Requerimentos'),
              // onTap: () {
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => PaginaSemLogin()),
              //   );
              // },
            ),
          ],
        ),
      ),
      body: _conteudoAtual,
    );
  }

  bool isUserLoggedIn() {
    return Provider.of<UserProvider>(context, listen: false).user != null;
  }
}
