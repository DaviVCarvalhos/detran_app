import 'package:detranapp/widgets/DetranTitle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:detranapp/models/agendamento_provider.dart';
import 'package:detranapp/models/Agendamento.dart';

class AdicionarAgendamentoPage extends StatefulWidget {
  final String userId;

  AdicionarAgendamentoPage({required this.userId});

  @override
  _AdicionarAgendamentoPageState createState() =>
      _AdicionarAgendamentoPageState();
}

class _AdicionarAgendamentoPageState extends State<AdicionarAgendamentoPage> {
  final _formKey = GlobalKey<FormState>();
  String _categoria = '';
  String _data = '';
  String _hora = '';
  String _local = '';
  String _status = 'Agendado';

  Future<void> _adicionarAgendamento() async {
    if (_formKey.currentState?.validate() ?? false) {
      final agendamento = Agendamento(
        id: '',
        categoria: _categoria,
        data: _data,
        hora: _hora,
        status: _status,
        userId: widget.userId,
        local: _local,
      );

      try {
        await Provider.of<AgendamentoProvider>(context, listen: false)
            .adicionarAgendamento(agendamento);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Agendamento adicionado com sucesso!')));
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erro ao adicionar agendamento: $e')));
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildTextFormField(
                  label: 'Categoria',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira a categoria do agendamento';
                    }
                    return null;
                  },
                  onChanged: (value) => _categoria = value,
                ),
                _buildTextFormField(
                  label: 'Data (YYYY-MM-DD)',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira a data do agendamento';
                    }
                    return null;
                  },
                  onChanged: (value) => _data = value,
                ),
                _buildTextFormField(
                  label: 'Hora',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira a hora';
                    }
                    return null;
                  },
                  onChanged: (value) => _hora = value,
                ),
                _buildTextFormField(
                  label: 'Local',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o local';
                    }
                    return null;
                  },
                  onChanged: (value) => _local = value,
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: _adicionarAgendamento,
                    child: Text('Adicionar Agendamento'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required String label,
    required String? Function(String?) validator,
    required ValueChanged<String> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        validator: validator,
        onChanged: onChanged,
      ),
    );
  }
}
