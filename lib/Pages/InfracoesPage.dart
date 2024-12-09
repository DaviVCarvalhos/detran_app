import 'package:detranapp/Pages/LoginPage.dart';
import 'package:detranapp/models/user_provider.dart';
import 'package:detranapp/widgets/DetranTitle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:detranapp/models/infracao_provider.dart';

class InfracoesPage extends StatefulWidget {
  @override
  _InfracoesPageState createState() => _InfracoesPageState();
}

class _InfracoesPageState extends State<InfracoesPage> {
  Future<void>? _carregarInfracoesFuture;

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.app_user;

    if (user != null) {
      _carregarInfracoesFuture =
          Provider.of<InfracaoProvider>(context, listen: false)
              .carregarInfracoes(user.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.app_user;

    return Scaffold(
      appBar: AppBar(
        title: DetranTitle(),
        backgroundColor: Color(0xFFDC3545),
        leading: BackButton(color: Colors.white),
      ),
      body: user == null
          ? _buildLoginNull(context)
          : FutureBuilder(
              future: _carregarInfracoesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Erro ao carregar infrações.'));
                }

                final infracoes =
                    Provider.of<InfracaoProvider>(context).infracoes;

                if (infracoes.isEmpty) {
                  return _buildLoginNull(context);
                }

                return ListView.builder(
                  itemCount: infracoes.length,
                  itemBuilder: (ctx, i) {
                    final infracao = infracoes[i];
                    return ListTile(
                      title: Text(infracao.descricao),
                      subtitle: Text(
                          'Valor: R\$ ${infracao.valor.toStringAsFixed(2)}'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _excluirInfracao(context, infracao.id),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }

  Widget _buildLoginNull(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.local_police, size: 100, color: Colors.grey),
          SizedBox(height: 20),
          Text(
            'Nenhuma infração cadastrada.',
            style: TextStyle(color: Colors.grey, fontSize: 16),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            child: Text('Consultar Infrações'),
          ),
        ],
      ),
    );
  }

  void _excluirInfracao(BuildContext context, String id) async {
    try {
      await Provider.of<InfracaoProvider>(context, listen: false)
          .excluirInfracao(id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Infração excluída com sucesso!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao excluir infração: $e')),
      );
    }
  }
}
