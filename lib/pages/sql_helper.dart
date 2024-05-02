import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  static Database? _db;

  DatabaseHelper._internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  Future<bool> registerUser(String name, String email, String password) async {
    try {
      final db = await this.db;
      await db.insert('User', {'name': name, 'email': email, 'password': password});
      return true;
    } catch (e) {
      print("Error registering user: $e");
      return false;
    }
  }

  Future<bool> loginUser(String email, String password) async {
    try {
      final db = await this.db;
      List<Map<String, dynamic>> result = await db.query(
        'User',
        where: 'email = ? AND password = ?',
        whereArgs: [email, password],
      );
      return result.isNotEmpty;
    } catch (e) {
      print("Error logging in: $e");
      return false;
    }
  }

  Future<Database> initDb() async {
    String path = join(await getDatabasesPath(), 'your_database_name.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE User(id INTEGER PRIMARY KEY, username TEXT, bio TEXT, email TEXT, password TEXT)',
    );
  }

  Future<int> insertUser(Map<String, dynamic> row) async {
    Database dbClient = await db;
    return await dbClient.insert('User', row);
  }

  Future<Map<String, dynamic>?> queryUser(String email) async {
    Database dbClient = await db;
    List<Map<String, dynamic>> result = await dbClient.query(
      'User',
      where: 'email = ?',
      whereArgs: [email],
    );
    return result.isNotEmpty ? result.first : null;
  }

  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    try {
      final db = await this.db;
      final result = await db.query(
        'User',
        where: 'email = ?',
        whereArgs: [email],
      );
      return result.isNotEmpty ? result.first : null;
    } catch (e) {
      print('Error retrieving user: $e');
      return null;
    }
  }


  Future<int> updateUser(Map<String, dynamic> row) async {
    Database dbClient = await db;
    return await dbClient.update(
      'User',
      row,
      where: 'id = ?',
      whereArgs: [row['id']],
    );

  }

  Future<void> close() async {
    Database dbClient = await db;
    dbClient.close();
  }
}
