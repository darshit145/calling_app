import 'package:calling_app/utility/phone_numbar_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseServices {
  static final DatabaseServices _databaseServices = DatabaseServices._name();
  DatabaseServices._name();

  factory DatabaseServices() {
    return _databaseServices;
  }

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    print("fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff");


    _database = await createDataBase("contact.db");
    return _database!;
  }

  Future createDataBase(String dataBaseName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dataBaseName);
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE my_table (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          phone TEXT,
          displayName TEXT,
          image TEXT
        )
      ''');
    });
  }

  // Inserting The Data in Map ForMated
  Future<void> insertContact(PhoneNumbarModel contact) async {
    final db = await database;
    await db.insert('my_table', contact.toMap());
  }

    //Getting the Object from Map
  Future<List<PhoneNumbarModel>> fetchContacts() async {
    final db = await database;
    final result = await db.query('my_table');
    return result.map((json) => PhoneNumbarModel.fromMap(json)).toList();
  }
  Future deleteAllTheRecords()async{
    final db=await database;
    await db.execute("""
    DELETE FROM my_table
    """);
  }
  Future deleteJustOneFromDataBase(PhoneNumbarModel obj)async{
    final db=await database;
      await db.delete(
      'my_table',
      where: 'phone = ?',
      whereArgs:[obj.phone]
    );
      print("okokokkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");

  }
}
