import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sentra_mobile/model/employee_model.dart';
import 'package:sentra_mobile/model/user_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_all_realization_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_inspection_realization_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_project_realization_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_repair_realization_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_service_realization_model.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_inspection_realization_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_project_realization_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_repair_realization_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_service_realization_repository.dart';
import 'package:sentra_mobile/routes/app_routes.dart';

class WoHistoryController extends GetxController {
  var data = Get.arguments;

  var dt = <WoRepairRealizationModel>[].obs;
  WoRepairRealizationRepository repo = WoRepairRealizationRepository();

  var dt2 = <WoServiceRealizationModel>[].obs;
  WoServiceRealizationRepository repo2 = WoServiceRealizationRepository();

  var dt3 = <WoProjectRealizationModel>[].obs;
  WoProjectRealizationRepository repo3 = WoProjectRealizationRepository();

  var dt4 = <WoInspectionRealizationModel>[].obs;
  WoInspectionRealizationRepository repo4 = WoInspectionRealizationRepository();

  var dtWoAll = <WoAllRealizationModel>[].obs;
  var dtWoAllTemp = <WoAllRealizationModel>[].obs;

  var session_login = GetStorage();
  late EmployeeModel loginEmployee = EmployeeModel();
  late UserModel loginuser = UserModel();

  @override
  void onInit() {
    super.onInit();

    loginEmployee = EmployeeModel.fromMap(session_login.read("login_employee"));
    loginuser = UserModel.fromMap(session_login.read("login_user"));
    session_login.write("is_history", 1);

    fetchData();
  }

  Future<void> onLoading() async {
    fetchData();
    update();
  }

  fetchData() async {
    dtWoAll.clear();
    var _dt = await repo.getDataByEmp(loginEmployee.id);
    dt.value = _dt;
    for (var i = 0; i < dt.length; i++) {
      dtWoAll.add(WoAllRealizationModel(
        id: dt[i].id,
        relationableId: dt[i].repairId,
        code: dt[i].code,
        activityCode: dt[i].activityCode,
        machineCode: dt[i].machineCode,
        startAt: dt[i].startAt,
        finishAt: dt[i].finishAt,
        description: dt[i].description,
        duration: dt[i].duration,
        isFinish: dt[i].isFinish,
        workType: "Repair",
      ));
    }

    var _dt2 = await repo2.getDataByEmp(loginEmployee.id);
    dt2.value = _dt2;
    for (var i = 0; i < dt2.length; i++) {
      dtWoAll.add(WoAllRealizationModel(
        id: dt2[i].id,
        relationableId: dt2[i].serviceId,
        code: dt2[i].code,
        activityCode: dt2[i].activityCode,
        machineCode: dt2[i].machineCode,
        startAt: dt2[i].startAt,
        finishAt: dt2[i].finishAt,
        isFinish: dt2[i].isFinish,
        score: 0,
        description: "",
        duration: dt2[i].duration,
        workType: "Service",
      ));
    }

    var _dt3 = await repo3.getDataByEmp(loginEmployee.id);
    dt3.value = _dt3;
    for (var i = 0; i < dt3.length; i++) {
      dtWoAll.add(WoAllRealizationModel(
        id: dt3[i].id,
        relationableId: dt3[i].projectDetailId,
        code: dt3[i].code,
        activityCode: dt3[i].activityCode,
        machineCode: "Project",
        startAt: dt3[i].startAt,
        finishAt: dt3[i].finishAt,
        isFinish: 1,
        score: 0,
        description: "",
        duration: dt3[i].duration,
        workType: "Project",
      ));
    }

    var _dt4 = await repo4.getDataByEmp(loginEmployee.id);
    dt4.value = _dt4;

    for (var i = 0; i < dt4.length; i++) {
      dtWoAll.add(WoAllRealizationModel(
        id: dt4[i].inspectionId,
        relationableId: dt4[i].inspectionId,
        code: dt4[i].code,
        activityCode: "",
        machineCode: dt4[i].machineCode,
        startAt: dt4[i].startAt,
        finishAt: dt4[i].finishAt,
        isFinish: 1,
        isActive: 0,
        score: 0,
        description: "",
        duration: dt4[i].duration,
        workType: "Inspeksi",
      ));
    }

    dtWoAllTemp.value = dtWoAll.value;
  }
}
