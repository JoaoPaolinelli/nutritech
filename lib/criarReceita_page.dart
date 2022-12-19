import 'package:flutter/material.dart';
import 'package:flutter/src/material/dropdown.dart';
import 'package:dropdown_search/dropdown_search.dart';

class CriarReceita extends StatefulWidget {
  @override
  State<CriarReceita> createState() {
    return CriarReceitaState();
  }
}

class CriarReceitaState extends State<CriarReceita> {
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
            'Selecione um Cliente:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(height: 10),
          DropdownSearch<String>(
            popupProps: PopupProps.menu(
              showSelectedItems: true,
              // showSearchBox: true,
              // searchFieldProps: TextFieldProps(cursorColor: Colors.black),
            ),
            items: clientes,
            dropdownDecoratorProps: DropDownDecoratorProps(
              baseStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 94, 94, 94)),
              dropdownSearchDecoration: InputDecoration(
                isDense: true, // important line
                contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0), // c
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.orange,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                // hintText: "Selecione um Cliente",
                // hintStyle: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
            onChanged: print,
            // selectedItem: (clientes.length != null ? clientes[0] : value),
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
              hintText: 'Texto',
              hintStyle: TextStyle(color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
          ),
          SizedBox(height: 10),
          TextButton(
            //Botão para Salvar
            onPressed: null,
            child: const Text(
              'Criar Receita',
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

  DropdownMenuItem<String> buildMenuClientes(String cliente) =>
      DropdownMenuItem(
        value: cliente,
        child: Text(
          cliente,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
      );
}
