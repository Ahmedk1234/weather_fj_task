import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'weather_model.dart';

class WeatherDatabase {
  static final WeatherDatabase instance = WeatherDatabase._init();
  static Database? _database;

  WeatherDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('weather.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE weather(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        cityName TEXT,
        temperature REAL,
        condition TEXT,
        humidity INTEGER,
        windSpeed REAL
      )
    ''');
  }

  Future<int> insertWeather(WeatherEntry entry) async {
    final db = await instance.database;
    final exists = await weatherExists(entry.cityName);
    if (exists) return 0;
    return await db.insert('weather', entry.toMap());
  }


  Future<List<WeatherEntry>> fetchAll() async {
    final db = await instance.database;
    final result = await db.query('weather');
    return result.map((e) => WeatherEntry.fromMap(e)).toList();
  }

  Future<void> deleteWeather(int id) async {
    final db = await instance.database;
    await db.delete('weather', where: 'id = ?', whereArgs: [id]);
  }

  Future<bool> weatherExists(String cityName) async {
    final db = await instance.database;
    final result = await db.query(
      'weather',
      where: 'cityName = ?',
      whereArgs: [cityName],
    );
    return result.isNotEmpty;
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
