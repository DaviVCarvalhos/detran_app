import 'package:detranapp/Pages/CadastroPage.dart';
import 'package:detranapp/models/App_User.dart';
import 'package:detranapp/models/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:detranapp/Pages/HomePage.dart';
import 'package:detranapp/widgets/DetranTitle.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;

  final email = TextEditingController();
  final _senha = TextEditingController();
  bool _exibirSenha = false;
  final _formKey = GlobalKey<FormState>();

  Future<void> loginWithEmailPassword() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: _senha.text.trim(),
      );

      final userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.login(userCredential.user!);

      App_User? appUser = await userProvider.getUserDataFromDatabase();

      if (appUser != null) {
        print(appUser.cpf);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Bem-vindo, ${userCredential.user?.email}!")),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'user-not-found') {
        message = 'Usuário não encontrado.';
      } else if (e.code == 'wrong-password') {
        message = 'Senha incorreta.';
      } else {
        message = 'Erro ao fazer login: ${e.message}';
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const DetranTitle(),
        centerTitle: true,
        leading: const BackButton(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 0, 128, 198),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('images/detranlogo.jpg'),
                    const SizedBox(height: 20),
                    // Seus widgets de input e botões
                    Column(
                      children: [
                        Row(
                          children: const [
                            Text(
                              "Email",
                              style: TextStyle(
                                color: Color.fromARGB(255, 0, 128, 198),
                              ),
                            ),
                          ],
                        ),
                        TextFormField(
                          controller: email,
                          decoration: const InputDecoration(
                            hintText: "Inserir email",
                            hintStyle:
                                TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          validator: (email) {
                            if (email == null || email.isEmpty) {
                              return 'Insira seu email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: const [
                            Text(
                              "Senha",
                              style: TextStyle(
                                color: Color.fromARGB(255, 0, 128, 198),
                              ),
                            ),
                          ],
                        ),
                        TextFormField(
                          controller: _senha,
                          obscureText: !_exibirSenha,
                          decoration: InputDecoration(
                            hintText: "Inserir senha",
                            hintStyle: const TextStyle(
                                fontSize: 12, color: Colors.grey),
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
                          validator: (senha) {
                            if (senha == null || senha.isEmpty) {
                              return 'Informe a sua senha';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _isLoading
                              ? null
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                    loginWithEmailPassword();
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 0, 128, 198),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                          ),
                          child: const Text(
                            "Entrar",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        TextButton(
                          onPressed: _isLoading
                              ? null
                              : () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const CadastroPage(),
                                    ),
                                  );
                                },
                          child: const Text(
                            "Não Possui Conta? Cadastre-se!",
                            style: TextStyle(
                              color: Color.fromARGB(255, 52, 104, 248),
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Color.fromARGB(255, 0, 128, 198)),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
