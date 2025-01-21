import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:local_auth/local_auth.dart';

import 'HomePage.dart';
import 'CadastroPage.dart';
import '../models/user_provider.dart';
import '../models/App_User.dart';
import '../widgets/DetranTitle.dart';
// Certifique-se de importar o pacote

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  final LocalAuthentication _localAuth = LocalAuthentication();
  final email = TextEditingController();
  final _senha = TextEditingController();
  bool _exibirSenha = false;
  final _formKey = GlobalKey<FormState>();
  final LocalAuthentication auth = LocalAuthentication();
  bool _rememberMe = false;

  // Verifica se a biometria está disponível no dispositivo
  Future<bool> _isBiometricAvailable() async {
    try {
      return await auth.canCheckBiometrics || await auth.isDeviceSupported();
    } catch (e) {
      print('Erro ao verificar biometria: $e');
      return false;
    }
  }

  // Realiza a autenticação biométrica

  // Simula o login após autenticação biométrica
  Future<void> _loginWithBiometrics() async {
    setState(() {
      _isLoading = true; // Inicia o carregamento
    });

    try {
      // Verifica se o dispositivo suporta autenticação biométrica
      bool isAvailable = await _localAuth.canCheckBiometrics;
      if (!isAvailable) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Biometria não disponível ou não configurada")),
        );
        return;
      }

      // Realiza a autenticação biométrica
      bool isAuthenticated = await _localAuth.authenticate(
        localizedReason: 'Autentique-se para fazer login',
        options: AuthenticationOptions(
          stickyAuth: true,
        ),
      );

      if (isAuthenticated) {
        // Aqui você pode fazer o login com a autenticação biométrica
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          final userProvider =
              Provider.of<UserProvider>(context, listen: false);
          userProvider.login(user, _rememberMe);

          // Redireciona o usuário para a página principal após o login
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    HomePage()), // Substitua pela sua página inicial
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Usuário não autenticado")),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Autenticação falhou")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao realizar autenticação biométrica: $e")),
      );
    } finally {
      setState(() {
        _isLoading = false; // Finaliza o carregamento
      });
    }
  }

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
      userProvider.login(userCredential.user!, _rememberMe);

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
                    _buildTextField(
                      controller: email,
                      label: "Email",
                      hint: "Inserir email",
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                      controller: _senha,
                      label: "Senha",
                      hint: "Inserir senha",
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
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Checkbox(
                          value: _rememberMe,
                          onChanged: (value) {
                            setState(() {
                              _rememberMe = value!;
                            });
                          },
                        ),
                        Text('Manter-me conectado'),
                      ],
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
                      child: const Text("Entrar"),
                    ),
                    ElevatedButton.icon(
                      onPressed: _isLoading ? null : _loginWithBiometrics,
                      icon: const Icon(Icons.fingerprint),
                      label: const Text("Login com biometria"),
                    ),
                    TextButton(
                      onPressed: _isLoading
                          ? null
                          : () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CadastroPage(),
                                ),
                              );
                            },
                      child: const Text("Não Possui Conta? Cadastre-se!"),
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
                child: CircularProgressIndicator(),
              ),
            ),
        ],
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
