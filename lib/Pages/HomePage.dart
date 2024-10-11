import 'package:detranapp/Pages/LoginPage.dart';
import 'package:detranapp/widgets/LeilaoWidget.dart';
import 'package:detranapp/widgets/VeiculoWidget.dart';
import 'package:flutter/material.dart';




class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(onPressed: (){
            Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          }, 
          child: Text('LOGIN')),
          Image(
            image: AssetImage('images/detranlogo.jpg'),
          ),
        ],
        title: const Text(
          "DetranApp",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 4, 0, 248),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200, // Largura máxima de cada widget
              mainAxisSpacing: 16, // Espaçamento vertical entre os widgets
              crossAxisSpacing: 16, // Espaçamento horizontal entre os widgets
              childAspectRatio: 1.2, // Proporção largura/altura dos widgets
            ),
            itemCount: 20, 
            itemBuilder: (BuildContext context, int index) {
              
              if (index % 2 == 0) {
                return const VeiculoWidget();
              } else {
                return const LeilaoWidget();
              }
            },
          );
        },
      ),
    );
  }
}






