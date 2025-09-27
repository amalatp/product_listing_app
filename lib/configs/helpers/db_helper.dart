import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:product_listing_app/features/cart/models/cart_model.dart';

class CartDatabase {
  static final CartDatabase instance = CartDatabase._init();
  static Database? _database;

  CartDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('cart.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE cart (
        id INTEGER PRIMARY KEY,
        productId INTEGER,
        title TEXT,
        price REAL,
        image TEXT,
        quantity INTEGER
      )
    ''');
  }

  Future<List<CartItem>> fetchCart() async {
    final db = await instance.database;
    final result = await db.query('cart');
    return result.map((e) => CartItem.fromMap(e)).toList();
  }

  Future<void> insertItem(CartItem item) async {
    final db = await instance.database;
    await db.insert(
      'cart',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateItem(CartItem item) async {
    final db = await instance.database;
    await db.update(
      'cart',
      item.toMap(),
      where: 'productId = ?',
      whereArgs: [item.product.id],
    );
  }

  Future<void> deleteItem(int productId) async {
    final db = await instance.database;
    await db.delete('cart', where: 'productId = ?', whereArgs: [productId]);
  }

  Future<void> clearCart() async {
    final db = await instance.database;
    await db.delete('cart');
  }
}
