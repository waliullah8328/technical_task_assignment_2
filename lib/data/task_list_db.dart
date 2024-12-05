import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/todo_model.dart';

class TaskListDB {
  static Database? _database;

  // Initialize or get the existing database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  // Create or open the database
  Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), 'tasks.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE tasks (
            id INTEGER PRIMARY KEY,
            userId INTEGER,
            title TEXT,
            completed TEXT
          )
        ''');
      },
    );
  }

  // Insert or update a task
  Future<void> insertTasks(List<TodoModel> tasks) async {
    final db = await database;
    Batch batch = db.batch();
    for (var task in tasks) {
      batch.insert(
        'tasks',
        task.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  // Retrieve all tasks
  Future<List<TodoModel>> getTasks() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db.query('tasks');
    return results.map((item) => TodoModel.fromJson(item)).toList();
  }
}
