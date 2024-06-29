import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class SqlDb {
  static Database? _db ;

  Future<Database?> get db async {
    if (_db == null){
      _db = await initialDb();
      return _db ;
    }else{
      return _db ;
    }
  }
 initialDb()async{
    String databasePath = await getDatabasesPath();
    String path = join(databasePath , 'test.db');
    Database mydb = await openDatabase( path , onCreate: _onCreate , version: 1);
    

    return mydb ;
  }
  _onCreate(Database db , int version)async{
    await db.execute('CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, phone_number TEXT, vacation TEXT)');
print("database Created-----------------------------------------------------");

}
 readData(String sql) async {
    Database? mydb = await db ;
    List<Map> response= await mydb!.rawQuery(sql);
    print(response);
    return response;
  }
    insertData(String sql) async {
    Database? mydb = await db ;
    int response = await mydb!.rawInsert(sql);
    print(response);
    return response;
  }

  mydeleteData()async{
      String databasePath = await getDatabasesPath();
    String path = join(databasePath , 'test.db');
    deleteDatabase(path);
  }
  }
  
  

  