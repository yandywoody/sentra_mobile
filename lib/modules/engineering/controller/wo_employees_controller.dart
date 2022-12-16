import 'package:get/get.dart';
import 'package:sentra_mobile/model/employee_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_all_employee_model.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_project_employee_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_repair_employee_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_service_employee_repository.dart';

class WoEmployeesController extends GetxController {
  var dtWo = Get.arguments;

  var dt = <EmployeeModel>[].obs;
  WoRepairEmployeeRepository empRepairRepo = WoRepairEmployeeRepository();
  WoServiceEmployeeRepository empServiceRepo = WoServiceEmployeeRepository();
  WoProjectEmployeeRepository empProjectRepo = WoProjectEmployeeRepository();

  @override
  void onInit() {
    super.onInit();
    fetchWo();
  }

  fetchWo() async {
    if (dtWo.workType == "Repair") {
      var _dt = await empRepairRepo.getEmpByWo(dtWo.id);
      dt.value = _dt;
    } else if (dtWo.workType == "Service") {
      var _dt = await empServiceRepo.getEmpByWo(dtWo.id);
      dt.value = _dt;
    } else {
      var _dt = await empProjectRepo.getEmpByWo(dtWo.code);
      dt.value = _dt;
    }
  }
}
