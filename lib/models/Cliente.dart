class Cliente {
  int? cliente_id;
  String? cliente_name;
  String? receita;

  Cliente(this.cliente_name, this.receita);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'user_id' : cliente_id,
      'user_name': cliente_name,
      'receita': receita
    };
    return map;
  }

  Cliente.fromMap(Map<String?, dynamic> map) {
    cliente_id = map['cliente_id'];
    cliente_name = map['cliente_name'];
    receita = map['receita'];
  }
}
