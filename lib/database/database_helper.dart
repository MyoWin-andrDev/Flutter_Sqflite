
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper{
  late Database _db;

  DatabaseHelper(){
    _createDatabase();
  }

  static const String tableName = "tbl_student";
  Future<Database> _createDatabase() async{
    var dataPath = await getDatabasesPath();
    String path = join(dataPath, "student.db");

    _db = await openDatabase(path);
    await _db.execute("CREATE TABLE IF NOT EXISTS $tableName( id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, address TEXT, email TEXT)");
    return _db;
  }
  //Add Student
  Future<int> insertStudent(Map<String, dynamic> student) async {
    _db = await _createDatabase();
    return await _db.insert(tableName, student);
  }

  //GetAllStudent
  Future<List<Map<String, dynamic>>> getAllStudent() async {
    _db = await _createDatabase();
    return await _db.query(tableName, columns: ['id', 'name', 'address', 'email']);
  }
  
  //UpdateStudent
  Future<int> updateStudent(Map<String, dynamic> student, int id) async {
    return await _db.update(tableName, student, where: "id = ?", whereArgs: [id]);
  }

  //Delete Student
  Future<int> deleteStudent(int id) async {
    return await _db.delete(tableName, where: "id = ?", whereArgs: [id]);
  }
  //Format Table
  Future<int> resetStudent() async{
    return await _db.rawDelete("DELETE FROM $tableName");
  }
}