import 'dart:io';

import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:nutri_tech/app_controller.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nutri_tech/criarReceita_page.dart';
import 'package:nutri_tech/database/Db.dart';
import 'package:nutri_tech/models/User.dart';
<<<<<<< HEAD
=======
import 'package:nutri_tech/screens/clients_screens/all_clients.dart';
>>>>>>> PauloBranch
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nutri_tech/home_page.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:provider/provider.dart';
import 'criarReceita_page.dart';
import 'perfil_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  late PageController controller;
  ValueNotifier<int> page = ValueNotifier(0);

  @override
  void dispose() {
    page.dispose();
    controller.dispose();
    super.dispose();
  }

  changePage(int newPage) {
    controller.animateToPage(
      newPage,
      duration: const Duration(milliseconds: 400),
      curve: Curves.ease,
    );
  }

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
    controller = PageController(initialPage: 0);
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
      body: PageView(
        controller: controller,
        onPageChanged: (page) {
          setState(() {
            currentIndex = page;
          });
        },
        children: [
          Perfil(),
          CriarReceita(),
<<<<<<< HEAD
          Container(
            height: 600,
            width: MediaQuery.of(context).size.width - 20,
            margin: const EdgeInsets.only(left: 10.0, right: 10.0),
            color: Color.fromARGB(5, 0, 0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Tela Listagem de Clientes',
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
=======
          AllClients()
>>>>>>> PauloBranch
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0.0,
        // unselectedItemColor: Colors.grey[500],
        selectedItemColor: Colors.orange,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => {
              currentIndex = index,
              changePage(index),
            }),
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
