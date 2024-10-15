import 'package:detranapp/Pages/ConsultarVeiculoPage.dart';
import 'package:detranapp/Pages/LoginPage.dart';
import 'package:flutter/material.dart';

class VeiculoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget iconLoggin =
        isUserLoggedIn() ? const Icon(Icons.lock_open) : const Icon(Icons.lock);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Veículo'),
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
                // Adiciona o widget Center aqui
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
              leading: iconLoggin,
              title: const Text('Meus Veículos'),
              // onTap: () {
              //   if (isUserLoggedIn()) {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => const MeusVeiculosPage()),
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
              leading: iconLoggin,
              title: const Text('Consulta de Veículo'),
              onTap: () {
                if (isUserLoggedIn()) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ConsultarVeiculoPage()),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                }
              },
            ),
            ListTile(
              leading: iconLoggin,
              title: const Text('ATPV-e Acompanhamento'),
              onTap: () {
                if (isUserLoggedIn()) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ConsultarVeiculoPage()),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                }
              },
            ),
            ListTile(
              leading: iconLoggin,
              title: const Text('ATPV-e Intenção de Venda'),
              onTap: () {
                if (isUserLoggedIn()) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ConsultarVeiculoPage()),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                }
              },
            ),
            ListTile(
              leading: iconLoggin,
              title: const Text('Comunicação de Venda'),
              onTap: () {
                if (isUserLoggedIn()) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ConsultarVeiculoPage()),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                }
              },
            ),
            ListTile(
              leading: iconLoggin,
              title: const Text('Consulta Registro de Contrato'),
              onTap: () {
                if (isUserLoggedIn()) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ConsultarVeiculoPage()),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                }
              },
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
      body: const Center(
        child: Text('Conteúdo da Página de Veículo'),
      ),
    );
  }

  bool isUserLoggedIn() {
    // Verificação de login (pode ser substituída pela lógica real)
    return true; // ou true, dependendo do estado de login
  }
}
