import 'dart:async';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sentra_mobile/config/network_helper.dart';
import 'package:sentra_mobile/model/user_model.dart';
import 'package:sentra_mobile/modules/engineering/model/sync_model.dart';
import 'package:sentra_mobile/modules/engineering/repositories/activity_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/employee_task_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/goods_request_item_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/goods_request_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/inspection_check_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/kpi_detail_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/kpi_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/project_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/sync_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_inspection_employee_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_inspection_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_project_employee_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_project_realization_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_project_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_repair_employee_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_repair_realization_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_repair_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_service_employee_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_service_realization_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_service_repository.dart';
import 'package:sentra_mobile/repositories/employee_repository.dart';
import 'package:sentra_mobile/repositories/user_repository.dart';
import 'package:sentra_mobile/routes/api_routes.dart';
import 'package:sentra_mobile/routes/app_routes.dart';

class SyncDataController extends GetxController {
  final session_login = GetStorage();
  var valProgress = 0.obs;
  var statusProgress = "Update Data, Please Wait".obs;

  final listUser = <UserModel>[].obs;

  bool isLoading = false;

  Timer? timer;

  @override
  void onInit() {
    super.onInit();
    valProgress.value = 3;
    (session_login.read("sync_dayly") == 2) ? reSyncData() : daylySyncData();
  }

