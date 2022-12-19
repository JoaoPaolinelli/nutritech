class User {
  int? user_id;
  String? user_name;
  String? email;
  String? password;
  String? data;

  User(this.user_name, this.data, this.email, this.password);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'user_id' : user_id,
      'user_name': user_name,
      'data' : data,
      'email': email,
      'password': password
    };
    return map;
  }

  User.fromMap(Map<String?, dynamic> map) {
    user_id = map['user_id'];
    user_name = map['user_name'];
    data = map['data'];
    email = map['email'];
    password = map['password'];
  }
}
