import 'package:detranapp/widgets/DetranTitle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _cpfController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmarSenhaController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _dataNascimentoController = TextEditingController();
  bool _exibirSenha = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: DetranTitle(),
        centerTitle: true,
        leading: BackButton(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 0, 128, 198),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 20),
                TextFormField(
                  controller: _nomeController,
                  decoration: const InputDecoration(
                    labelText: "Nome",
                    hintText: "Digite seu nome completo",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu nome';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _cpfController,
                  decoration: const InputDecoration(
                    labelText: "CPF",
                    hintText: "Digite seu CPF",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu CPF';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: "E-mail",
                    hintText: "Digite seu e-mail",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu e-mail';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _senhaController,
                  obscureText: !_exibirSenha,
                  decoration: InputDecoration(
                    labelText: "Senha",
                    hintText: "Digite sua senha",
                    suffixIcon: IconButton(
                      icon: Icon(
                        _exibirSenha
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                      onPressed: () {
                        setState(() {
                          _exibirSenha = !_exibirSenha;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira sua senha';
                    }
                    if (value.length < 6) {
                      return 'A senha deve ter pelo menos 6 caracteres';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _confirmarSenhaController,
                  obscureText: !_exibirSenha,
                  decoration: InputDecoration(
                    labelText: "Confirmar Senha",
                    hintText: "Confirme sua senha",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, confirme sua senha';
                    }
                    if (value != _senhaController.text) {
                      return 'As senhas não coincidem';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _telefoneController,
                  decoration: const InputDecoration(
                    labelText: "Telefone",
                    hintText: "Digite seu telefone",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu telefone';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _dataNascimentoController,
                  readOnly: true, // Torna o campo somente leitura
                  decoration: const InputDecoration(
                    labelText: "Data de Nascimento",
                    hintText: "Selecione sua data de nascimento",
                    suffixIcon:
                        Icon(Icons.calendar_today), // Ícone do calendário
                  ),
                  onTap: () async {
                    DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900), // Limite inferior (ex.: 1900)
                      lastDate: DateTime.now(), // Data máxima (ex.: hoje)
                      locale: const Locale('pt', 'BR'), // Idioma pt-BR
                    );

                    if (selectedDate != null) {
                      setState(() {
                        _dataNascimentoController.text =
                            "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
                      });
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, selecione sua data de nascimento';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        // Registra o usuário no Firebase Authentication
                        UserCredential userCredential = await FirebaseAuth
                            .instance
                            .createUserWithEmailAndPassword(
                          email: _emailController.text.trim(),
                          password: _senhaController.text.trim(),
                        );

                        // Obtém o ID do usuário registrado
                        String userId = userCredential.user!.uid;

                        // Salva dados adicionais no Realtime Database
                        DatabaseReference usersRef =
                            FirebaseDatabase.instance.ref('users');
                        await usersRef.child(userId).set({
                          'nome': _nomeController.text.trim(),
                          'cpf': _cpfController.text.trim(),
                          'email': _emailController.text.trim(),
                          'telefone': _telefoneController.text.trim(),
                          'dataNascimento':
                              _dataNascimentoController.text.trim(),
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Usuário registrado com sucesso!")),
                        );

                        _formKey.currentState!.reset();
                        _nomeController.clear();
                        _cpfController.clear();
                        _emailController.clear();
                        _senhaController.clear();
                        _confirmarSenhaController.clear();
                        _telefoneController.clear();
                        _dataNascimentoController.clear();
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Erro ao registrar: $e")),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 128, 198),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 10,
                    ),
                  ),
                  child: const Text(
                    "Cadastrar",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
