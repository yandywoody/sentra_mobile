import 'package:sentra_mobile/config/sqflite_helper.dart';
import 'package:sentra_mobile/model/employee_model.dart';

class EmployeeRepository {
  final SQFliteHelper _sqFliteHelper = SQFliteHelper();
  String tblName = "hr_employees";

  var columnUsable = [
    "id",
    "recruitment_id",
    "nik",
    "name",
    "foto",
    "phone",
    "mobile",
    "email",
    "identity_type_id",
    "identity_number",
    "birth_place",
    "birth_date",
    "gender",
    "marital_id",
    "blood_type_id",
    "religion_id",
    "address",
    "province_id",
    "regency_id",
    "postal_code",
    "residential_status",
    "residential_address",
    "residential_province_id",
    "residential_regency_id",
    "residential_postal_code",
    "company_id",
    "branch_id",
    "department_id",
    "job_position_id",
    "employee_status_id",
    "join_date",
    "end_contract_date",
    "office_hour_type",
    "office_hour_id",
    "group_id",
    "approvals_line",
    "pin",
    "leave_at",
    "npwp",
    "ptkp_code",
    "bank_id",
    "bank_account",
    "bank_account_holder",
    "bpjs_tk",
    "bpjs_ks",
    "bpjs_ks_family",
    "salary_period",
    "salary_type",
    "overtime_status",
    "overtime_auto",
    "is_active",
    "created_by",
    "updated_by",
    "created_at",
    "updated_at",
    "deleted_at",
  ];

  Future<List<EmployeeModel>> getData() async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.query(tblName, columns: columnUsable);
    List<EmployeeModel> dt = [];

    for (int i = 0; i < maps.length; i++) {
      dt.add(EmployeeModel.fromMap(maps[i]));
    }

    return dt;
  }

  Future<Map> getDetail(String empId) async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.query(tblName,
        columns: columnUsable, where: "id = ?", whereArgs: [empId]);
    return maps[0];
  }

  Future<int> add(EmployeeModel dtModel) async {
    var dbClient = await _sqFliteHelper.db;
    return await dbClient.insert(tblName, dtModel.toMap());
  }

  Future<int> update(EmployeeModel dtModel) async {
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
