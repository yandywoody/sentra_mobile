import 'package:sentra_mobile/config/sqflite_helper.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_service_realization_model.dart';

class WoServiceRealizationRepository {
  final SQFliteHelper _sqFliteHelper = SQFliteHelper();
  String tblName = "eng_service_realizations";

  var columnUsable = [
    "id",
    "service_id",
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

  Future<List<WoServiceRealizationModel>> getData() async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.rawQuery(""" 
        SELECT a.*, b.code, b.machine_code, d.name as activity_code, 'Service' as work_type from eng_service_realizations a
        LEFT JOIN eng_services b ON b.id = a.service_id
        LEFT JOIN eng_activities d ON b.activity_code = d.code
        """);
    List<WoServiceRealizationModel> dt = [];

    for (int i = 0; i < maps.length; i++) {
      dt.add(WoServiceRealizationModel.fromMap(maps[i]));
    }

    return dt;
  }

  Future<List<WoServiceRealizationModel>> getDataByEmp(String? empId) async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.rawQuery(""" 
        SELECT a.*, b.code, b.machine_code, d.name as activity_code from eng_service_realizations a
        LEFT JOIN eng_services b ON b.id = a.service_id
        LEFT JOIN eng_activities d ON b.activity_code = d.code
        WHERE a.employee_id = ?
        """, [empId]);

    List<WoServiceRealizationModel> dt = [];
    for (int i = 0; i < maps.length; i++) {
      dt.add(WoServiceRealizationModel.fromMap(maps[i]));
    }

    return dt;
  }

  Future<int> add(WoServiceRealizationModel dtModel) async {
    var dbClient = await _sqFliteHelper.db;
    return await dbClient.rawInsert("""
    INSERT INTO eng_service_realizations 
      (id, 
      service_id, 
      employee_id, 
      start_at, 
      finish_at, 
      duration, 
      effectivity, 
      point_effectivity, 
      point, 
      description, 
      is_finish, 
      created_by, 
      updated_by, 
      created_at, 
      updated_at, 
      deleted_at) 
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    """, [
      dtModel.id,
      dtModel.serviceId,
      dtModel.employeeId,
      dtModel.startAt,
      dtModel.finishAt,
      dtModel.duration,
      dtModel.effectivity,
      dtModel.pointEffectivity,
      dtModel.point,
      dtModel.description,
      dtModel.isFinish,
      dtModel.createdBy,
      dtModel.updatedBy,
      dtModel.createdAt,
      dtModel.updatedAt,
      dtModel.deletedAt
    ]);
  }

  Future<int> update(WoServiceRealizationModel dtModel) async {
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
