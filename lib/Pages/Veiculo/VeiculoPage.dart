import 'package:detranapp/Pages/Veiculo/ConsultarVeiculoPage.dart';
import 'package:detranapp/Pages/LoginPage.dart';
import 'package:detranapp/Pages/Veiculo/MeusVeiculosPage.dart';
import 'package:detranapp/models/Veiculo.dart';
import 'package:flutter/material.dart';

class VeiculoPage extends StatefulWidget {
  final List<Veiculo> veiculos;
  final Function(Veiculo) onVeiculoAdicionado;

  const VeiculoPage({
    super.key,
    required this.veiculos,
    required this.onVeiculoAdicionado,
  });

  @override
  State<VeiculoPage> createState() => _VeiculoPageState();
}

class _VeiculoPageState extends State<VeiculoPage> {
  Widget? _conteudoAtual;
  String? _tituloAtual;

  @override
  void initState() {
    super.initState();
    _conteudoAtual =
        MeusVeiculosPage(veiculos: widget.veiculos); //MeusVeiculosPage
    _tituloAtual = 'Meus Veículos';
  }

  @override
  Widget build(BuildContext context) {
    Widget isLoggedInIcon =
        isUserLoggedIn() ? const Icon(Icons.lock_open) : const Icon(Icons.lock);

    return Scaffold(
      appBar: AppBar(
        title: Text(_tituloAtual!),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
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
              title: const Text('Meus Veículos'),
              onTap: () {
                if (isUserLoggedIn()) {
                  setState(() {
                    _conteudoAtual =
                        MeusVeiculosPage(veiculos: widget.veiculos);
                    _tituloAtual = 'Meus Veículos';
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
                if (isUserLoggedIn()) {
                  setState(() {
                    _conteudoAtual = ConsultarVeiculoPage(
                        onVeiculoAdicionado: widget.onVeiculoAdicionado);
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
    // Verificação de login (pode ser substituída pela lógica real)
    return true; // ou true, dependendo do estado de login
  }
}
