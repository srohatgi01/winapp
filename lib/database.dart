import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common/sqlite_api.dart';

// class Database {
//   static late final db;

//   Database get getDb => db;

//   static initialize() async {
//     sqfliteFfiInit();
//     var databaseFactory = databaseFactoryFfi;
//     final documentsDir = await getApplicationDocumentsDirectory();
//     final dbpath = join(documentsDir.path, "data.sqlite3");
//     db = await databaseFactory.openDatabase(dbpath);
//   }
// }

class BdsDatabase {
  static final BdsDatabase instance = BdsDatabase._init();

  static Database? _database;

  BdsDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    sqfliteFfiInit();
    var databaseFactory = databaseFactoryFfi;
    final documentsDir = await getApplicationDocumentsDirectory();
    final path = join(documentsDir.path, "data.sqlite3");

    return await databaseFactory.openDatabase(path);
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }

  Future<void> createSampleTable() async {
    await _database
        ?.execute('CREATE TABLE IF NOT EXISTS sample (id int, name text);');
  }
}
