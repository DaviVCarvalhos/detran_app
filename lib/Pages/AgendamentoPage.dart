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
      backgroundColor: Color(0xFFC3E6CB), // Cor de fundo da página
      appBar: AppBar(
        title: DetranTitle(),
        backgroundColor: Color(0xFF629460),
        leading: BackButton(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
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
                  padding: EdgeInsets.all(10),
                  itemCount: agendamentos.length,
                  itemBuilder: (context, index) {
                    final agendamento = agendamentos[index];
                    return Card(
                      margin: EdgeInsets.symmetric(
                          vertical: 5), // Margem menor para os cards
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Bordas arredondadas
                      ),
                      elevation: 3, // Sombra leve para destaque
                      child: Padding(
                        padding: const EdgeInsets.all(
                            8.0), // Padding interno para o card
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment
                              .center, // Alinha os itens verticalmente ao centro
                          children: [
                            // Coluna com os detalhes do agendamento
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    agendamento.categoria,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(Icons.calendar_today,
                                          size: 16, color: Color(0xFF629460)),
                                      SizedBox(width: 5),
                                      Text(
                                        agendamento.data,
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(Icons.access_time,
                                          size: 16, color: Color(0xFF629460)),
                                      SizedBox(width: 5),
                                      Text(
                                        agendamento.horario,
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(Icons.location_on,
                                          size: 16, color: Color(0xFF629460)),
                                      SizedBox(width: 5),
                                      Text(
                                        agendamento.local,
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            // Ícones de editar e excluir
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            EditarAgendamentoPage(
                                                agendamento: agendamento),
                                      ),
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    _excluirAgendamento(
                                        context, agendamento.id);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
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
