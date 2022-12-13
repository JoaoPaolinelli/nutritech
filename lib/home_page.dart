import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:nutri_tech/app_controller.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nutri_tech/database/Db.dart';
import 'package:nutri_tech/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nutri_tech/home_page.dart';

import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  File? image;

  late PageController controller;
  ValueNotifier<int> page = ValueNotifier(0);

  // @override
  // void initState() {
  //   super.initState();
  //   controller = PageController(initialPage: 0);
  // }

  @override
  void dispose() {
    page.dispose();
    controller.dispose();
    super.dispose();
  }

  updatePage(int newPage) {
    page.value = newPage;
  }

  changePage(int newPage) {
    controller.animateToPage(
      newPage,
      duration: const Duration(milliseconds: 400),
      curve: Curves.ease,
    );
  }

  Future pickImage(source) async {
    try {
      if (source == null) {
        setState(() => this.image = null);
        return;
      }

      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('Erro ao pegar a imagem: $e');
    }
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
        // width: double.infinity,
        // height: double.infinity,

        // physics: PageScrollPhysics(),
        // scrollDirection: Axis.horizontal,
        controller: controller,
        onPageChanged: updatePage,
        children: [
          Container(
            height: 600,
            width: MediaQuery.of(context).size.width - 20,
            margin: const EdgeInsets.only(left: 10.0, right: 10.0),
            color: Color.fromARGB(5, 0, 0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Column(
                    children: [
                      SizedBox(height: 50),
                      ClipOval(
                        child: Container(
                          alignment: Alignment.center,
                          width: 180,
                          height: 180,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 204, 204, 204),
                            border: Border.all(color: Colors.orange, width: 5),
                          ),
                          child: image == null
                              ? Text(
                                  textAlign: TextAlign.center,
                                  "Foto",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                )
                              : Column(
                                  children: [
                                    Spacer(),
                                    ClipOval(
                                      child: Image.file(
                                        image!,
                                        width: 170,
                                        height: 170,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  ],
                                ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.orange,
                            //backgroundColor: Colors.white,
                            textStyle: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            Platform.isIOS
                                ? showCupertinoModalPopup(
                                    context: context,
                                    builder: buildIOSActionSheet,
                                  )
                                : showModalBottomSheet(
                                    context: context,
                                    builder: buildAndroidActionSheet,
                                  );
                          },
                          child: const Text(
                            'editar perfil',
                            style: TextStyle(
                              color: Colors.orange,
                            ),
                          ),
                        ),
                      ),
                      // TextButton(onPressed: onPressed, child: const Text('Text')),
                      SizedBox(height: 40),
                      Text('Olá, Nome',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 600,
            width: MediaQuery.of(context).size.width - 20,
            margin: const EdgeInsets.only(left: 10.0, right: 10.0),
            color: Colors.blue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [],
            ),
          ),
          Container(
            height: 600,
            width: MediaQuery.of(context).size.width - 20,
            margin: const EdgeInsets.only(left: 10.0, right: 10.0),
            color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [],
            ),
          ),
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   elevation: 0.0,
      //   selectedItemColor: Colors.orange,
      //   currentIndex: currentIndex,
      //   onTap: (index) => setState(() => currentIndex = index),
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person),
      //       label: 'Perfil',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.flatware_outlined),
      //       label: 'Criar Receita',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.format_list_numbered),
      //       label: 'Clientes',
      //     ),
      //   ],
      // ),
      bottomNavigationBar: ValueListenableBuilder<int>(
          valueListenable: page,
          builder: (context, paginaAtual, _) {
            return NavigationBar(
              backgroundColor: Colors.transparent,
              onDestinationSelected: (value) => changePage(value),
              selectedIndex: paginaAtual,
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.person),
                  label: 'Perfil',
                  selectedIcon: Icon(
                    Icons.person,
                    color: Colors.orange,
                  ),
                ),
                NavigationDestination(
                  icon: Icon(Icons.flatware_outlined),
                  label: 'Criar Receita',
                  selectedIcon: Icon(
                    Icons.flatware_outlined,
                    color: Colors.orange,
                  ),
                ),
                NavigationDestination(
                  icon: Icon(Icons.format_list_numbered),
                  label: 'Clientes',
                  selectedIcon: Icon(
                    Icons.format_list_numbered,
                    color: Colors.orange,
                  ),
                ),
              ],
            );
          }),
    );
  }

  Widget buildAndroidActionSheet(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: Icon(Icons.delete),
          title: Text('Apagar'),
          onTap: () => Navigator.of(context).pop(null),
        ),
        ListTile(
          leading: Icon(Icons.camera_alt),
          title: Text('Camera'),
          onTap: () => Navigator.of(context).pop(ImageSource.camera),
        ),
        ListTile(
          leading: Icon(Icons.image),
          title: Text('Galeria'),
          onTap: () => Navigator.of(context).pop(ImageSource.gallery),
        ),
      ],
    );
  }

  Widget buildIOSActionSheet(BuildContext context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(context, pickImage(null)),
            child: Text('Apagar', style: TextStyle(color: Colors.red)),
          ),
          CupertinoActionSheetAction(
            onPressed: () =>
                Navigator.pop(context, pickImage(ImageSource.camera)),
            child: Text('Tirar Foto'),
          ),
          CupertinoActionSheetAction(
            onPressed: () =>
                Navigator.pop(context, pickImage(ImageSource.gallery)),
            child: Text('Escolher Foto'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text('Cancelar'),
          onPressed: () => Navigator.pop(context),
        ), // CupertinoActionSheetAction
      );
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
