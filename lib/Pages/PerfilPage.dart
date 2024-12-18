import 'package:detranapp/models/User.dart';
import 'package:flutter/material.dart';

class PerfilPage extends StatefulWidget {
  final User user;

  PerfilPage({required this.user});

  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  late TextEditingController _nomeController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _cpfController;
  late TextEditingController _datanascimentoController;

  bool _isEditing = false;

  @override
  void initState() {
    super.initState();

    _nomeController = TextEditingController(text: widget.user.nome);
    _emailController = TextEditingController(text: widget.user.email);
    _phoneController = TextEditingController(text: widget.user.phone_number);
    _cpfController = TextEditingController(text: widget.user.cpf);
    _datanascimentoController = TextEditingController(
        text: widget.user.datanascimento.toIso8601String().split('T').first);
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _cpfController.dispose();
    _datanascimentoController.dispose();
    super.dispose();
  }

  InputDecoration getTextFieldDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Color.fromARGB(255, 0, 128, 198),
        ),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        borderSide: BorderSide(
          color: Color.fromRGBO(7, 44, 252, 1),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Meu Perfil',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 0, 128, 198),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                cursorColor: const Color.fromARGB(255, 52, 104, 248),
                decoration: getTextFieldDecoration('Nome'),
                enabled: _isEditing,
              ),
              TextFormField(
                controller: _emailController,
                cursorColor: const Color.fromARGB(255, 52, 104, 248),
                decoration: getTextFieldDecoration('Email'),
                enabled: _isEditing,
              ),
              TextFormField(
                controller: _phoneController,
                cursorColor: const Color.fromARGB(255, 52, 104, 248),
                decoration: getTextFieldDecoration('Telefone'),
                enabled: _isEditing,
              ),
              TextFormField(
                controller: _cpfController,
                cursorColor: const Color.fromARGB(255, 52, 104, 248),
                decoration: getTextFieldDecoration('CPF'),
                enabled: _isEditing,
              ),
              TextFormField(
                controller: _datanascimentoController,
                cursorColor: const Color.fromARGB(255, 52, 104, 248),
                decoration: getTextFieldDecoration('Data de Nascimento'),
                enabled: _isEditing,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 0, 128, 198),
                ),
                onPressed: () {
                  setState(() {
                    if (_isEditing) {
                      widget.user.nome = _nomeController.text;
                      widget.user.email = _emailController.text;
                      widget.user.phone_number = _phoneController.text;
                      widget.user.cpf = _cpfController.text;
                      widget.user.datanascimento =
                          DateTime.parse(_datanascimentoController.text);
                    }
                    _isEditing = !_isEditing;
                  });
                },
                child: Text(
                  _isEditing ? 'Salvar' : 'Editar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
