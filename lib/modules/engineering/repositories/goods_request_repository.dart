import 'package:sentra_mobile/config/sqflite_helper.dart';
import 'package:sentra_mobile/modules/engineering/model/good_request_item_model.dart';
import 'package:sentra_mobile/modules/engineering/model/goods_request_model.dart';

class GoodsRequestRepository {
  final SQFliteHelper _sqFliteHelper = SQFliteHelper();
  String tblName = "wh_goods_requests";

  var columnUsable = [
    "id",
    "code",
    "goods_requester",
    "prev_goods_requester",
    "goods_requester_id",
    "goods_taker",
    "goods_taker_id",
    "goods_submitter",
    "goods_submitter_id",
    "goods_wh_taker",
    "goods_wh_taker_id",
    "process_type",
    "department_id",
    "prev_department_id",
    "new_department_id",
    "company_id",
    "approved_by",
    "approved_by_id",
    "transaction_date",
    "item_out_date",
    "target_arrival_date",
    "note",
    "foto",
    "input",
    "status",
    "status_data",
    "is_active",
    "is_received",
    "request_verify",
    "request_verify_by",
    "request_verify_by_id",
    "request_verify_date",
    "request_verify_note",
    "report_verify",
    "report_verify_by",
    "report_verify_by_id",
    "report_verify_date",
    "report_verify_note",
    "edited_reason",
    "edited_by_id",
    "edited_date",
    "canceled_reason_id",
    "canceled_req_by_id",
    "canceled_note",
    "canceled_by_id",
    "canceled_date",
    "deleted_at",
    "created_at",
    "updated_at",
    "relationable_type",
    "relationable_id",
    "programmer_note",
  ];

  Future<List<GoodsRequestModel>> getData() async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.query(tblName, columns: columnUsable);
    List<GoodsRequestModel> dt = [];

    for (int i = 0; i < maps.length; i++) {
      dt.add(GoodsRequestModel.fromMap(maps[i]));
    }

