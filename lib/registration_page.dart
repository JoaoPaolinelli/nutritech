import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:nutri_tech/database/Db.dart';
import 'package:nutri_tech/home_page.dart';
import 'package:nutri_tech/login_page.dart';
import 'package:nutri_tech/models/User.dart';
class RegistrationPage extends StatefulWidget {
  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {

  final _conEmail = TextEditingController();
  final _conPassword = TextEditingController();
  final _conNome = TextEditingController();
  final _conData = TextEditingController();
  var db;
  var validation = true;

  @override
  void initState() {
    super.initState();
    db = Db();
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Erro"),
          content: new Text("Falha ao criar usuário, verifique os dados e tente novamente."),
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
  cadastrar() async {

    String email = _conEmail.text;
    String senha = _conPassword.text;
    String nome = _conNome.text;
    String data = _conData.text;
    print(email + ' '+ senha + ' ' + nome + ' ' + data);
    User novo = User(nome,data,email,senha);
    await db.saveData(novo).then((userData) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => LoginPage()),
              (Route<dynamic> route) => false);
    }).catchError((error) {
      _showDialog(context);
    });
    }
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
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
                controller: _conNome,
                decoration: const InputDecoration(
                    labelText: "Nome completo",
                    border: OutlineInputBorder()
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _conData,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: "Dada de nascimento",
                    hintText: "dd/mm/aaaa",
                    border: OutlineInputBorder()
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _conEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    labelText: "E-mail",
                    hintText: "exemplo@email.com",
                    border: OutlineInputBorder()
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _conPassword,
                decoration: const InputDecoration(
                    labelText: "Senha",
                    border: OutlineInputBorder()
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.orange,
                ),
                onPressed: cadastrar,
                child: Text('Confirmar'),
              ),
              const SizedBox(height: 0),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.orange,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Text('Voltar'),
              ),
            ],
          ),
        ),
        )
      )
    );
  }
}
