import 'package:sentra_mobile/config/sqflite_helper.dart';
import 'package:sentra_mobile/modules/engineering/model/image_content_model.dart';

class ImageContentRepository {
  final SQFliteHelper _sqFliteHelper = SQFliteHelper();
  String tblName = "image_content";

  var columnUsable = [
    "id",
    "relational_id",
    "relational_type",
    "path",
    "name",
    "created_by",
    "updated_by",
    "created_at",
    "updated_at",
    "deleted_at",
  ];

  Future<List<ImageContentModel>> getData() async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.query(tblName, columns: columnUsable);
    List<ImageContentModel> dt = [];

    for (int i = 0; i < maps.length; i++) {
      dt.add(ImageContentModel.fromMap(maps[i]));
    }

    return dt;
  }

  Future<List<ImageContentModel>> getDataWoId(String? id) async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.query(tblName,
        columns: columnUsable, where: "relational_id = ?", whereArgs: [id]);
    List<ImageContentModel> dt = [];

    for (int i = 0; i < maps.length; i++) {
      dt.add(ImageContentModel.fromMap(maps[i]));
    }

    return dt;
  }

  Future<List<ImageContentModel>> getDataInspeksiCheck(
      String? idInspection, String? idCheck) async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.query(tblName,
        columns: columnUsable,
        where: "relational_id = ? and relational_type = ?",
        whereArgs: [idCheck, idInspection]);
    List<ImageContentModel> dt = [];

    for (int i = 0; i < maps.length; i++) {
      dt.add(ImageContentModel.fromMap(maps[i]));
    }

    return dt;
  }

  Future<int> add(ImageContentModel dtModel) async {
    var dbClient = await _sqFliteHelper.db;
    return await dbClient.insert(tblName, dtModel.toMap());
  }

  Future<int> update(ImageContentModel dtModel) async {
    var dbClient = await _sqFliteHelper.db;
    return await dbClient.update(tblName, dtModel.toMap(),
        where: "id = ?", whereArgs: [dtModel.id]);
  }

  Future<int> delete(int id) async {
    var dbClient = await _sqFliteHelper.db;
    return await dbClient.delete(tblName, where: "id = ?", whereArgs: [id]);
  }

  Future<void> turncateTable() async {
    var dbClient = await _sqFliteHelper.db;
    return await dbClient.execute("DELETE FROM ${tblName}");
  }
}
