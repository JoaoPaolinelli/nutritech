import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


class Food{
  final String id;
  final String descricao;
  // final String base_unit;
  // final String categoria_id;
  // final String protein;
  // final String lipid;
  // final String colesterol;
  // final String carboidrato;
  // final String fibra;
  // final String calcio;
  // final String fosforo;
  // final String sodio;

  Food(this.id, this.descricao);
  // Food(this.id, this.descricao, this.base_unit, this.categoria_id, this.protein);

  static Future<Food> getAllFood() async {

    var link = 'http://localhost:4000/api/v1/food';
    var response = await http.get(Uri.parse(link));

    var alimento = jsonDecode(response.body);

    // print(alimento[0]['vitaminC']);
    // print(alimento[596]['description']);
    // print(alimento);

    final listaFood = List<dynamic>.generate(0, (_) => []);

    //596

    for(int posicao =0; posicao < 596; posicao++) {

      var id = alimento[posicao]['id'];
      var descricao = alimento[posicao]['description'];
      // var base = alimento[posicao]['base_unit'];
      // var categoria = alimento[posicao]['category_id'];
      // var proteina = alimento[posicao]['protein'];


      // var lipidio = alimento[posicao]['lipid'];
      // var colesterol = alimento[posicao]['cholesterol'];
      // var carboidrato = alimento[posicao]['carbohydrate'];
      // var fibra = alimento[posicao]['fiber'];
      // var calcio = alimento[posicao]['calcium'];
      // var fosforo = alimento[posicao]['phosphorus'];
      // var sodio = alimento[posicao]['sodium'];

      // var objFood = Food(id, descricao, base, categoria, proteina);
      try {
        var objFood = new Food(id.toString(), descricao.toString());
        listaFood.add(objFood);
        print(objFood.toString());
      }catch(e) {
        print(e);
      }

    }



    return alimento;
  }

  static Future<List> alimentoPorCategoria(id) async{

    var link = 'http://localhost:4000/api/v1/category/' + id.toString() + '/food';

    print(link);

    var response = await http.get(Uri.parse(link));

    var alimento = jsonDecode(response.body);


    final listaFood = List<dynamic>.generate(0, (_) => []);

    for(int posicao =0; posicao < 596; posicao++) {

      var id = alimento[posicao]['id'];
      var descricao = alimento[posicao]['description'];


      try {
        var objFood = new Food(id.toString(), descricao.toString());
        listaFood.add(objFood);
        print(objFood.toString());
      }catch(e) {
        print(e);
      }

    }
    return alimento;
  }

  @override
  String toString() {
    return 'Food{id: $id, descricao: $descricao}';
  }

}