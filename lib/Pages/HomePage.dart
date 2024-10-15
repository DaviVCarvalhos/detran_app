import 'package:detranapp/Pages/LoginPage.dart';
import 'package:detranapp/widgets/LeilaoWidget.dart';
import 'package:detranapp/widgets/VeiculoWidget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  
  // Lista de widgets
  final List<Widget> widgets = [
    VeiculoWidget(),
    LeilaoWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, 
                foregroundColor: const Color.fromARGB(255, 0, 128, 198), // Cor do texto e ícone
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // Bordas arredondadas
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              icon: const Icon(Icons.login, size: 20),
              label: const Text('LOGIN'),
            ),
          ),
        ],
        title: Image.asset(
          'images/detranlogo.jpg', 
          height: 50, 
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 0, 128, 198),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(vertical: 20),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 250, // Largura máxima dos widgets aumentada
                mainAxisSpacing: 20, // Espaçamento vertical entre widgets
                crossAxisSpacing: 20, // Espaçamento horizontal entre widgets
                childAspectRatio: 1, // Proporção mais equilibrada
              ),
              itemCount: widgets.length,
              itemBuilder: (BuildContext context, int index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(15), // Define as bordas arredondadas
                  child: Container(
                    color: Colors.blueAccent, // Definindo uma cor para o fundo do widget
                    child: widgets[index], // Widget dentro do Container arredondado
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
