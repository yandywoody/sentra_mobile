import 'package:sentra_mobile/config/sqflite_helper.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_inspection_realization_model.dart';

class WoInspectionRealizationRepository {
  final SQFliteHelper _sqFliteHelper = SQFliteHelper();
  String tblName = "eng_inspection_realizations";

  var columnUsable = [
    "id",
    "inspection_id",
    "employee_id",
    "start_at",
    "finish_at",
    "duration",
    "effectivity",
    "point_effectivity",
    "point",
    "description",
    "created_by",
    "updated_by",
    "created_at",
    "updated_at",
    "deleted_at",
  ];

  Future<List<WoInspectionRealizationModel>> getData() async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.rawQuery(""" 
        SELECT a.*, b.code, b.machine_code, '' as activity_code, 'Inspeksi' as work_type from eng_inspection_realizations a
        LEFT JOIN eng_inspections b ON b.id = a.inspection_id
        """);

    List<WoInspectionRealizationModel> dt = [];
    for (int i = 0; i < maps.length; i++) {
      dt.add(WoInspectionRealizationModel.fromMap(maps[i]));
    }

    return dt;
  }

  Future<List<WoInspectionRealizationModel>> getDataByEmp(String? empId) async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.rawQuery(""" 
        SELECT a.*, b.code, b.machine_code, '' as activity_code, 'Inspeksi' as work_type from eng_inspection_realizations a
        LEFT JOIN eng_inspections b ON b.id = a.inspection_id 
        where a.employee_id = ?
        """, [empId]);

    List<WoInspectionRealizationModel> dt = [];
    for (int i = 0; i < maps.length; i++) {
      dt.add(WoInspectionRealizationModel.fromMap(maps[i]));
    }

    return dt;
  }

  Future<int> add(WoInspectionRealizationModel dtModel) async {
    var dbClient = await _sqFliteHelper.db;
    return await dbClient.rawInsert("""
    INSERT INTO eng_inspection_realizations 
      (id, 
      inspection_id, 
      employee_id, 
      start_at, 
      finish_at, 
      duration, 
      effectivity, 
      point_effectivity, 
      point, 
      description, 
      created_by, 
      updated_by, 
      created_at, 
      updated_at, 
      deleted_at) 
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    """, [
      dtModel.id,
      dtModel.inspectionId,
      dtModel.employeeId,
      dtModel.startAt,
      dtModel.finishAt,
      dtModel.duration,
      dtModel.effectivity,
      dtModel.pointEffectivity,
      dtModel.point,
      dtModel.description,
      dtModel.createdBy,
      dtModel.updatedBy,
      dtModel.createdAt,
      dtModel.updatedAt,
      dtModel.deletedAt
    ]);
  }

  Future<int> update(WoInspectionRealizationModel dtModel) async {
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
