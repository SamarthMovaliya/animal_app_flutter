import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../Model/animal_model.dart';

class Animal_db {
  Animal_db._();
  static Animal_db animal_db = Animal_db._();

  String dbName = "animal.db";
  String tabalname = "animal";
  String colId = "id";
  String colName = "name";
  String colLoction = "loction";
  String colAverage_litter_size = "average_litter_size";
  String colColor = "color";
  String colSkin_type = "skin_type";
  String colLifespan = "lifespan";
  String colType = "type";
  String colDiet = "diet";

  Database? db;

  Future<void> initDB() async {
    var directoryPath = await getDatabasesPath();
    String path = join(directoryPath, dbName);

    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          String query =
              "CREATE TABLE IF NOT EXISTS $tabalname($colId INTEGER PRIMARY KEY AUTOINCREMENT ,$colName TEXT ,$colLoction TEXT,$colAverage_litter_size TEXT,$colColor TEXT,$colSkin_type TEXT,$colLifespan TEXT,$colType TEXT,$colDiet TEXT)";

          await db.execute(query);
        });
  }

  Future<int?> inserRecode({required Animal_Modal data}) async {
    await initDB();

    String query =
        "INSERT INTO $tabalname($colName,$colLoction,$colAverage_litter_size,$colColor,$colSkin_type,$colLifespan,$colType,$colDiet)VALUES(?,?,?,?,?,?,?,?)";

    List args = [
      data.name,
      data.loction,
      data.average_litter_size,
      data.color,
      data.skin_type,
      data.lifespan,
      data.type,
      data.diet
    ];
    int? id = await db?.rawInsert(query, args);

    return id;
  }

  Future<List<Animal_Modal>> fetchAllRecode() async {
    await initDB();
    String query = "SELECT * FROM $tabalname";

    List<Map<String, dynamic>> data = await db!.rawQuery(query);

    List<Animal_Modal> allAnimals =
    data.map((e) => Animal_Modal.fromMap(data: e)).toList();

    return allAnimals;
  }

  Future<int> deleteAllData() async {
    await initDB();

    String query = "DELETE FROM $tabalname";

    return await db!.rawDelete(query);
  }
}