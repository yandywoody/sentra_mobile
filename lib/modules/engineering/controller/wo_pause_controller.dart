import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sentra_mobile/model/employee_model.dart';
import 'package:sentra_mobile/model/user_model.dart';
import 'package:sentra_mobile/modules/engineering/model/machine_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_all_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_onprogres_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_project_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_repair_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_service_model.dart';
import 'package:sentra_mobile/modules/engineering/repositories/employee_task_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_onprogress_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_project_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_repair_employee_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_repair_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_service_repository.dart';
import 'package:sentra_mobile/repositories/employee_repository.dart';
import 'package:sentra_mobile/routes/app_routes.dart';

class WoPauseController extends GetxController
    with GetTickerProviderStateMixin {
  late AnimationController animationController;

  var dtWoService = <WoServiceModel>[].obs;
  WoServiceRepository woRepoService = WoServiceRepository();

  var dtWoProject = <WoProjectModel>[].obs;
  WoProjectRepository woRepoProject = WoProjectRepository();

  var dtMachine = <MachineModel>[].obs;
  var dtMachineTemp = <MachineModel>[].obs;
  MachineRepository repoMachine = MachineRepository();

  var dtOpt = <EmployeeModel>[].obs;
  var dtOptTemp = <EmployeeModel>[].obs;
  EmployeeRepository repoEmp = EmployeeRepository();

  var dtWoRepair = <WoRepairModel>[].obs;
  WoRepairRepository woRepoRepair = WoRepairRepository();
  WoRepairEmployeeRepository woRepoEmpRepair = WoRepairEmployeeRepository();

  TextEditingController searchTxtController = TextEditingController();
  TextEditingController sActivityEc = TextEditingController();
  TextEditingController sMachineEc = TextEditingController();
  TextEditingController sOptEc = TextEditingController();

  TextEditingController mchnEc = TextEditingController();
  TextEditingController optEc = TextEditingController();
  TextEditingController acvtEc = TextEditingController();

  var dtWorkType = ["All", "Repair", "Service", "Project"];
  var frmWorkType = "All".obs;

  var dtWoAll = <WoAllModel>[].obs;
  var dtWoAllTemp = <WoAllModel>[].obs;
  var dtWoAllFilter = <WoAllModel>[].obs;

  var session_login = GetStorage();
  late EmployeeModel loginEmployee = EmployeeModel();
  late UserModel loginuser = UserModel();

  @override
  void onInit() {
    super.onInit();
    animationController = BottomSheet.createAnimationController(this);
    animationController.duration = Duration(milliseconds: 450);
    animationController.reverseDuration = const Duration(milliseconds: 450);
    animationController.drive(CurveTween(curve: Curves.easeIn));

    loginEmployee = EmployeeModel.fromMap(session_login.read("login_employee"));
    loginuser = UserModel.fromMap(session_login.read("login_user"));

    fetchWo();
  }

  setWorkType(String value) {
    frmWorkType.value = value;
  }

  searchDataMachine(String data) {
    final result = dtMachineTemp.where((dt) {
      final actCode = (dt.code ?? "").toLowerCase();
      final input = data.toLowerCase();
      return actCode.contains(input);
    }).toList();

    dtMachine.value = result;
    update();
  }

  searchDataActivity(String data) {
    final result = dtWoAllTemp.where((dt) {
      final actCode = (dt.code ?? "").toLowerCase();
      final input = data.toLowerCase();
      return actCode.contains(input);
    }).toList();

    dtWoAllFilter.value = result;
    update();
  }

  searchDataOpt(String data) {
    final result = dtOptTemp.where((dt) {
      final actCode = (dt.name ?? "").toLowerCase();
      final input = data.toLowerCase();
      return actCode.contains(input);
    }).toList();

    dtOpt.value = result;
    update();
  }

  filterData() {
    var resultAll = dtWoAllTemp.value;

    if (frmWorkType.value != "All") {
      final result = resultAll.where((dt) {
        final actCode = (dt.workType ?? "").toLowerCase();
        final input = frmWorkType.value.toLowerCase();

        return actCode.contains(input);
      }).toList();

      resultAll = result;
    }

    if (acvtEc.text != "") {
      final result = resultAll.where((dt) {
        final actCode = (dt.activityCode ?? "").toLowerCase();
        final input = acvtEc.text.toLowerCase();

        return actCode.contains(input);
      }).toList();

      resultAll = result;
    }

    if (mchnEc.text != "") {
      final result = resultAll.where((dt) {
        final actCode = (dt.machineCode ?? "").toLowerCase();
        final input = mchnEc.text.toLowerCase();

        return actCode.contains(input);
      }).toList();

      resultAll = result;
    }

    dtWoAll.value = resultAll;
    update();
  }

  fetchWo() async {
    var dt2 = await woRepoRepair.getDataPauseWo();
    dtWoRepair.value = dt2;
    for (var i = 0; i < dt2.length; i++) {
      dtWoAll.add(WoAllModel(
        id: dt2[i].id,
        activityCode: dt2[i].activityCode,
        machineCode: dt2[i].machineCode,
        startAt: dt2[i].startAt,
        finishAt: dt2[i].finishAt,
        score: dt2[i].score,
        description: dt2[i].description,
        duration: dt2[i].duration,
        workType: "Repair",
      ));
    }

    var dt = await woRepoService.getDataPauseWo();
    dtWoService.value = dt;
    for (var i = 0; i < dt.length; i++) {
      dtWoAll.add(WoAllModel(
        id: dt[i].id,
        activityCode: dt[i].activityCode,
        machineCode: dt[i].machineCode,
        startAt: dt[i].startAt,
        finishAt: dt[i].finishAt,
        score: dt[i].score,
        description: dt[i].description,
        duration: dt[i].duration,
        workType: "Service",
      ));
    }

    var dt3 = await woRepoProject.getDataPauseWo();
    dtWoProject.value = dt3;
    for (var i = 0; i < dt3.length; i++) {
      dtWoAll.add(WoAllModel(
        id: dt3[i].id,
        activityCode: dt3[i].name,
        machineCode: "Project",
        startAt: dt3[i].startAt,
        finishAt: dt3[i].finishAt,
        score: dt3[i].score,
        description: "",
        duration: dt3[i].duration,
        workType: "Project",
      ));
    }

    dtWoAllTemp.value = dtWoAll.value;
    dtWoAllFilter.value = dtWoAll.value;
  }

  woDetail(var dt) {
    if (dt.workType == "Repair") {
      var sendData = dtWoRepair.where((wo) {
        final actCode = (wo.id ?? "").toLowerCase();
        final input = dt.id;
        return actCode.contains(input);
      }).toList();
      Get.toNamed(AppRoute.getWoRepairDetailRoute(), arguments: sendData[0]);
    }
    if (dt.workType == "Service") {
      var sendData = dtWoService.where((wo) {
        final actCode = (wo.id ?? "").toLowerCase();
        final input = dt.id;
        return actCode.contains(input);
      }).toList();
      Get.toNamed(AppRoute.getWoServiceDetailRoute(), arguments: sendData[0]);
    }
    if (dt.workType == "Project") {
      var sendData = dtWoProject.where((wo) {
        final actCode = (wo.id ?? "").toLowerCase();
        final input = dt.id;
        return actCode.contains(input);
      }).toList();
      Get.toNamed(AppRoute.getWoProjectDetailRoute(), arguments: sendData[0]);
    }
  }
}
