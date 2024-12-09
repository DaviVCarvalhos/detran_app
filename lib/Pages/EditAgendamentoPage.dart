import 'package:detranapp/widgets/DetranTitle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:detranapp/models/agendamento_provider.dart';
import 'package:detranapp/models/Agendamento.dart';
import 'package:intl/intl.dart';

class EditarAgendamentoPage extends StatefulWidget {
  final Agendamento agendamento;

  EditarAgendamentoPage({required this.agendamento});

  @override
  _EditarAgendamentoPageState createState() => _EditarAgendamentoPageState();
}

class _EditarAgendamentoPageState extends State<EditarAgendamentoPage> {
  final _formKey = GlobalKey<FormState>();
  String? _categoria;
  String? _servico;
  String? _local;
  DateTime? _dataSelecionada;
  String? _horarioSelecionado;

  final List<String> categorias = [
    "ATENDIMENTOS CNH",
    "CRT",
    "ENTREGA CNH EMITIDA",
    "ENTREGA CNH RECOLHIDA",
    "CNH POPULAR",
    "EXAMES PRÁTICOS",
    "EXAMES TEÓRICOS",
    "MUTIRÃO CNH",
  ];

  @override
  void initState() {
    super.initState();
    _categoria = widget.agendamento.categoria;
    _servico = widget.agendamento.servico;
    _local = widget.agendamento.local;
    _dataSelecionada = DateFormat('dd/MM/yyyy').parse(widget.agendamento.data);
    _horarioSelecionado = widget.agendamento.horario;
  }

  Future<void> _selecionarData(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dataSelecionada ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _dataSelecionada) {
      setState(() {
        _dataSelecionada = picked;
      });
    }
  }

  void _mostrarHorarios(BuildContext context) {
    List<String> horarios = [];
    DateTime currentTime = DateTime(2024, 10, 22, 8);

    while (currentTime.hour < 18) {
      horarios.add(DateFormat('HH:mm').format(currentTime));
      currentTime = currentTime.add(Duration(minutes: 30));
    }

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Selecione um horário",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Container(
                height: 300,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.5,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: horarios.length,
                  itemBuilder: (context, index) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 16),
                        side: BorderSide(color: Colors.black),
                      ),
                      onPressed: () {
                        setState(() {
                          _horarioSelecionado = horarios[index];
                        });
                        Navigator.pop(context);
                      },
                      child: Text(
                        horarios[index],
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _salvarAlteracoes() async {
    if (_categoria != null &&
        _servico != null &&
        _local != null &&
        _dataSelecionada != null &&
        _horarioSelecionado != null) {
      final updatedAgendamento = Agendamento(
        id: widget.agendamento.id,
        categoria: _categoria!,
        servico: _servico!,
        data: DateFormat('dd/MM/yyyy').format(_dataSelecionada!),
        horario: _horarioSelecionado!,
        userId: widget.agendamento.userId,
        local: _local!,
      );

      try {
        await Provider.of<AgendamentoProvider>(context, listen: false)
            .editarAgendamento(widget.agendamento.id, updatedAgendamento);

        Navigator.of(context).pop(true); 

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Agendamento editado com sucesso!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao editar agendamento: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Preencha todos os campos antes de salvar.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: DetranTitle(),
        backgroundColor: Color(0xFF629460),
        leading: BackButton(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Dados do Agendamento",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: "Categoria",
                  border: OutlineInputBorder(),
                ),
                value: _categoria,
                items: categorias.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _categoria = newValue;
                  });
                },
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: "Serviço",
                  border: OutlineInputBorder(),
                ),
                value: _servico,
                items: <String>[
                  'Renovação de CNH',
                  '2ª Via de CNH',
                  'Alteração de Dados',
                  'Outros'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _servico = newValue;
                  });
                },
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: "Local de Atendimento",
                  border: OutlineInputBorder(),
                ),
                value: _local,
                items: <String>[
                  'Unidade Central',
                  'Unidade Norte',
                  'Unidade Sul'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _local = newValue;
                  });
                },
              ),
              const SizedBox(height: 20),
              TextField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "Data",
                  border: OutlineInputBorder(),
                  hintText: _dataSelecionada == null
                      ? "Selecione uma data"
                      : DateFormat('dd/MM/yyyy').format(_dataSelecionada!),
                ),
                onTap: () => _selecionarData(context),
              ),
              const SizedBox(height: 30),
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: _horarioSelecionado == null
                      ? ElevatedButton.icon(
                          onPressed: () {
                            _mostrarHorarios(context);
                          },
                          icon: Icon(Icons.search),
                          label: Text("Consultar Horários"),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Color(0xFF629460),
                            foregroundColor: Colors.white,
                          ),
                        )
                      : ElevatedButton(
                          onPressed: _salvarAlteracoes,
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                          ),
                          child: Text("Salvar Alterações"),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
