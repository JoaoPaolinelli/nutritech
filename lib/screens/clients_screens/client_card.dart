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
            leading: ClipOval(
              child: Container(
                alignment: Alignment.center,
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 204, 204, 204),
                  border: Border.all(color: Colors.orange, width: 5),
                ),
                  child: const Text(
                  textAlign: TextAlign.center,
                  "Foto",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold),
                )

              ),
            ),
            trailing: IconButton(icon: Icon(Icons.highlight_remove), onPressed: () {  },),
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
