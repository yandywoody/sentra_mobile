import 'package:sentra_mobile/config/sqflite_helper.dart';
import 'package:sentra_mobile/modules/engineering/model/inspection_check_realization_model.dart';
import 'package:sentra_mobile/modules/general/model/kpi_model.dart';

class InspectionCheckRealizationRepository {
  final SQFliteHelper _sqFliteHelper = SQFliteHelper();
  String tblName = "eng_inspection_realization_checks";

  var columnUsable = [
    "id",
    "inspection_id",
    "inspection_check_id",
    "condition",
    "description",
    "created_by",
    "updated_by",
    "created_at",
    "updated_at",
    "deleted_at",
  ];

  Future<List<InspectionCheckRealizationModel>> getData() async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.query(tblName, columns: columnUsable);
    List<InspectionCheckRealizationModel> dt = [];

    for (int i = 0; i < maps.length; i++) {
      dt.add(InspectionCheckRealizationModel.fromMap(maps[i]));
    }

    return dt;
  }

  Future<List<InspectionCheckRealizationModel>> getDataByEmp(
      String? empId) async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.query(tblName,
        columns: columnUsable, where: "employee_id = ?", whereArgs: [empId]);
    List<InspectionCheckRealizationModel> dt = [];

    for (int i = 0; i < maps.length; i++) {
      dt.add(InspectionCheckRealizationModel.fromMap(maps[i]));
    }

    return dt;
  }

  Future<int> add(InspectionCheckRealizationModel dtModel) async {
    var dbClient = await _sqFliteHelper.db;
    return await dbClient.insert(tblName, dtModel.toMap());
  }

  Future<int> update(InspectionCheckRealizationModel dtModel) async {
    var dbClient = await _sqFliteHelper.db;
    return await dbClient.update(tblName, dtModel.toMap(),
        where: "id = ?", whereArgs: [dtModel.id]);
  }

  Future<int> insertUpdate(InspectionCheckRealizationModel dtModel) async {
    var dbClient = await _sqFliteHelper.db;
    int result = 0;

    List<Map> maps = await dbClient.query(tblName,
        columns: columnUsable,
        where: "inspection_id = ? and inspection_check_id = ?",
        whereArgs: [dtModel.inspectionId, dtModel.inspectionCheckId]);

    if (maps.length > 0) {
      result = await dbClient.update(tblName, dtModel.toMap(),
          where: "inspection_id = ? and inspection_check_id = ?",
          whereArgs: [dtModel.inspectionId, dtModel.inspectionCheckId]);
    } else {
      result = await dbClient.insert(tblName, dtModel.toMap());
    }

    return result;
  }

  Future<int> insertCheck(InspectionCheckRealizationModel dtModel) async {
    var dbClient = await _sqFliteHelper.db;
    int result = 0;

    List<Map> maps = await dbClient.query(tblName,
        columns: columnUsable,
        where: "inspection_id = ? and inspection_check_id = ?",
        whereArgs: [dtModel.inspectionId, dtModel.inspectionCheckId]);

    if (maps.isEmpty) {
      result = await dbClient.insert(tblName, dtModel.toMap());
    }

    return result;
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
