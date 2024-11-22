
import 'package:detranapp/Pages/CadastroPage.dart';
import 'package:detranapp/widgets/DetranTitle.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

 final email = TextEditingController();
  final _senha = TextEditingController();
  bool _exibirSenha = false;
final _formKey = GlobalKey<FormState>();

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
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('images/detranlogo.jpg'),
                const SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    
                    children: [
                      Column(
                        children: [
                          Row(
                            children: const [
                              Text("Email",
                              style: TextStyle(color: const Color.fromARGB(255, 0, 128, 198),),
                              ),
                            ],
                          ),
                          TextFormField(
                            controller: email,
                            cursorColor: const Color.fromARGB(255, 52, 104, 248),
                            decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color:  const Color.fromARGB(255, 0, 128, 198),
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                             borderRadius: BorderRadius.all(Radius.circular(4)),
                             borderSide: BorderSide(color: Color.fromRGBO(7, 44, 252, 1), )
                                ),
                              hintText: "Inserir email",
                              hintStyle: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            validator: (email) { // validacao do campo
                              if(email == null || email.isEmpty) {
                                return 'Insira seu email';
                              }
                              return null; // se o campo for valido
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: [
                          Row(
                            children: const [
                              Text("Senha", textAlign: TextAlign.left,
                              style: TextStyle(color: const Color.fromARGB(255, 0, 128, 198),),
                              ),
                            ],
                          ),
                          TextFormField(
                            controller: _senha,
                            obscureText: !_exibirSenha,
                            decoration: InputDecoration(
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: const Color.fromARGB(255, 0, 128, 198),
                                ),
                              ),
                               focusedBorder: UnderlineInputBorder(
                             borderRadius: BorderRadius.all(Radius.circular(4)),
                             borderSide: BorderSide(color: Color.fromRGBO(7, 44, 252, 1), )
                                ),
                              hintText: "Inserir Senha",
                              hintStyle: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _exibirSenha
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined
                                ),
                                onPressed: () {
                                  setState(() {
                                    _exibirSenha = !_exibirSenha;
                                  });
                                },
                              )
                            ),
                            validator: (senha) { // validacao do campo
                              if(senha == null || senha.isEmpty) {
                                return 'Informe a sua senha';
                              }
                              return null; // se o campo for valido
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          
                          TextButton(
                            onPressed: () {
                              Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CadastroPage()),
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
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          print("clicou!");
                          _formKey.currentState!.validate();
                          
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 0, 128, 198),
                          padding:
                              const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        ),
                        child: const Text(
                          "Entrar",
                          style: TextStyle(color: Color.fromARGB(255, 230, 230, 230)),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
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