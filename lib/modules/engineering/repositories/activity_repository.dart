import 'package:sentra_mobile/config/sqflite_helper.dart';
import 'package:sentra_mobile/modules/engineering/model/activity_model.dart';

class ActivityRepository {
  final SQFliteHelper _sqFliteHelper = SQFliteHelper();
  String tblName = "eng_activities";

  var columnUsable = [
    "id",
    "group_code",
    "department",
    "code",
    "name",
    "difficulty",
    "point",
    "score",
    "description",
    "is_urgent",
    "is_active",
    "created_by",
    "updated_by",
    "created_at",
    "updated_at",
    "deleted_at",
  ];

  Future<List<ActivityModel>> getData() async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.query(tblName, columns: columnUsable);
    List<ActivityModel> dt = [];

    for (int i = 0; i < maps.length; i++) {
      dt.add(ActivityModel.fromMap(maps[i]));
    }

    return dt;
  }

  Future<ActivityModel> getDataByWo(String param) async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.query(tblName,
        columns: columnUsable, where: 'name = ?', whereArgs: [param]);
    List<ActivityModel> dt = [];

    for (int i = 0; i < maps.length; i++) {
      dt.add(ActivityModel.fromMap(maps[i]));
    }

    ActivityModel result = ActivityModel();
    if (dt.length > 0) {
      result = dt[0];
    }

    return result;
  }

  Future<ActivityModel> getDataByCode(String param) async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.query(tblName,
        columns: columnUsable, where: 'code = ?', whereArgs: [param]);
    List<ActivityModel> dt = [];

    for (int i = 0; i < maps.length; i++) {
      dt.add(ActivityModel.fromMap(maps[i]));
    }

    ActivityModel result = ActivityModel();
    if (dt.length > 0) {
      result = dt[0];
    }

    return result;
  }

  Future<int> add(ActivityModel dtModel) async {
    var dbClient = await _sqFliteHelper.db;
    return await dbClient.insert(tblName, dtModel.toMap());
  }

  Future<int> update(ActivityModel dtModel) async {
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
