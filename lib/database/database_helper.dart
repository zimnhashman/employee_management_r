import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;
  static final DatabaseHelper instance = DatabaseHelper._();

  DatabaseHelper._();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'employee_database.db');
    return openDatabase(
      path,
      version: 1, // You can change the version number if you need to update the schema
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE Users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT UNIQUE,
            password TEXT,
            role TEXT CHECK(role IN ('Admin', 'Employee'))
          )
        ''');

        await db.execute('''
          CREATE TABLE OffDays (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            employee_id INTEGER,
            start_date TEXT,
            end_date TEXT,
            status TEXT CHECK(status IN ('Pending', 'Approved', 'Rejected')),
            reason TEXT,
            FOREIGN KEY (employee_id) REFERENCES Users(id)
          )
        ''');

        await db.execute('''
          CREATE TABLE News (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            admin_id INTEGER,
            message TEXT,
            timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
            FOREIGN KEY (admin_id) REFERENCES Users(id)
          )
        ''');

        await db.execute('''
          CREATE TABLE Tasks (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            task_name TEXT,
            description TEXT,
            employee_id INTEGER,
            deadline TEXT,
            status TEXT CHECK(status IN ('Pending', 'In Progress', 'Completed')),
            FOREIGN KEY (employee_id) REFERENCES Users(id)
          )
        ''');
      },
    );
  }

  Future<int> insertUser(Map<String, dynamic> user) async {
    Database db = await database;
    return await db.insert('Users', user);
  }

  Future<Map<String, dynamic>> getUserById(int id) async {
    Database db = await database;
    List<Map<String, dynamic>> users = await db.query(
      'Users',
      where: 'id = ?',
      whereArgs: [id],
    );
    return users.isNotEmpty ? users.first : {};
  }

  Future<int> updateUser(Map<String, dynamic> user) async {
    Database db = await database;
    return await db.update(
      'Users',
      user,
      where: 'id = ?',
      whereArgs: [user['id']],
    );
  }

  Future<int> deleteUser(int id) async {
    Database db = await database;
    return await db.delete(
      'Users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }


  //OffDays Table
  Future<int> insertOffDay(Map<String, dynamic> offDay) async {
    Database db = await database;
    return await db.insert('OffDays', offDay);
  }

  // Read operation to get an off day by its ID
  Future<Map<String, dynamic>> getOffDayById(int id) async {
    Database db = await database;
    List<Map<String, dynamic>> offDays = await db.query(
      'OffDays',
      where: 'id = ?',
      whereArgs: [id],
    );
    return offDays.isNotEmpty ? offDays.first : {};
  }

  // Read operation to get all off days for a specific employee
  Future<List<Map<String, dynamic>>> getOffDaysForEmployee(int employeeId) async {
    Database db = await database;
    return await db.query(
      'OffDays',
      where: 'employee_id = ?',
      whereArgs: [employeeId],
    );
  }

  // Update operation for OffDays table
  Future<int> updateOffDay(Map<String, dynamic> offDay) async {
    Database db = await database;
    return await db.update(
      'OffDays',
      offDay,
      where: 'id = ?',
      whereArgs: [offDay['id']],
    );
  }

  // Delete operation for OffDays table
  Future<int> deleteOffDay(int id) async {
    Database db = await database;
    return await db.delete(
      'OffDays',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

//News CRUD Operations
  Future<int> insertNews(Map<String, dynamic> news) async {
    Database db = await database;
    return await db.insert('News', news);
  }

  Future<List<Map<String, dynamic>>> getAllNews() async {
    Database db = await database;
    return await db.query('News');
  }

  Future<int> deleteNews(int id) async {
    Database db = await database;
    return await db.delete(
      'News',
      where: 'id = ?',
      whereArgs: [id],
    );
  }


  //Off-Days Screen
  Future<List<Map<String, dynamic>>> getPendingOffDayApplications() async {
    Database db = await database;
    return await db.query('OffDays', where: 'status = ?', whereArgs: ['Pending']);
  }

  Future<int> updateOffDayStatus(int applicationId, String newStatus) async {
    Database db = await database;
    return await db.update(
      'OffDays',
      {'status': newStatus},
      where: 'id = ?',
      whereArgs: [applicationId],
    );
  }

  //Employee CRUD
  Future<int> insertEmployee(Map<String, dynamic> employee) async {
    Database db = await database;
    return await db.insert('Users', employee);
  }

  Future<List<Map<String, dynamic>>> getEmployees() async {
    Database db = await database;
    return await db.query('Users', where: 'role = ?', whereArgs: ['Employee']);
  }

  Future<int> deleteEmployee(int employeeId) async {
    Database db = await database;
    return await db.delete('Users', where: 'id = ?', whereArgs: [employeeId]);
  }

  //Tasks CRUD

  Future<List<Map<String, dynamic>>> getTasks() async {
    Database db = await database;
    return await db.query('Tasks');
  }

  Future<int> insertTask(Map<String, dynamic> task) async {
    Database db = await database;
    return await db.insert('Tasks', task);
  }

  Future<int> updateTask(Map<String, dynamic> task) async {
    Database db = await database;
    return await db.update('Tasks', task, where: 'id = ?', whereArgs: [task['id']]);
  }

  Future<int> deleteTask(int taskId) async {
    Database db = await database;
    return await db.delete('Tasks', where: 'id = ?', whereArgs: [taskId]);
  }

  Future<List<Map<String, dynamic>>> getAllTasks() async {
    Database db = await database;
    return await db.query('Tasks');
  }

  Future<Map<String, dynamic>> getTaskById(int taskId) async {
    Database db = await database;
    List<Map<String, dynamic>> tasks = await db.query('Tasks', where: 'id = ?', whereArgs: [taskId]);

    if (tasks.isNotEmpty) {
      return tasks.first;
    } else {
      return {}; // Return empty map if task with the given ID is not found
    }
  }

  Future<int> updateTaskStatus(int taskId, String status) async {
    Database db = await database;
    return await db.update('Tasks', {'status': status}, where: 'id = ?', whereArgs: [taskId]);
  }

  Future<int> updateTaskEmployee(int taskId, int employeeId) async {
    Database db = await database;
    return await db.update('Tasks', {'employee_id': employeeId}, where: 'id = ?', whereArgs: [taskId]);
  }




}
