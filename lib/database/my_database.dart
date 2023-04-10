import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MyDatabase {
  Future<Database> initDatabase() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String databasePath = join(appDocDir.path, 'demo_database.db');
    return await openDatabase(databasePath);
  }

  Future<bool> copyPasteAssetFileToRoot() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "demo_database.db");

    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
      ByteData data =
          await rootBundle.load(join('assets/database', 'demo_database.db'));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes);
      return true;
    }
    return false;
  }

  Future<List<Map<String, Object?>>> getDetails() async {
    Database db = await initDatabase();
    List<Map<String, Object?>> list = await db.rawQuery(
        "select u.UserId,u.UserName,c.cityName,c.cityId from User_Tbl u inner join City_Tbl c on c.cityId=u.cityId");

    return list;
  }


  Future<int> insertUser(Map<String, Object?> map) async {
    Database db = await initDatabase();

    var res =await db.insert("User_Tbl", map);
    return res;
  }

  Future<void> deleteUser(id) async {
    Database db = await initDatabase();

    var res = db.delete("User_Tbl",where: "UserId = ?",whereArgs: [id]);
  }

  Future<int> editUser(Map<String,Object?> map,id) async {
    Database db = await initDatabase();

    var res =await db.update("User_Tbl", map,where: "UserId = ?",whereArgs: [id]);
    return res;
  }
}
