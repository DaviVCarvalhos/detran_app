import 'package:detranapp/Pages/Veiculo/ConsultarVeiculoPage.dart';
import 'package:detranapp/Pages/Veiculo/MeusVeiculosPage.dart';
import 'package:flutter/material.dart';

class VeiculoPage extends StatefulWidget {
  const VeiculoPage({Key? key}) : super(key: key);

  @override
  State<VeiculoPage> createState() => _VeiculoPageState();
}

class _VeiculoPageState extends State<VeiculoPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const MeusVeiculosPage(),
    const ConsultarVeiculoPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Veiculo Page'),
      ),
      endDrawer: _buildDrawer(context),
      body: _pages[_selectedIndex],
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
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
            title: const Text('Meus Veículos'),
            onTap: () {
              _navigateTo(context, 0);
            },
          ),
          ListTile(
            title: const Text('Consultar Veículo'),
            onTap: () {
              _navigateTo(context, 1);
            },
          ),
        ],
      ),
    );
  }

  void _navigateTo(BuildContext context, int pageIndex) {
    setState(() {
      _selectedIndex = pageIndex;
    });
    Navigator.pop(context);
  }
}
