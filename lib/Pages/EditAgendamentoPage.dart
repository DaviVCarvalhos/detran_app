import 'package:detranapp/widgets/DetranTitle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:detranapp/models/agendamento_provider.dart';
import 'package:detranapp/models/Agendamento.dart';

class EditarAgendamentoPage extends StatefulWidget {
  final Agendamento agendamento;

  EditarAgendamentoPage({required this.agendamento});

  @override
  _EditarAgendamentoPageState createState() => _EditarAgendamentoPageState();
}

class _EditarAgendamentoPageState extends State<EditarAgendamentoPage> {
  final _formKey = GlobalKey<FormState>();
  late String _categoria;
  late String _data;
  late String _hora;
  late String _status;
  late String _local;

  @override
  void initState() {
    super.initState();
    _categoria = widget.agendamento.categoria;
    _data = widget.agendamento.data;
    _hora = widget.agendamento.hora;
    _status = widget.agendamento.status;
    _local = widget.agendamento.local;
  }

  void _salvarAlteracoes() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save(); 

      final updatedAgendamento = Agendamento(
        id: widget.agendamento.id,
        categoria: _categoria,
        data: _data,
        hora: _hora,
        status: _status,
        userId: widget.agendamento.userId,
        local: _local,
      );

      try {
        await Provider.of<AgendamentoProvider>(context, listen: false)
            .editarAgendamento(widget.agendamento.id, updatedAgendamento);

        Navigator.of(context).pop();

        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Agendamento editado com sucesso!')));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erro ao editar agendamento: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: DetranTitle(),
        backgroundColor: Color(0xFF629460),
        leading: BackButton(
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _categoria,
                decoration: InputDecoration(labelText: 'Categoria'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira uma categoria';
                  }
                  return null;
                },
                onSaved: (value) {
                  _categoria = value!;
                },
              ),
              TextFormField(
                initialValue: _data,
                decoration: InputDecoration(labelText: 'Data'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira uma data';
                  }
                  return null;
                },
                onSaved: (value) {
                  _data = value!;
                },
              ),
              TextFormField(
                initialValue: _hora,
                decoration: InputDecoration(labelText: 'Hora'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira uma hora';
                  }
                  return null;
                },
                onSaved: (value) {
                  _hora = value!;
                },
              ),
              TextFormField(
                initialValue: _status,
                decoration: InputDecoration(labelText: 'Status'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um status';
                  }
                  return null;
                },
                onSaved: (value) {
                  _status = value!;
                },
              ),
              TextFormField(
                initialValue: _local,
                decoration: InputDecoration(labelText: 'Local'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um local';
                  }
                  return null;
                },
                onSaved: (value) {
                  _local = value!;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _salvarAlteracoes,
                child: Text('Salvar Alterações'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
