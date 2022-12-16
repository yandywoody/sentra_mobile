import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sentra_mobile/model/employee_model.dart';
import 'package:sentra_mobile/model/user_model.dart';
import 'package:sentra_mobile/modules/engineering/repositories/kpi_repository.dart';
import 'package:sentra_mobile/modules/general/model/kpi_model.dart';
import 'package:sentra_mobile/routes/app_routes.dart';

class KpiListController extends GetxController {
  KpiRepository kpiRpo = KpiRepository();
  late EmployeeModel loginEmployee = EmployeeModel();
  late UserModel loginuser = UserModel();

  var periodChose = "".obs;

  var session_login = GetStorage();
  var dtKpi = <KpiModel>[].obs;
  var dtKpiChoose = KpiModel().obs;

  var isKadept = "Operator";

  @override
  void onInit() {
    super.onInit();

    loginEmployee = EmployeeModel.fromMap(session_login.read("login_employee"));
    loginuser = UserModel.fromMap(session_login.read("login_user"));

    if (session_login.read("is_kadept") == true) {
      isKadept = "Kadept";
    }

    fetcData();
  }

  fetcData() async {
    var _dtKpi = await kpiRpo.getDataByEmp(loginEmployee.id);
    dtKpi.value = _dtKpi;
  }

  kpiDetail(KpiModel dt) {
    Get.toNamed(AppRoute.getKpiRoute(), arguments: dt);
  }
}
