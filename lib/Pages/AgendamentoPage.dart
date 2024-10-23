import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Para formatar a data.

class AgendamentoPage extends StatefulWidget {
  const AgendamentoPage({super.key});

  @override
  _AgendamentoPageState createState() => _AgendamentoPageState();
}

class _AgendamentoPageState extends State<AgendamentoPage> {
  String? categoriaSelecionada;
  String? servicoSelecionado;
  String? localAtendimentoSelecionado;
  DateTime? dataSelecionada;

  // Lista de opções para o Dropdown de categorias.
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

  // Função para exibir o DatePicker (seleção de data).
  Future<void> _selecionarData(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dataSelecionada ?? DateTime.now(), // Data inicial.
      firstDate: DateTime(2020), // Data mínima.
      lastDate: DateTime(2101), // Data máxima.
    );
    if (picked != null && picked != dataSelecionada) {
      setState(() {
        dataSelecionada = picked;
      });
    }
  }

  // Função para mostrar o bottom sheet com horários.
  void _mostrarHorarios(BuildContext context) {
    // Gera os horários disponíveis.
    List<String> horarios = [];
    DateTime currentTime = DateTime(2024, 10, 22, 8); // Começa às 08:00

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
              // Cria a grade de horários
              Container(
                height: 300, // Defina uma altura fixa para evitar overflow
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.5, // Ajuste a proporção dos botões
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: horarios.length,
                  itemBuilder: (context, index) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white, // Texto preto
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(8), // Bordas arredondadas
                        ),
                        padding: EdgeInsets.symmetric(vertical: 16),
                        side: BorderSide(color: Colors.black), // Borda preta
                      ),
                      onPressed: () {
                        // Aqui você pode adicionar a lógica para quando o horário é selecionado.
                        Navigator.pop(context); // Fecha o bottom sheet
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text("Horário selecionado: ${horarios[index]}"),
                          ),
                        );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Ícone de seta para voltar.
          onPressed: () {
            Navigator.pop(context); // Retorna à tela anterior.
          },
        ),
        title: const Text("Agendamento de Serviços"),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        // Adicionando o SingleChildScrollView aqui
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cabeçalho da página
              Text(
                "Dados Pessoa",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              // Campo de Nome
              TextField(
                decoration: InputDecoration(
                  labelText: "Nome",
                  border: OutlineInputBorder(),
                  hintText: "Digite seu nome",
                ),
              ),
              const SizedBox(height: 20),

              // Campo de CPF
              TextField(
                decoration: InputDecoration(
                  labelText: "CPF",
                  border: OutlineInputBorder(),
                  hintText: "Digite seu CPF",
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 30),

              // Título "Dados do Agendamento"
              Text(
                "Dados do Agendamento",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              // Categoria (Dropdown)
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

              // Campo de Serviço (Dropdown)
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

              // Campo de Local de Atendimento (Dropdown)
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

              // Campo de Data (Date Picker)
              TextField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "Data",
                  border: OutlineInputBorder(),
                  hintText: dataSelecionada == null
                      ? "Selecione uma data"
                      : DateFormat('dd/MM/yyyy').format(dataSelecionada!),
                ),
                onTap: () => _selecionarData(
                    context), // Abre o calendário ao clicar no campo.
              ),
              const SizedBox(height: 30),

              // Botão de Consultar Horários (Centralizado e Ajustado)
              Center(
                child: SizedBox(
                  width: double.infinity, // Preenche toda a largura disponível.
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _mostrarHorarios(context); // Mostra os horários ao clicar
                    },
                    icon: Icon(Icons.search),
                    label: Text("Consultar Horários"),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          vertical: 15), // Ajuste de altura.
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Bordas arredondadas.
                      ),
                      backgroundColor: Colors.blue, // Cor de fundo do botão
                      foregroundColor: Colors.black,
                    ),
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
