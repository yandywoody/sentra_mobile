import 'package:flutter_bcrypt/flutter_bcrypt.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sentra_mobile/config/sqflite_helper.dart';
import 'package:sentra_mobile/modules/general/model/login_model.dart';
import 'package:sentra_mobile/model/user_model.dart';
import 'package:sentra_mobile/repositories/employee_repository.dart';

class UserRepository {
  final SQFliteHelper _sqFliteHelper = SQFliteHelper();
  final session_login = GetStorage();
  String tblName = "user";

  var columnUsable = [
    "id",
    "employee_id",
    "name",
    "password",
    "photo",
    "remember_token",
    "api_token",
    "last_logged_ip",
    "last_logged_at",
    "is_active",
    "created_by",
    "updated_by",
    "created_at",
    "updated_at",
    "deleted_at",
  ];

  Future<List<UserModel>> getUser() async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.query(tblName, columns: columnUsable);
    List<UserModel> user = [];

    for (int i = 0; i < maps.length; i++) {
      user.add(UserModel.fromMap(maps[i]));
    }

    return user;
  }

  Future<bool> login(LoginModel loginModel) async {
    var isLogin = false;
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps213 = await dbClient.query(tblName, columns: columnUsable);
    for (int i = 0; i < maps213.length; i++) {
      var result = FlutterBcrypt.verify(
          password: loginModel.password, hash: maps213[i]["password"]);
      if (await result && loginModel.name == maps213[i]["name"]) {
        EmployeeRepository empRepo = EmployeeRepository();
        Map dtEmployee = await empRepo.getDetail(maps213[i]["employee_id"]);

        if (maps213[i]["name"] == "eng-wahidin") {
          session_login.write('is_kadept', true);
        } else {
          session_login.write('is_kadept', false);
        }

        session_login.write('login_employee', dtEmployee);
        session_login.write('login_user', maps213[i]);
        session_login.write('login_name', maps213[i]["name"]);

        isLogin = true;
      }
    }
    return isLogin;
  }

  Future<int> add(UserModel userModel) async {
    var dbClient = await _sqFliteHelper.db;
    return await dbClient.insert(tblName, userModel.toMap());
  }

  Future<int> update(UserModel userModel) async {
    var dbClient = await _sqFliteHelper.db;
    return await dbClient.update(tblName, userModel.toMap(),
        where: "id = ?", whereArgs: [userModel.id]);
  }

  Future<int> delete(int id) async {
    var dbClient = await _sqFliteHelper.db;
    return await dbClient.delete(tblName, where: "id = ?", whereArgs: [id]);
  }

  Future<void> turncateTable() async {
    var dbClient = await _sqFliteHelper.db;
    return await dbClient.execute("DELETE FROM user");
  }
}