  daylySyncData() async {
    valProgress.value += 1;
    statusProgress.value = chageStatus(valProgress.value);
    //var now = DateTime.now().add(Duration(days: -1));
    var now = DateTime.now();

    session_login.write("last_sync", now.toString());

    var response =
        await NetwrokHelper.get("${ApiRoute.endptSync}?is_init=1&is_update=0");
    valProgress.value += 1;
    statusProgress.value = chageStatus(valProgress.value);
    if (response == null || response == "") {
      Get.defaultDialog(
          title: "Error Response",
          onConfirm: () => Get.offAndToNamed(AppRoute.getSplashRoute()),
          barrierDismissible: false,
          middleText:
              "Data kosong. Pastikan perangkat sudah terhubung dengan jaringan dengan sinyal yang bagus",
          textConfirm: "Ok");
    } else if (response == "error_time_out") {
      Get.defaultDialog(
          title: "Error Timeout",
          onCancel: () => Get.offAndToNamed(AppRoute.getSplashRoute()),
          barrierDismissible: false,
          middleText:
              "Koneksi gagal, silahkan menuju hubungkan perangkat ke jaringan, lalu coba lagi",
          textCancel: "Ok");
    } else {
      try {
        valProgress.value += 1;
        statusProgress.value = chageStatus(valProgress.value);
        var allData = SyncModel.fromJson(response);
        SyncRepository syncRepository = SyncRepository();

        addData(allData.mInspectionCheck, InspectionCheckRepository());
        addData(allData.goodsRequest, GoodsRequestRepository());
        addData(allData.goodsRequestItem, GoodsRequestItemRepository());
        addData(allData.kpi, KpiRepository());
        addData(allData.kpiDetail, KpiDetailRepository());
        addData(allData.woService, WoServiceRepository());
        addData(allData.woRepair, WoRepairRepository());
        addDataInspection(allData.woInspection, WoInspectionRepository());
        addData(allData.project, ProjectRepository());
        addData(allData.woProject, WoProjectRepository());
        addData(allData.woServiceEmployee, WoServiceEmployeeRepository());
        addData(allData.woRepairEmployee, WoRepairEmployeeRepository());
        addData(allData.woInspectionEmployee, WoInspectionEmployeeRepository());
        addData(allData.woProjectEmployee, WoProjectEmployeeRepository());

        syncRepository.adduser();
        valProgress.value += 1;
        statusProgress.value = chageStatus(valProgress.value);
        syncRepository.addEmp();
        valProgress.value += 1;
        statusProgress.value = chageStatus(valProgress.value);
        syncRepository.addMchn();
        valProgress.value += 1;
        statusProgress.value = chageStatus(valProgress.value);
        syncRepository.addActivity();
        valProgress.value += 1;
        statusProgress.value = chageStatus(valProgress.value);
        syncRepository.addInspectionCheck();
        valProgress.value += 1;
        statusProgress.value = chageStatus(valProgress.value);
        //syncRepository.addItems();
        valProgress.value += 1;
        statusProgress.value = chageStatus(valProgress.value);

        timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
          statusProgress.value = chageStatus(valProgress.value);
          if (valProgress.value >= 10) {
            timer?.cancel();

            valProgress.value = 19;
            statusProgress.value = "Finishing Data ...";

            finishingData();
          }
        });
      } on FormatException catch (e) {
        Get.snackbar('Try Update Again', e.toString(),
            snackPosition: SnackPosition.BOTTOM);

        valProgress.value = 3;
        statusProgress.value = chageStatus(valProgress.value);

        daylySyncData();
      }
    }
  }

  reSyncData() async {
    valProgress.value += 1;
    statusProgress.value = chageStatus(valProgress.value);
    var now = DateTime.now();

    session_login.write("last_sync", now.toString());
    var response =
        await NetwrokHelper.get("${ApiRoute.endptSync}?is_init=0&is_update=1");
    valProgress.value += 1;
    statusProgress.value = chageStatus(valProgress.value);
    if (response == "") {
      Get.defaultDialog(
          title: "Error Response",
          onConfirm: () => Get.offAndToNamed(AppRoute.getSplashRoute()),
          barrierDismissible: false,
          middleText:
              "Data kosong. Pastikan perangkat sudah terhubung dengan jaringan dengan sinyal yang bagus",
          textConfirm: "Ok");
    } else if (response == "error_time_out") {
      Get.defaultDialog(
          title: "Error Timeout",
          onCancel: () => Get.offAndToNamed(AppRoute.getSplashRoute()),
          barrierDismissible: false,
          middleText:
              "Koneksi gagal, silahkan menuju hubungkan perangkat ke jaringan, lalu coba lagi",
          textCancel: "Ok");
    } else {
      try {
        valProgress.value += 1;
        statusProgress.value = chageStatus(valProgress.value);
        var allData = SyncModel.fromJson(response);

        updateData(allData.mUser, UserRepository());
        updateData(allData.mActivity, ActivityRepository());
        updateData(allData.mMachines, MachineRepository());
        updateData(allData.mEmployees, EmployeeRepository());
        updateData(allData.mInspectionCheck, InspectionCheckRepository());
        updateData(allData.goodsRequest, GoodsRequestRepository());
        updateData(allData.goodsRequestItem, GoodsRequestItemRepository());
        updateData(allData.kpi, KpiRepository());
        updateData(allData.kpiDetail, KpiDetailRepository());
        updateData(allData.woService, WoServiceRepository());
        updateData(allData.woRepair, WoRepairRepository());
        updateDataInspection(allData.woInspection, WoInspectionRepository());
        updateData(allData.project, ProjectRepository());
        updateData(allData.woProject, WoProjectRepository());
        updateData(allData.woServiceEmployee, WoServiceEmployeeRepository());
        updateData(allData.woRepairEmployee, WoRepairEmployeeRepository());
        updateData(
            allData.woInspectionEmployee, WoInspectionEmployeeRepository());
        updateData(allData.woProjectEmployee, WoProjectEmployeeRepository());

        timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
          statusProgress.value = chageStatus(valProgress.value);
          if (valProgress.value >= 5) {
            timer?.cancel();

            valProgress.value = 19;
            statusProgress.value = "Success ...";
            Get.defaultDialog(
              title: "Success",
              middleText: "Data berhasil di syncronize",
              textConfirm: "Ok",
              barrierDismissible: false,
              onConfirm: () {
                session_login.write("sync_dayly", 1);
                Get.offAllNamed(AppRoute.getHomeRoute());
              },
            );
          }
        });
      } catch (e) {
        Get.snackbar('Try Update Again', e.toString(),
            snackPosition: SnackPosition.BOTTOM);

        valProgress.value = 3;
        statusProgress.value = chageStatus(valProgress.value);

        reSyncData();
      }
    }
  }

  addData(List<dynamic>? listModel, dynamic repo) {
    try {
      if (listModel!.isNotEmpty) {
        repo.turncateTable();
        for (int i = 0; i < listModel.length; i++) {
          repo.add(listModel[i]);
        }

        valProgress.value += 1;
        statusProgress.value = chageStatus(valProgress.value);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  updateData(List<dynamic>? listModel, dynamic repo) async {
    try {
      if (listModel!.isNotEmpty) {
        //repo.turncateTable();
        for (int i = 0; i < listModel.length; i++) {
          var tempData = await repo.getData();
          List<dynamic> checkData = tempData;
          checkData.contains(listModel[i]);
          var contain =
              checkData.where((element) => element.id == listModel[i].id);

          if (contain.isEmpty) {
            repo.add(listModel[i]);
          }
        }

        valProgress.value += 1;
        statusProgress.value = chageStatus(valProgress.value);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  addDataInspection(List<dynamic>? listModel, dynamic repo) {
    try {
      if (listModel!.isNotEmpty) {
        repo.turncateTable();
        for (int i = 0; i < listModel.length; i++) {
          repo.add(listModel[i]);
          if (listModel[i].workType == "Repair") {
            WoRepairRepository rp = WoRepairRepository();
            rp.add(listModel[i].inspectionRelation);

            WoRepairRealizationRepository repoReal =
                WoRepairRealizationRepository();
            for (int j = 0;
                j < listModel[i].inspectionRelation.realization.length;
                j++) {
              repoReal.add(listModel[i].inspectionRelation.realization[j]);
            }
          }
          if (listModel[i].workType == "Service") {
            WoServiceRepository rp = WoServiceRepository();
            rp.add(listModel[i].inspectionRelation);

            WoServiceRealizationRepository repoReal =
                WoServiceRealizationRepository();
            for (int j = 0;
                j < listModel[i].inspectionRelation.realization.length;
                j++) {
              repoReal.add(listModel[i].inspectionRelation.realization[j]);
            }
          }
          if (listModel[i].workType == "Project") {
            WoProjectRepository rp = WoProjectRepository();
            rp.add(listModel[i].inspectionRelation);

            WoProjectRealizationRepository repoReal =
                WoProjectRealizationRepository();
            for (int j = 0;
                j < listModel[i].inspectionRelation.realization.length;
                j++) {
              repoReal.add(listModel[i].inspectionRelation.realization[j]);
            }
          }
        }
      }

      valProgress.value += 1;
      statusProgress.value = chageStatus(valProgress.value);
    } catch (e) {
      print(e.toString());
    }
  }

  updateDataInspection(List<dynamic>? listModel, dynamic repo) {
    try {
      if (listModel!.isNotEmpty) {
        //repo.turncateTable();
        for (int i = 0; i < listModel.length; i++) {
          repo.add(listModel[i]);
          if (listModel[i].workType == "Repair") {
            WoRepairRepository rp = WoRepairRepository();
            rp.add(listModel[i].inspectionRelation);

            WoRepairRealizationRepository repoReal =
                WoRepairRealizationRepository();
            for (int j = 0;
                j < listModel[i].inspectionRelation.realization.length;
                j++) {
              repoReal.add(listModel[i].inspectionRelation.realization[j]);
            }
          }
          if (listModel[i].workType == "Service") {
            WoServiceRepository rp = WoServiceRepository();
            rp.add(listModel[i].inspectionRelation);

            WoServiceRealizationRepository repoReal =
                WoServiceRealizationRepository();
            for (int j = 0;
                j < listModel[i].inspectionRelation.realization.length;
                j++) {
              repoReal.add(listModel[i].inspectionRelation.realization[j]);
            }
          }
          if (listModel[i].workType == "Project") {
            WoProjectRepository rp = WoProjectRepository();
            rp.add(listModel[i].inspectionRelation);

            WoProjectRealizationRepository repoReal =
                WoProjectRealizationRepository();
            for (int j = 0;
                j < listModel[i].inspectionRelation.realization.length;
                j++) {
              repoReal.add(listModel[i].inspectionRelation.realization[j]);
            }
          }
        }
      }

      valProgress.value += 1;
      statusProgress.value = chageStatus(valProgress.value);
    } catch (e) {
      print(e.toString());
    }
  }

  finishingData() {
    isLoading = true;
    update();

    var duration = const Duration(seconds: 3);
    Timer(duration, () {
      Get.defaultDialog(
        title: "Success",
        middleText: "Data berhasil di syncronize",
        textConfirm: "Ok",
        barrierDismissible: false,
        onConfirm: () {
          session_login.write("sync_dayly", 1);
          Get.offAllNamed(AppRoute.getLoginRoute());
        },
      );
    });
  }

  chageStatus(int ind) {
    var statusText = [
      "Update Data, Please Wait",
      "Init Database ...",
      "Call API ...",
      "Get Response ...",
      "Download User Data...",
      "Download Employee Data...",
      "Download Machine Data...",
      "Download Activity Data ...",
      "Download Inspection Check Data...",
      "Download Wo Repair Data...",
      "Download Wo Repair Employee Data...",
      "Download Wo Service Data ...",
      "Download Wo Service Employee Data ...",
      "Download Wo Inspection Data ...",
      "Download Wo Inspection Employee Data ...",
      "Download Wo Project ...",
      "Download Wo Employee Project ...",
      "Analyziz Data ...",
      "Storeing Data ...",
      "Almost Done ...",
      "Finishing All ...",
      "Storeing Data ...",
      "Almost Done ...",
      "Finishing All ...",
      "Success ...",
      "Success ...",
      "Finishing All ...",
    ];

    return statusText[ind];
  }
}
