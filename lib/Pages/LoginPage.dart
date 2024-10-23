
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text("DetranApp",style:TextStyle(color:Colors.white)),
          centerTitle: true,
          leading: BackButton(
            color: Colors.white
          ),
          backgroundColor: const Color.fromARGB(255, 4, 0, 248),
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(30),
            margin: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: screenSize.width/4,
                  height: screenSize.height/5,
                  child: Image(
                  image: AssetImage('images/detranlogo.jpg'),      
            ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: screenSize.width/2,
                  height: screenSize.height/7,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("CPF"),
                        ],
                      ),
                      TextField(
                        cursorColor: const Color.fromARGB(255, 52, 104, 248),
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color:const Color.fromARGB(255, 52, 104, 248),)
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
                ),
                Container(
                   width: screenSize.width/2,
                  height: screenSize.height/7,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Senha",
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      TextField(
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color:const Color.fromARGB(255, 52, 104, 248),)
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
                ),
                Expanded(
                  child: Container(

                    width: screenSize.width / 0.5,
                  height: screenSize.height,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                          value: false,
                          onChanged: (bool) {},
                        ),
                        Text(
                          "Manter senha",
                          style: TextStyle(fontSize: 11),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text("Esqueceu sua senha?",style: TextStyle(color: const Color.fromARGB(255, 52, 104, 248),
                          fontSize: 11,
                          
                          )
                          
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () { print("clicou!");},
                    style: ElevatedButton.styleFrom(
                      backgroundColor:  const Color.fromARGB(255, 4, 0, 248),
                       padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10)
                    ), 
                    child: Text("Entrar", style: TextStyle(color: const Color.fromARGB(255, 230, 230, 230)),),
                            
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                
              ],
            ),
          ),
        )
        );
  }
}