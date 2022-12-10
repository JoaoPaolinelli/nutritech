import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:nutri_tech/database/Db.dart';
import 'package:nutri_tech/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nutri_tech/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  final _formKey = GlobalKey<FormState>();

  final _conEmail = TextEditingController();
  final _conPassword = TextEditingController();
  var db;

  @override
  void initState() {
    super.initState();
    db = Db();
  }

  login() async {
    User um = User("testNome", "testemail", "123");
    String email = _conEmail.text;
    String pass = _conPassword.text;
     await db.saveData(um).then((userData) {
      print("Successfully Saved");
    }).catchError((error) {
      print(error);
      print("Error: Data Save Fail");
    });
    if (email.isEmpty) {
      _showDialog(context);
    } else if (pass.isEmpty) {
      _showDialog(context);
    } else {
      await db.getLoginUser(email, pass).then((userData) {
        if (userData != null) {
          setSP(userData).whenComplete(() {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => HomePage()),
                (Route<dynamic> route) => false);
          });
        } else {
          _showDialog(context);
        }
      }).catchError((error) {
        print(error);
        _showDialog(context);
      });
    }
  }

  Future setSP(User user) async {
    final SharedPreferences sp = await _pref;
    int id = user.user_id ?? 0;
    String name = user.user_name ?? "test";
    String email = user.email ?? "test";
    String pass = user.password ?? "test";
    sp.setInt("user_id", id);
    sp.setString("user_name", name);
    sp.setString("email", email);
    sp.setString("password", pass);
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Falha ao logar!"),
          content: new Text("Email ou senha incorretos!"),
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
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Container(
                  width: 200,
                  height: 200,
                  child: Image.asset('images/logo_empresa.png'),
                ),
                Container(
                  height: 10,
                ),
                TextField(
                  controller: _conEmail,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _conPassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 15),
                TextButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.orange),
                  ),
                  onPressed: login,
                  child: Text('Entrar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
