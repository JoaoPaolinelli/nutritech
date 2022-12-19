import 'package:flutter/material.dart';
import 'package:nutri_tech/screens/clients_screens/all_clients.dart';
import 'package:nutri_tech/screens/clients_screens/new_recipe.dart';
import 'package:nutri_tech/screens/clients_screens/profile.dart';

class Clients extends StatefulWidget {
  const Clients({super.key});

  @override
  State<Clients> createState() => _ClientsState();
}

class _ClientsState extends State<Clients> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Image.asset('images/logo_empresa.png', fit: BoxFit.cover),
        title: Image(
          image: const AssetImage('images/logo_empresa.png'),
          height: MediaQuery.of(context).size.height /
              11, // Número arbitrário apenas para encaixar corretamente na tela
          fit: BoxFit.cover,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.orange,
            title: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.person)),
                Tab(icon: Icon(Icons.food_bank_sharp)),
                Tab(icon: Icon(Icons.menu)),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              UserProfile(),
              Recipes(),
              AllClients(),
            ],
          ),
        ),
      ),
    );
  }
}
