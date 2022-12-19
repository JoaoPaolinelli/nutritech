import 'package:flutter/material.dart';
import 'package:nutri_tech/app_controller.dart';

import 'package:nutri_tech/home_page.dart';
import 'package:nutri_tech/login_page.dart';
import 'package:nutri_tech/user_list.dart';
import 'package:nutri_tech/registration_page.dart';
class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppController.instance,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primaryColor: Colors.red,
              brightness: AppController.instance.isDarkTheme
                  ? Brightness.dark
                  : Brightness.light),
          home: LoginPage(),
          //home: RegistrationPage(),
          //home: HomePage(),
        );
      },
    );
  }
}
