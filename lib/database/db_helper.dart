import 'dart:async';
import 'package:ordering/Models/Cart.dart';
import 'package:ordering/files_export.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;
  int count = 0;
  Map<String, Cart> _items = {};
  Future<Database?> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    // io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final dbPath = await getDatabasesPath();
    String path = join(dbPath, "cart.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
        "CREATE TABLE CartData(id INTEGER PRIMARY KEY, url TEXT, name TEXT, price REAL,quantity INTEGER,dateTime TEXT )");
    print("Created tables");
  }

  void saveCart(Cart cart) async {
    var dbClient = await db;
    int? check = Sqflite.firstIntValue(await dbClient!
        .rawQuery("SELECT COUNT(1) FROM CartData WHERE name = '${cart.name}'"));
    if (check == 0) {
      print("Added new item into Cart");
      await dbClient.transaction((txn) async {
        return await txn.rawInsert(
            'INSERT INTO CartData(url, name, price, quantity,dateTime ) VALUES(' +
                '\'' +
                cart.url +
                '\'' +
                ',' +
                '\'' +
                cart.name +
                '\'' +
                ',' +
                '\'' +
                cart.price.toString() +
                '\'' +
                ',' +
                '\'' +
                cart.quantity.toString() +
                '\'' +
                ',' +
                '\'' +
                cart.dateTime +
                '\'' +
                ')');
      });
    } else {
      print("Quantity updated successfully");
      dbClient.rawQuery(
          "UPDATE CartData SET quantity = (quantity + ${cart.quantity}) WHERE name = '${cart.name}'");
      print('hello from update quantity ${cart.quantity}');
    }
  }
  // Future getCount() async
  // {
  //   var dbClient = await db;
  //   int? count = Sqflite.firstIntValue(await dbClient!
  //       .rawQuery("SELECT COUNT(1) FROM CartData"));
  //   print('count from $count');
  //   return count;
  // }
  // int get itemCount {
  //   print('count from itemcount is $itemCount');
  //   return count;
  // }
  // double get totalAmount {
  //   var total = 0.0;
  //   _items.forEach((key, cartItem) {
  //     total += cartItem.price * cartItem.quantity;
  //   });
  //   return total;
  // }
  Future<List<Cart>> getCartItems() async {
    var dbClient = await db;
    List<Map> list = await dbClient!.rawQuery('SELECT * FROM CartData');
    List<Cart> cartItems = [];
    for (int i = 0; i < list.length; i++) {
      cartItems.add(Cart(
          url: list[i]["url"],
          name: list[i]["name"],
          price: list[i]["price"],
          quantity: list[i]["quantity"],
          dateTime: list[i]["dateTime"]));
    }
    count = cartItems.length;
    print(cartItems.length);
    return cartItems;
  }
  Future deleteCart(String name) async
  {
    var dbClient = await db;
    print('deleted cart successfully');
    return await dbClient!.rawDelete("DELETE FROM CartData WHERE name = '$name'");
  }
  Future removeQuantity(String name) async
  {
    var dbClient = await db;
    print('deleted cart successfully');
    return await dbClient!.rawQuery(
        "UPDATE CartData SET quantity = (quantity - ${1}) WHERE name = '$name' AND quantity > 0 ");
  }

  Future addQuantity(String name) async
  {
    var dbClient = await db;
    print('deleted cart successfully');
    return await dbClient!.rawQuery(
        "UPDATE CartData SET quantity = (quantity + ${1}) WHERE name = '$name' AND quantity < 100 ");
  }


}
