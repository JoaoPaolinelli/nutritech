import 'package:flutter/material.dart';
import 'package:nutri_tech/app_controller.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nutri_tech/database/Db.dart';
import 'package:nutri_tech/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nutri_tech/home_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  int counter = 0;
  int currentIndex = 0;

  Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  var db;
  final _conUserId = TextEditingController();
  final _conDelUserId = TextEditingController();
  final _conUserName = TextEditingController();
  final _conEmail = TextEditingController();
  final _conPassword = TextEditingController();

  Future<void> getUserData() async {
    final SharedPreferences sp = await _pref;

    setState(() {
      _conUserId.text = sp.getInt("user_id").toString();
      _conDelUserId.text = sp.getInt("user_id").toString();
      _conUserName.text = sp.getString("user_name").toString();
      _conEmail.text = sp.getString("email").toString();
      _conPassword.text = sp.getString("password").toString();
      print(_conUserName);
    });
  }

  @override
  void initState() {
    super.initState();
    getUserData();
    db = Db();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Image.asset('images/logo_empresa.png'),
          width: 60,
          margin: const EdgeInsets.only(bottom: 5.0),
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        actions: [CustomSwitch()],
      ),
      body: Container(
        // margin: const EdgeInsets.only(bottom: 100.0),
        width: double.infinity,
        height: double.infinity,
        child: ListView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: [
            // Text('Contador: $counter'),
            // Container(height: 10),
            // CustomSwitch(),
            // Container(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 600,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            ClipOval(
                              child: Container(
                                alignment: Alignment.center,
                                width: 180,
                                height: 180,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromARGB(255, 204, 204, 204),
                                  border: Border.all(
                                      color: Colors.orange, width: 5),
                                ),
                                child: Text(
                                  textAlign: TextAlign.center,
                                  "Foto",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text('editar perfil',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.orange,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(height: 50),
                            Text('Olá, Nome',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    // color: Colors.black,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 600,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.blue,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [],
                  ),
                ),
                Container(
                  height: 600,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.red,
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0.0,
        selectedItemColor: Colors.orange,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flatware_outlined),
            label: 'Criar Receita',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_numbered),
            label: 'Clientes',
          ),
        ],
      ),
    );
  }
}

class CustomSwitch extends StatelessWidget {
  const CustomSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: AppController.instance.isDarkTheme,
      onChanged: (value) {
        AppController.instance.changeTheme();
      },
    );
  }
}
