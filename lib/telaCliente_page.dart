import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:nutri_tech/database/Db.dart';
import 'package:nutri_tech/models/User.dart';
import 'package:nutri_tech/registration_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nutri_tech/home_page.dart';
import 'package:nutri_tech/registration_page.dart';

class TelaCliente extends StatefulWidget {
  @override
  State<TelaCliente> createState() {
    return TelaClienteState();
  }
}

class TelaClienteState extends State<TelaCliente> {
  final clientes = [
    'Cliente1',
    'Cliente2',
    'Cliente3',
    'Cliente4',
    'Cliente5',
    'Cliente6',
    'Cliente7',
    'Cliente8',
    'Cliente9'
  ];
  String? value;

  Widget build(BuildContext context) {
    return Container(
      height: 600,
      width: MediaQuery.of(context).size.width - 20,
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
      padding: const EdgeInsets.all(8.0),
      color: Color.fromARGB(5, 0, 0, 0),
      child: ListView(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 30),
          Text(
            'Nome: ' + 'nomeUsuário',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(height: 30),
          Text(
            'Sobrenome: ' + 'sobrenomeUsuário',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(height: 30),
          Text(
            'Telefone: ' + '(xx) xxxxx-xxxx',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(height: 30),
          Text(
            'E-mail: ' + 'exemplo@email.com',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(height: 50),
          Text(
            'Receita:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(height: 10),
          TextFormField(
            minLines: 10,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Colors.orange,
                ),
              ),
              hintText: 'Receita...\n\nReceita...\n\nReceita...\n\nReceita...',
              hintStyle: TextStyle(color: Colors.black),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
          ),
          SizedBox(height: 10),
          TextButton(
            //Botão para Salvar
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => HomePage())
                // retorno a home() provisorio
                //deve retornar a tela de clientes
              );
            },
            child: const Text(
              'Voltar',
              style: TextStyle(
                color: Colors.orange,
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
