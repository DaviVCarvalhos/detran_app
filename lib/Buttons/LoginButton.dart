import 'package:detranapp/models/user_provider.dart';
import 'package:detranapp/models/veiculo_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:detranapp/Pages/LoginPage.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtenha o estado do UserProvider
    final userProvider = Provider.of<UserProvider>(context);
    final veiculoProvider = Provider.of<VeiculoProvider>(context);

    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: const Color.fromARGB(255, 0, 128, 198),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: () {
        if (userProvider.isLoggedIn) {
          // Realizar logout
          userProvider.logout();
          veiculoProvider.resetVeiculos();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Você saiu com sucesso!")),
          );
        } else {
          // Navegar para a página de login
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        }
      },
      icon: Icon(
        userProvider.isLoggedIn ? Icons.logout : Icons.login,
        size: 20,
      ),
      label: Text(userProvider.isLoggedIn ? 'LOGOUT' : 'LOGIN'),
    );
  }
}
