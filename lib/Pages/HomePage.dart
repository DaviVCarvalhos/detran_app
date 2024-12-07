import 'package:detranapp/Buttons/LoginButton.dart';
import 'package:detranapp/Pages/PerfilPage.dart';
import 'package:detranapp/models/App_User.dart';
import 'package:detranapp/models/user_provider.dart';

import 'package:detranapp/widgets/AgendamentoWidget.dart';
import 'package:detranapp/widgets/DetranTitle.dart';
import 'package:detranapp/widgets/InfoWidget.dart';
import 'package:detranapp/widgets/InfracoesWidget.dart';
import 'package:detranapp/widgets/LeilaoWidget.dart';
import 'package:detranapp/widgets/VeiculoWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  App_User? user;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    ;
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgets = [
      InfracoesWidget(),
      InfoWidget(),
      LeilaoWidget(),
      AgendamentoWidget(),
      VeiculoWidget()
    ];

    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return DefaultTabController(
      length: 2, // Número de abas (Home e Perfil)
      child: Scaffold(
        appBar: AppBar(
          leading: null,
          automaticallyImplyLeading: false,
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
            PerfilPage(), // Passa o user, que pode ser o default
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
