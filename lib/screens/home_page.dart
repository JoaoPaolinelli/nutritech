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
        title: Text('HomePage'),
        backgroundColor: Colors.orange,
        actions: [CustomSwitch()],
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
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
                  height: 500,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: _conEmail.text,
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText:  _conUserName.text,
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],),
                ),
                Container(
                  height: 500,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.blue,
                ),
                Container(
                  height: 500,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.red,
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.orange,
        onPressed: () {
          setState(() {
            counter++;
          });
        },
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
