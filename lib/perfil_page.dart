import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nutri_tech/database/Db.dart';

class Perfil extends StatefulWidget {
  @override
  State<Perfil> createState() {
    return PerfilState();
  }
}

class PerfilState extends State<Perfil> {
  File? image;
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

  Widget build(BuildContext context) {
    return Container(
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
                      textStyle:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
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
                Text('Olá, '+ _conUserName.text,
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAndroidActionSheet(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: Icon(Icons.delete),
          title: Text('Apagar'),
          onTap: () => Navigator.pop(context, pickImage(null)),
        ),
        ListTile(
          leading: Icon(Icons.camera_alt),
          title: Text('Camera'),
          onTap: () => Navigator.pop(context, pickImage(ImageSource.camera)),
        ),
        ListTile(
          leading: Icon(Icons.image),
          title: Text('Galeria'),
          onTap: () => Navigator.pop(context, pickImage(ImageSource.gallery)),
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