    return dt;
  }

  Future<List<GoodsRequestModel>> getDataByEmpItem(
      String? empId, String? itemName) async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.rawQuery("""
        SELECT 
        a.*,
        (SELECT z.name || ' (' || x.machine_code || ' | ' || x.start_at || ' - ' || x.finish_at || ')' FROM eng_repairs x 
        LEFT JOIN eng_activities z on x.activity_code = z.code
        WHERE x.id = a.relationable_id) as note,
        b.req_item_name as goods_requester_id, 
        cast(b.req_quantity as text) as goods_taker_id 
        FROM wh_goods_requests a
        LEFT JOIN wh_goods_request_items b ON a.code = b.ic_goods_request_code
        WHERE 1=1 AND
        b.req_item_name = ? AND
        a.relationable_id IN 
          (SELECT eng_project_details.id FROM eng_project_details INNER JOIN eng_project_detail_employees 
          ON eng_project_details.code = eng_project_detail_employees.project_detail_code
          WHERE eng_project_detail_employees.employee_id = ?)
        OR a.relationable_id IN 
          (SELECT eng_repairs.id FROM eng_repairs INNER JOIN eng_repair_employees 
          ON eng_repairs.id = eng_repair_employees.repair_id 
          WHERE eng_repair_employees.employee_id = ?)
        OR a.relationable_id IN 
          (SELECT eng_services.id FROM eng_services INNER JOIN eng_service_employees 
          ON eng_services.id = eng_service_employees.service_id 
          WHERE eng_service_employees.employee_id = ?)
        """, [itemName, empId, empId, empId]);

    List<GoodsRequestModel> dt = [];
    for (int i = 0; i < maps.length; i++) {
      dt.add(GoodsRequestModel.fromMap(maps[i]));
    }

    return dt;
  }

  Future<List<GoodsRequestModel>> getDataByEmp(String? id) async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.rawQuery("""
        SELECT 
        a.*,
        cast(sum(a.request_verify_by) as text) as request_verify_by,
        (SELECT z.name || ' (' || x.machine_code || ' ' || x.start_at || ')' FROM eng_repairs x 
        LEFT JOIN eng_activities z on x.activity_code = z.code
        WHERE x.id = a.relationable_id) as note,
        b.req_item_name as goods_requester_id, 
        cast(sum(b.req_quantity) as text) as goods_taker_id 
        FROM wh_goods_requests a
        LEFT JOIN wh_goods_request_items b ON a.code = b.ic_goods_request_code
        WHERE 1=1 AND
        a.relationable_id IN 
          (SELECT eng_project_details.id FROM eng_project_details INNER JOIN eng_project_detail_employees 
          ON eng_project_details.code = eng_project_detail_employees.project_detail_code
          WHERE eng_project_detail_employees.employee_id = ?)
        OR a.relationable_id IN 
          (SELECT eng_repairs.id FROM eng_repairs INNER JOIN eng_repair_employees 
          ON eng_repairs.id = eng_repair_employees.repair_id 
          WHERE eng_repair_employees.employee_id = ?)
        OR a.relationable_id IN 
          (SELECT eng_services.id FROM eng_services INNER JOIN eng_service_employees 
          ON eng_services.id = eng_service_employees.service_id 
          WHERE eng_service_employees.employee_id = ?)
        """, [id, id, id]);

    List<GoodsRequestModel> dt = [];
    for (int i = 0; i < maps.length; i++) {
      dt.add(GoodsRequestModel.fromMap(maps[i]));
    }

    return dt;
  }

  Future<List<GoodsRequestModel>> getCheckDataByWo(String? id) async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.rawQuery("""
        SELECT 
        a.*,
        (SELECT z.name || ' (' || x.machine_code || ' ' || x.start_at || ')' FROM eng_repairs x 
        LEFT JOIN eng_activities z on x.activity_code = z.code
        WHERE x.id = a.relationable_id) as note,
        b.req_item_name as goods_requester_id, 
        cast(b.req_quantity as text) as goods_taker_id 
        FROM wh_goods_requests a
        LEFT JOIN wh_goods_request_items b ON a.code = b.ic_goods_request_code
        WHERE 1=1 AND
        a.relationable_id = ? 
        """, [id]);

    List<GoodsRequestModel> dt = [];
    for (int i = 0; i < maps.length; i++) {
      dt.add(GoodsRequestModel.fromMap(maps[i]));
    }

    return dt;
  }

  Future<List<GoodRequestItemModel>> getDataNewItemByWo(String? id) async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.rawQuery("""
        SELECT a.* FROM wh_goods_request_items a
        WHERE a.relationable_id != ?
        """, [id]);

    List<GoodRequestItemModel> dt = [];
    for (int i = 0; i < maps.length; i++) {
      dt.add(GoodRequestItemModel.fromMap(maps[i]));
    }

    return dt;
  }

  Future<List<GoodRequestItemModel>> getDataNewItemAll() async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.rawQuery(
      """
        SELECT 
        a.*,
        (SELECT z.name || ' (' || x.machine_code || ' ' || x.start_at || ')' FROM eng_repairs x 
        LEFT JOIN eng_activities z on x.activity_code = z.code
        WHERE x.id = a.relationable_id) as verify_by,
        (SELECT z.name || ' (' || x.machine_code || ' ' || x.start_at || ')' FROM eng_services x 
        LEFT JOIN eng_activities z on x.activity_code = z.code
        WHERE x.id = a.relationable_id) as verify_date,
        (SELECT z.name FROM eng_project_details x 
        left join eng_projects z on x.project_id = z.id  
        WHERE x.id = a.relationable_id) as verify_note
        FROM wh_goods_request_items a
        WHERE a.relationable_id != ''
        """,
    );

    List<GoodRequestItemModel> dt = [];
    for (int i = 0; i < maps.length; i++) {
      dt.add(GoodRequestItemModel.fromMap(maps[i]));
    }

    return dt;
  }

  Future<List<GoodsRequestModel>> getDataByWo(String? id) async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.rawQuery("""
        SELECT a.*,cast(b.req_item_id as text) as goods_wh_taker_id, b.req_item_name as goods_requester_id, cast(b.req_quantity as text) as goods_taker_id from wh_goods_requests a
        LEFT JOIN wh_goods_request_items b ON a.code = b.ic_goods_request_code
        WHERE a.relationable_id = ?
        """, [id]);

    List<GoodsRequestModel> dt = [];
    for (int i = 0; i < maps.length; i++) {
      dt.add(GoodsRequestModel.fromMap(maps[i]));
    }

    return dt;
  }

  Future<int> add(GoodsRequestModel dtModel) async {
    var dbClient = await _sqFliteHelper.db;
    return await dbClient.insert(tblName, dtModel.toMap());
  }

  Future<int> update(GoodsRequestModel dtModel) async {
    var dbClient = await _sqFliteHelper.db;
    return await dbClient.update(tblName, dtModel.toMap(),
        where: "code = ?", whereArgs: [dtModel.code]);
  }

  Future<int> delete(int id) async {
    var dbClient = await _sqFliteHelper.db;
    return await dbClient.delete(tblName, where: "code = ?", whereArgs: [id]);
  }

  Future<void> turncateTable() async {
    var dbClient = await _sqFliteHelper.db;
    return await dbClient.execute("DELETE FROM ${tblName}");
  }
}
