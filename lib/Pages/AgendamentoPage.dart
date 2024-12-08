import 'package:detranapp/Pages/AddAgendamentoPage.dart';
import 'package:detranapp/Pages/EditAgendamentoPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:detranapp/models/agendamento_provider.dart';
import 'package:detranapp/models/user_provider.dart';
import 'LoginPage.dart';
import 'package:detranapp/widgets/DetranTitle.dart';

class AgendamentoPage extends StatefulWidget {
  @override
  _AgendamentoPageState createState() => _AgendamentoPageState();
}

class _AgendamentoPageState extends State<AgendamentoPage> {
  Future<void>? _carregarAgendamentosFuture;

  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.app_user;

    if (user != null) {
      _carregarAgendamentosFuture =
          Provider.of<AgendamentoProvider>(context, listen: false)
              .carregarAgendamentos(user.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.app_user;

    return Scaffold(
      appBar: AppBar(
        title: DetranTitle(),
        backgroundColor: Color(0xFF629460),
        leading: BackButton(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              if (user == null) {
                _redirectToLogin(context);
              } else {
                _adicionarAgendamento(context, user.id);
              }
            },
          ),
        ],
      ),
      body: user == null
          ? _buildLoginNull(context)
          : FutureBuilder(
              future: _carregarAgendamentosFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Erro ao carregar agendamentos.'));
                }

                final agendamentos =
                    Provider.of<AgendamentoProvider>(context).agendamentos;

                if (agendamentos.isEmpty) {
                  return _buildLoginNull(context);
                }

                return ListView.builder(
                  itemCount: agendamentos.length,
                  itemBuilder: (context, index) {
                    final agendamento = agendamentos[index];
                    return ListTile(
                      title: Text('Categoria: ${agendamento.categoria}'),
                      subtitle: Text(
                          'Data: ${agendamento.data} - Hora: ${agendamento.hora} - Local ${agendamento.local}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => EditarAgendamentoPage(
                                      agendamento: agendamento),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              _excluirAgendamento(context, agendamento.id);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}

void _redirectToLogin(BuildContext context) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => LoginPage()),
  );
}

void _adicionarAgendamento(BuildContext context, String userId) {
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => AdicionarAgendamentoPage(userId: userId)),
  );
}

Widget _buildLoginNull(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.event_note,
          size: 100,
          color: Colors.grey,
        ),
        SizedBox(height: 20),
        Text(
          'Nenhum agendamento cadastrado.',
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
          child: Text('Consultar Agendamento'),
        ),
      ],
    ),
  );
}

void _excluirAgendamento(BuildContext context, String idAgendamento) async {
  try {
    await Provider.of<AgendamentoProvider>(context, listen: false)
        .excluirAgendamento(idAgendamento);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Agendamento excluído com sucesso!')),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Erro ao excluir agendamento: $e')),
    );
  }
}
