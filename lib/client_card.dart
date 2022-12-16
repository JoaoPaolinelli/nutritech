import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ClienteCard {
  var NomeCliente = "NovoCliente";
  Widget createClientCard(Function createClientFunction)
  {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            onTap: ()=>createClientFunction(),
            leading: const CircleAvatar(
              backgroundColor: Colors.orange,
              child: Icon(Icons.add, color: Colors.white),
            ),
            title: const Text("Adicionar novo Cliente"),
          ),
        ],
      ),
    );
  }

  Widget buildClientCard(String photo, String name) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            onTap: cardClientClicked,
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              child: Image.asset(photo),
            ),
            title: Text(name),
          ),
        ],
      ),
    );
  }

  cardClientClicked() {
    print("clickado!");
  }
}
