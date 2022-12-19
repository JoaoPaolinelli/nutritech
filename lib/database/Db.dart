import 'package:nutri_tech/models/User.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

class Db {
  static  Database? _db;

  static const String DB_Name = 'test.db';
  static const String Table_User = 'user';
  static const int Version = 1;

  static const String C_UserID = 'user_id';
  static const String C_UserName = 'user_name';
  static const String C_UserData = 'data';
  static const String C_Email = 'email';
  static const String C_Password = 'password';

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_Name);
    var db = await openDatabase(path, version: Version, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int intVersion) async {
    await db.execute("CREATE TABLE $Table_User ("
        " $C_UserID INTEGER PRIMARY KEY, "
        " $C_UserName TEXT, "
        " $C_Email TEXT UNIQUE,"
        " $C_Password TEXT, "
        " data TEXT "
        ")");
    await db.execute("CREATE TABLE cliente ("
        " cliente_id INTEGER PRIMARY KEY, "
        " user_name TEXT, "
        " receita TEXT"
        ")");
  }

  Future<int?> saveData(User user) async {
    var dbClient = await db;
    var res = await dbClient?.insert(Table_User, user.toMap());
    return res;
  }

  Future<User> getLoginUser(String userEmail, String password) async {
    var dbClient = await db;
    var res = await dbClient?.rawQuery("SELECT * FROM $Table_User WHERE "
        "$C_Email = '$userEmail' AND "
        "$C_Password = '$password'");

    return User.fromMap(res!.first);

  }

  Future<int?> updateUser(User user) async {
    var dbClient = await db;
    var res = await dbClient?.update(Table_User, user.toMap(),
        where: '$C_UserID = ?', whereArgs: [user.user_id]);
    return res;
  }

  Future<int?> deleteUser(String user_id) async {
    var dbClient = await db;
    var res = await dbClient
        ?.delete(Table_User, where: '$C_UserID = ?', whereArgs: [user_id]);
    return res;
  }
}
