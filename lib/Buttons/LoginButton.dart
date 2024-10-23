
import 'package:flutter/material.dart';
import '../Pages/LoginPage.dart';


class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {

    
    return IconButton(
      icon: const Icon(Icons.login),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      },
      iconSize: 50.0,
      color: Colors.white,
      
    );
  }
}