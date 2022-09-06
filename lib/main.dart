import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Nutri Tech';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,

      home: MyStatefulWidget(),
    );
  }

  body() {
    return Container(
      color: Colors.white,
      child: SizedBox.expand(
        child: Text('Tela de conteudo'),
      ),
    );
  }

  _img() {
    return Image.asset("assets/images/logo_empresa.png");
        fit: BoxFit.fill;
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}



class _MyStatefulWidgetState extends State<MyStatefulWidget> {

  body() {
    return Container(
      color: Colors.white,
      child: const SizedBox.expand(
        child: Text('Tela de conteudo'),
      ),
    );
  }

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[

    Text(
      'Pagina do cliente',
      style: optionStyle,
    ),


    Text(


      'Pagina do cardapio',

      style: optionStyle,
    ),

    Text(
      'Pagina de clientes',
      style: optionStyle,
    ),
  ];





  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Image.asset('assets/images/logo_empresa.png', fit: BoxFit.cover),

        // title: const Text('Nutri Tech App'),

      ),

        backgroundColor: Colors.blueGrey.shade200,
      body: Center(

        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Perfil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Criar Cardapio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Clientes',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }



}


