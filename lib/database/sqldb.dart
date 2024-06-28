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
    String path = join(databasePath , 'work.db');
    Database mydb = await openDatabase( path , onCreate: _onCreate , version: 4);

    return mydb ;
  }
  _onCreate(Database db , int version)async{
    await db.execute('''
     CREATE TABLE "data"(
     "phone_number" TEXT NOT NULL ,
     "name" TEXT NOT NULL,
     "vacation" TEXT NOT NULL
     )
''');
 
}
mydeleteDatabase()async{
   String databasePath = await getDatabasesPath();
    String path = join(databasePath , 'work.db');
    deleteDatabase(path);
}
 readData(String sql) async {
    Database? mydb = await db ;
    int response = await mydb!.rawInsert(sql);
    return response ;
  }
    insertData(String sql) async {
    Database? mydb = await db ;
    int response = await mydb!.rawInsert(sql);
    print (response) ;
  }
}
  