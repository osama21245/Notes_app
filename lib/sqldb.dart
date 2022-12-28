import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart';

class SQlDb {
  static Database? _dp;

  Future<Database?> get dp async {
    if (_dp == null) {
      _dp = await initialDb();
      return _dp;
    } else {
      return _dp;
    }
  }

  initialDb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'wael.dp');
    Database mydp = await openDatabase(path,
        onCreate: _oncreate, version: 8, onUpgrade: _onupgrade);
    return mydp;
  }

  _onupgrade(Database dp, int oldversion, int newvresion) async {
    print("onupgrade==================");

    await dp.execute("ALRT TABLE notes ADD COLUMN  ");
  }

  _oncreate(Database db, int version) async {
    await db.execute('''CREATE TABLE "notes" 
    (
     "id" INTEGER  NOT NULL PRIMARY KEY AUTOINCREMENT,
     "note" TEXT NOT NULL ,
     "title" TEXT NOT NULL , 
     "color" TEXT NOT NULL 
    ) ''');
    print('on create ==================');
  }

  readData(String sql) async {
    Database? mydp = await dp;
    List<Map> respose = await mydp!.rawQuery(sql);
    return respose;
  }

  insertData(String sql) async {
    Database? mydp = await dp;
    int respose = await mydp!.rawInsert(sql);
    return respose;
  }

  deletetData(String sql) async {
    Database? mydp = await dp;
    int respose = await mydp!.rawDelete(sql);
    return respose;
  }

  UpdateData(String sql) async {
    Database? mydp = await dp;
    int respose = await mydp!.rawUpdate(sql);
    return respose;
  }

  mydeletedatabase() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'wael.dp');
    await deleteDatabase(path);
  }
}
