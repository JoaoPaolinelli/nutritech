import 'package:flutter/material.dart';
import 'package:nutri_tech/screens/clients_screens/client_card.dart';

class AllClients extends StatefulWidget {
  const AllClients({super.key});

  @override
  State<AllClients> createState() => _AllClientsState();
}

class _AllClientsState extends State<AllClients> {
  final clients=[
  ClienteCard()
      .buildClientCard('images/logo_empresa.png', 'Cliente 1'),
  ClienteCard()
      .buildClientCard('images/logo_empresa.png', 'Cliente 2'),
  ClienteCard()
      .buildClientCard('images/logo_empresa.png', 'Cliente 3'),
  ClienteCard()
      .buildClientCard('images/logo_empresa.png', 'Cliente 4'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ClienteCard().createClientCard(createClient),
              clients.length == 0 ? const Text('Nenhum cliente registrado') : ListView.builder(scrollDirection: Axis.vertical, shrinkWrap: true, itemCount: clients.length, itemBuilder: (ctx, index) => clients[index])
            ],
          ),
        ),
      ),
    );
  }
  void createClient()
  {
    setState(() {
      clients.add(ClienteCard()
          .buildClientCard('images/logo_empresa.png', 'Cliente teste'),);
    });
  }
}
