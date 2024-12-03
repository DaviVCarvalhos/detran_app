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
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 20),
                Center(
                  child: const Text(
                    "Preencha os dados para cadastro",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 128, 198),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  controller: _nomeController,
                  label: "Nome",
                  hint: "Digite seu nome completo",
                ),
                const SizedBox(height: 15),
                _buildTextField(
                  controller: _cpfController,
                  label: "CPF",
                  hint: "Digite seu CPF",
                ),
                const SizedBox(height: 15),
                _buildTextField(
                  controller: _emailController,
                  label: "E-mail",
                  hint: "Digite seu e-mail",
                ),
                const SizedBox(height: 15),
                _buildTextField(
                  controller: _senhaController,
                  label: "Senha",
                  hint: "Digite sua senha",
                  obscureText: !_exibirSenha,
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
                const SizedBox(height: 15),
                _buildTextField(
                  controller: _confirmarSenhaController,
                  label: "Confirmar Senha",
                  hint: "Confirme sua senha",
                  obscureText: !_exibirSenha,
                ),
                const SizedBox(height: 15),
                _buildTextField(
                  controller: _telefoneController,
                  label: "Telefone",
                  hint: "Digite seu telefone",
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _dataNascimentoController,
                  readOnly: true,
                  style: const TextStyle(color: Color(0xFF0E64B7)),
                  decoration: InputDecoration(
                    labelText: "Data de Nascimento",
                    labelStyle: const TextStyle(color: Color(0xFF0E64B7)),
                    hintStyle: const TextStyle(color: Color(0xFF6EA8FE)),
                    suffixIcon: Icon(Icons.calendar_month),
                    filled: false,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color(0xFF6EA8FE), width: 1.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Color(0xFF0E64B7), width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.red, width: 1.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.red, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onTap: () async {
                    DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                      locale: const Locale('pt', 'BR'),
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
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
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
                                content:
                                    Text("Usuário registrado com sucesso!")),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildTextField({
  required TextEditingController controller,
  required String label,
  required String hint,
  bool obscureText = false,
  Widget? suffixIcon,
}) {
  return TextFormField(
    controller: controller,
    obscureText: obscureText,
    style: const TextStyle(color: Color(0xFF0E64B7)),
    decoration: InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Color(0xFF0E64B7)),
      hintText: hint,
      hintStyle: const TextStyle(color: Color(0xFF6EA8FE)),
      suffixIcon: suffixIcon,
      filled: false,
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFF6EA8FE), width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFF0E64B7), width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red, width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Por favor, insira ${label.toLowerCase()}';
      }
      return null;
    },
  );
}
