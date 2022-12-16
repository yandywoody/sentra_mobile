import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sentra_mobile/model/employee_model.dart';
import 'package:sentra_mobile/model/user_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_project_model.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_project_repository.dart';
import 'package:sentra_mobile/routes/app_routes.dart';

class WoProjectController extends GetxController {
  var dtWo = <WoProjectModel>[].obs;
  WoProjectRepository woRepo = WoProjectRepository();
  var session_login = GetStorage();
  late EmployeeModel loginEmployee = EmployeeModel();
  late UserModel loginuser = UserModel();

  @override
  void onInit() {
    super.onInit();

    loginEmployee = EmployeeModel.fromMap(session_login.read("login_employee"));
    loginuser = UserModel.fromMap(session_login.read("login_user"));

    fetchWo();
  }

  fetchWo() async {
    var dt = await woRepo.getDataByEmp(loginEmployee.id);
    dtWo.value = dt;
  }

  woDetail(WoProjectModel dt) {
    dt.activityCode = dt.name;
    Get.toNamed(AppRoute.getWoProjectDetailRoute(), arguments: dt);
  }
}
