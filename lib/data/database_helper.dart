
import 'package:events_control/data/sqlite_code.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._instance;
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      _database = await _initDb('events.db');
    }
    return _database!;
  }

  Future<Database> _initDb(String dbName) async {
    final path = await getDatabasesPath();
    final dbPath = join(path, dbName);
    return await openDatabase(dbPath, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(eventsTable);
    await db.execute(peopleTable);
    await db.execute(attendanceTable);
  }
}
