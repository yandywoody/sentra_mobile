import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sentra_mobile/model/employee_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_inspection_model.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_inspection_repository.dart';
import 'package:sentra_mobile/routes/app_routes.dart';

class WoInspectionController extends GetxController {
  var woInspec = <WoInspectionModel>[].obs;
  WoInspectionRepository woInspectionRepo = WoInspectionRepository();

  var session_login = GetStorage();
  late EmployeeModel loginEmployee = EmployeeModel();

  @override
  void onInit() {
    super.onInit();

    loginEmployee = EmployeeModel.fromMap(session_login.read("login_employee"));

    fetchWo();
  }

  fetchWo() async {
    var dt2 = await woInspectionRepo.getDataByEmp(loginEmployee.id);
    woInspec.value = dt2;
  }

  woDetail(WoInspectionModel dt) async {
    var result =
        await Get.toNamed(AppRoute.getWoInspectionDetailRoute(), arguments: dt);
    fetchWo();
  }
}
