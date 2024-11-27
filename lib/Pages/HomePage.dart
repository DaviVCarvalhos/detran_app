import 'package:detranapp/Buttons/LoginButton.dart';
import 'package:detranapp/Pages/PerfilPage.dart';
import 'package:detranapp/models/User.dart';
import 'package:detranapp/models/Veiculo.dart';
import 'package:detranapp/widgets/AgendamentoWidget.dart';
import 'package:detranapp/widgets/DetranTitle.dart';
import 'package:detranapp/widgets/InfoWidget.dart';
import 'package:detranapp/widgets/InfracoesWidget.dart';
import 'package:detranapp/widgets/LeilaoWidget.dart';
import 'package:detranapp/widgets/VeiculoWidget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User user = User(
      id: '1',
      cpf: '12345678900',
      datanascimento: DateTime(1990, 5, 10),
      nome: 'Guts',
      email: 'GRIIFTHHHHHH@gmail.com',
      phone_number: '11999999999');

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgets = [
      InfracoesWidget(),
      InfoWidget(),
      LeilaoWidget(),
      AgendamentoWidget(),
    ];

    return DefaultTabController(
      length: 2, // Número de abas (Home e Perfil)
      child: Scaffold(
        appBar: AppBar(
          // Força o leading a ser null para garantir que o botão de voltar não apareça
          leading: null,
          automaticallyImplyLeading:
              false, // Impede a lógica automática de adicionar o botão
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: LoginButton(),
            ),
          ],
          title: DetranTitle(),
          centerTitle: false,
          backgroundColor: const Color.fromARGB(255, 0, 128, 198),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(vertical: 20),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 1,
                ),
                itemCount: widgets.length,
                itemBuilder: (BuildContext context, int index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      child: widgets[index],
                    ),
                  );
                },
              ),
            ),
            PerfilPage(user: user),
          ],
        ),
        bottomNavigationBar: Container(
          color: const Color.fromARGB(255, 0, 128, 198),
          child: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white60,
            indicatorColor: Colors.white,
            tabs: [
              Tab(icon: Icon(Icons.home), text: 'Home'),
              Tab(icon: Icon(Icons.person), text: 'Meu Perfil'),
            ],
          ),
        ),
      ),
    );
  }
}
