import 'dart:convert';
import 'package:http/http.dart' as http;


class Categoria{
  final int id;
  final String categoria;

  Categoria(this.id, this.categoria);

  static Future<Categoria> fetch()  async{
    var link = 'http://localhost:4000/api/v1/category';
    var response = await http.get(Uri.parse(link));

    var json = jsonDecode(response.body);

    final listaCategoria = List<dynamic>.generate(0, (_) => []);

    for(int posicao = 0; posicao < 15; posicao ++) {
      var id = json[posicao]['id'];
      var categoria = json[posicao]['category'];

      var objCategoria = Categoria(id, categoria);

      listaCategoria.add(objCategoria);
      print(objCategoria.toString());

    }

    return json;
  }

  static Future<Categoria> getCategoriaX(int X) async{

    var link = 'http://localhost:4000/api/v1/category/'+ X.toString();
    var response = await http.get(Uri.parse(link));

    var json = jsonDecode(response.body);

    return json;
  }

  @override
  String toString() {
    return 'ID: ' + this.id.toString() + " Categoria produto: " + this.categoria;
  }

}