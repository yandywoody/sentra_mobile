import 'package:sentra_mobile/config/sqflite_helper.dart';
import 'package:sentra_mobile/modules/engineering/model/inspection_check.dart';

class InspectionCheckRepository {
  final SQFliteHelper _sqFliteHelper = SQFliteHelper();
  String tblName = "eng_inspection_checks";

  var columnUsable = [
    "id",
    "name",
    "category",
    "description",
    "created_by",
    "updated_by",
    "created_at",
    "updated_at",
    "deleted_at",
  ];

  Future<List<InspectionCheckModel>> getData() async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.query(tblName, columns: columnUsable);
    List<InspectionCheckModel> dt = [];

    for (int i = 0; i < maps.length; i++) {
      dt.add(InspectionCheckModel.fromMap(maps[i]));
    }

    return dt;
  }

  Future<List<InspectionCheckModel>> getDataRealization(String id) async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.rawQuery("""
    SELECT 
    a.id,
    a.name,
    a.category,
    COALESCE(b.condition, 1) as condition,
    b.description,
    a.created_by,
    a.updated_by,
    a.created_at,
    a.updated_at,
    a.deleted_at
    from eng_inspection_checks a
    LEFT JOIN 
    (select * from eng_inspection_realization_checks where eng_inspection_realization_checks.inspection_id = ?)
    as b ON a.id = b.inspection_check_id
    """, [id]);

    List<InspectionCheckModel> dt = [];
    for (int i = 0; i < maps.length; i++) {
      dt.add(InspectionCheckModel.fromMap(maps[i]));
    }

    return dt;
  }

  Future<int> add(InspectionCheckModel dtModel) async {
    var dbClient = await _sqFliteHelper.db;
    return await dbClient.insert(tblName, dtModel.toMap());
  }

  Future<int> update(InspectionCheckModel dtModel) async {
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
