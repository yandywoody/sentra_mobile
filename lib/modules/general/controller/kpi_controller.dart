import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sentra_mobile/model/employee_model.dart';
import 'package:sentra_mobile/model/user_model.dart';
import 'package:sentra_mobile/modules/engineering/repositories/kpi_detail_repository.dart';
import 'package:sentra_mobile/modules/general/model/kpi_detail_model.dart';
import 'package:sentra_mobile/modules/general/model/kpi_model.dart';
import 'package:sentra_mobile/routes/app_routes.dart';

class KpiController extends GetxController {
  KpiModel dtKpiChoose = Get.arguments;
  late EmployeeModel loginEmployee = EmployeeModel();
  late UserModel loginuser = UserModel();

  KpiDetailRepository kpiRpo = KpiDetailRepository();
  var dtKpi = <KpiDetailModel>[].obs;

  var session_login = GetStorage();
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
    var _dtKpi = await kpiRpo.getDataById(dtKpiChoose.id);
    dtKpi.value = _dtKpi;
  }

  kpiList() {
    Get.offNamed(AppRoute.getKpiDetailRoute());
  }
}
