import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:nutri_tech/database/Db.dart';
import 'package:nutri_tech/models/User.dart';
import 'package:nutri_tech/registration_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nutri_tech/home_page.dart';
import 'package:nutri_tech/registration_page.dart';

class CreiarClientePage extends StatefulWidget {
  const CreiarClientePage({Key? key}) : super(key: key);

  @override
  State<CreiarClientePage> createState() => _CreiarClientePageState();
}

class _CreiarClientePageState extends State<CreiarClientePage> {

  String nome = "";
  String sobrenome = "";
  String email = "";
  String telefone = "";
  var validation = true;

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Erro"),
          content: new Text("Falha ao criar cliente, verifique os dados e tente novamente."),
          actions: <Widget>[
            new TextButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  height: 150,
                  child: Image.asset('images/logo_empresa.png'),
                ),
                TextField(
                  onChanged: (text) {
                    nome = text;
                    print(nome);
                  },
                  decoration: const InputDecoration(
                      labelText: "Nome",
                      hintText: "José",
                      border: OutlineInputBorder()
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  onChanged: (text) {
                    sobrenome = text;
                    print(sobrenome);
                  },
                  decoration: const InputDecoration(
                      labelText: "Sobrenome",
                      hintText: "Silva",
                      border: OutlineInputBorder()
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  onChanged: (text) {
                    email = text;
                    print(email);
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      labelText: "E-mail",
                      hintText: "exemplo@email.com",
                      border: OutlineInputBorder()
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  onChanged: (text) {
                    telefone = text;
                    print(telefone);
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      labelText: "Telefone",
                      hintText: "(xx) xxxxx-xxxx",
                      border: OutlineInputBorder()
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.orange,
                  ),
                  onPressed: () {
                    if (validation == true) {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HomePage()),
                        // retorno a home() provisorio
                        //deve retornar a tela de clientes
                      );
                    } else {
                      _showDialog(context);
                      print("Login invalido");
                    }
                  },
                  child: Text('Confirmar'),
                ),
                const SizedBox(height: 0),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.orange,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => HomePage()),
                      // retorno a home() provisorio
                      //deve retornar a tela de clientes
                    );
                  },
                  child: Text('Cancelar'),
                ),
              ],
            ),
          ),
        )
    );
  }
}
