import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;
import 'package:toko_online/models/cart.dart';



class DBHelper {
  static Database? _database;

  /// koneksi database
  Future<Database?> get database async {
    if (_database != null) {
      
      return _database!;
      
    }
    _database = await initDatabase();
    return null;
  }

  /// inisialisasi database
  initDatabase() async {

    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'cart.db');
    
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    
    return db;
  }

  /// create table
  _onCreate(Database db, int version) async {
    // await db.execute('drop table if exists cart');
    await db.execute(
      'CREATE TABLE IF NOT EXISTS cart(id INTEGER PRIMARY KEY, id_barang VARCHAR, nama_barang TEXT, deskripsi TEXT, harga INTEGER, quantity INTEGER, image TEXT)',
    );
  }

  /// insert data
  Future<Cart> insert(Cart cart) async {
    var dbClient = await database;
    if (dbClient != null) {
      await dbClient.insert(
        'cart',
        cart.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return cart;
    } else {
      return cart;
    }
  }

  /// get semua data
  Future<List<Cart>> getCartList() async {
    try {
      var dbClient = await database;
      final List<Map<String, Object?>> queryResult = await dbClient!.query(
        'cart',
      );
      return queryResult.map((result) => Cart.fromMap(result)).toList();
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }

  /// get detail berdasarkan id
  Future getCartListDetail(id) async {
    try {
      var dbClient = await database;
      final queryResult = await dbClient!.query(
        'cart',
        where: 'id = ?',
        whereArgs: [id],
      );
      return queryResult.map((result) => Cart.fromMap(result)).toList();
    } catch (e) {
      // print("ok ${e}");
      return null;
    }
  }

  /// update quantity
  Future<int> updateQuantity(id, qty) async {
    var dbClient = await database;
    return await dbClient!.update(
      'cart',
      {"quantity": qty},
      where: "id = ?",
      whereArgs: [id],
    );
  }

  /// delete item
  Future<int> deleteCartItem(int id) async {
    var dbClient = await database;
    return await dbClient!.delete(
      'cart',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
} 