
import 'package:detranapp/widgets/DetranTitle.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('images/detranlogo.jpg'),
              const SizedBox(height: 20),
              Column(
                children: [
                  Row(
                    children: const [
                      Text("CPF"),
                    ],
                  ),
                  TextField(
                    cursorColor: const Color.fromARGB(255, 52, 104, 248),
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color:  const Color.fromARGB(255, 0, 128, 198),
                        ),
                      ),
                      hintText: "Inserir CPF",
                      hintStyle: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  Row(
                    children: const [
                      Text("Senha", textAlign: TextAlign.left),
                    ],
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: const Color.fromARGB(255, 0, 128, 198),
                        ),
                      ),
                      hintText: "Inserir Senha",
                      hintStyle: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: false,
                    onChanged: (bool? value) {},
                  ),
                  const Text(
                    "Manter senha",
                    style: TextStyle(fontSize: 11),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Esqueceu sua senha?",
                      style: TextStyle(
                        color: Color.fromARGB(255, 52, 104, 248),
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  print("clicou!");
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
      ),
    );
  }
}
