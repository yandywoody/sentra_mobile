import 'package:sentra_mobile/config/sqflite_helper.dart';
import 'package:sentra_mobile/modules/engineering/model/project_model.dart';

class ProjectRepository {
  final SQFliteHelper _sqFliteHelper = SQFliteHelper();
  String tblName = "eng_projects";

  var columnUsable = [
    "id",
    "priority_code",
    "group_code",
    "applicant_id",
    "leader_id",
    "revision_from",
    "code",
    "name",
    "location",
    "duration",
    "file",
    "description",
    "status",
    "is_approve",
    "is_suitable",
    "goods_received",
    "created_by",
    "updated_by",
    "verified_by",
    "start_date",
    "finish_date",
    "completed_date",
    "created_at",
    "updated_at",
    "deleted_at",
    "work_type",
  ];

  Future<List<ProjectModel>> getData() async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.query(tblName, columns: columnUsable);
    List<ProjectModel> dt = [];

    for (int i = 0; i < maps.length; i++) {
      dt.add(ProjectModel.fromMap(maps[i]));
    }

    return dt;
  }

  Future<int> add(ProjectModel dtModel) async {
    var dbClient = await _sqFliteHelper.db;
    return await dbClient.insert(tblName, dtModel.toMap());
  }

  Future<int> update(ProjectModel dtModel) async {
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
