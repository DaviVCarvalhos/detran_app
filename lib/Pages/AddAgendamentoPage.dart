import 'package:detranapp/models/Agendamento.dart';
import 'package:detranapp/widgets/DetranTitle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:detranapp/models/agendamento_provider.dart';

import 'package:intl/intl.dart';

class AdicionarAgendamentoPage extends StatefulWidget {
  final userId;
  const AdicionarAgendamentoPage({super.key, required this.userId});

  @override
  _AdicionarAgendamentoPageState createState() =>
      _AdicionarAgendamentoPageState();
}

class _AdicionarAgendamentoPageState extends State<AdicionarAgendamentoPage> {
  String? categoriaSelecionada;
  String? servicoSelecionado;
  String? localAtendimentoSelecionado;
  DateTime? dataSelecionada;
  String? horarioSelecionado;

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

  Future<void> _selecionarData(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dataSelecionada ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != dataSelecionada) {
      setState(() {
        dataSelecionada = picked;
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
                          horarioSelecionado = horarios[index];
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

  Future<void> _salvarAgendamento() async {
    if (categoriaSelecionada != null &&
        servicoSelecionado != null &&
        localAtendimentoSelecionado != null &&
        dataSelecionada != null &&
        horarioSelecionado != null) {
      final agendamento = Agendamento(
        id: '',
        categoria: categoriaSelecionada!,
        servico: servicoSelecionado!,
        data: DateFormat('dd/MM/yyyy').format(dataSelecionada!),
        horario: horarioSelecionado!,
        userId: widget.userId,
        local: localAtendimentoSelecionado!,
      );

      try {
        await Provider.of<AgendamentoProvider>(context, listen: false)
            .adicionarAgendamento(agendamento);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Agendamento salvo com sucesso!")),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro ao salvar o agendamento.")),
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
        centerTitle: true,
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
                value: categoriaSelecionada,
                items: categorias.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    categoriaSelecionada = newValue;
                  });
                },
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: "Serviço",
                  border: OutlineInputBorder(),
                ),
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
                    servicoSelecionado = newValue;
                  });
                },
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: "Local de Atendimento",
                  border: OutlineInputBorder(),
                ),
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
                    localAtendimentoSelecionado = newValue;
                  });
                },
              ),
              const SizedBox(height: 20),
              TextField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "Data",
                  border: OutlineInputBorder(),
                  hintText: dataSelecionada == null
                      ? "Selecione uma data"
                      : DateFormat('dd/MM/yyyy').format(dataSelecionada!),
                ),
                onTap: () => _selecionarData(context),
              ),
              const SizedBox(height: 30),
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: horarioSelecionado == null
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
                          onPressed: _salvarAgendamento,
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                          ),
                          child: Text("Salvar Agendamento"),
                        ),
                ),
              ),
              if (horarioSelecionado != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    "Horário Selecionado: $horarioSelecionado",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
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
