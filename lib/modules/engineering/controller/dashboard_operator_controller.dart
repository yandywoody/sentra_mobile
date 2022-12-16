import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sentra_mobile/config/notify_helper.dart';
import 'package:sentra_mobile/model/employee_model.dart';
import 'package:sentra_mobile/model/user_model.dart';
import 'package:sentra_mobile/modules/engineering/model/activity_model.dart';
import 'package:sentra_mobile/modules/engineering/model/goods_request_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_all_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_onprogres_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_project_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_project_realization_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_repair_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_repair_realization_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_service_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_service_realization_model.dart';
import 'package:sentra_mobile/modules/engineering/repositories/activity_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/goods_request_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/kpi_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_inspection_realization_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_inspection_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_onprogress_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_project_realization_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_project_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_repair_realization_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_repair_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_service_realization_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_service_repository.dart';
import 'package:sentra_mobile/modules/general/model/kpi_model.dart';
import 'package:sentra_mobile/routes/app_routes.dart';

class DashboardOperatorController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  ActivityRepository activityRepo = ActivityRepository();

  GoodsRequestRepository goodsRequestRepository = GoodsRequestRepository();

  WoInspectionRepository inspeksiRepo = WoInspectionRepository();
  WoInspectionRealizationRepository inspeksiRealizRepo =
      WoInspectionRealizationRepository();

  WoRepairRepository repairRepo = WoRepairRepository();
  WoRepairRealizationRepository repairRealizRepo =
      WoRepairRealizationRepository();

  WoServiceRepository serviceRepo = WoServiceRepository();
  WoServiceRealizationRepository serviceRealizRepo =
      WoServiceRealizationRepository();

  WoProjectRepository projectRepo = WoProjectRepository();
  WoProjectRealizationRepository projectRealizRepo =
      WoProjectRealizationRepository();

  WoOnProgressRepository woOnProgressRepo = WoOnProgressRepository();
  KpiRepository kpiRpo = KpiRepository();

  var dtWoAll = <WoAllModel>[].obs;

  var isLoading = false.obs;

  ScrollController scrollController = ScrollController();
  var isScroll = true.obs;

  late EmployeeModel loginEmployee = EmployeeModel();
  late UserModel loginuser = UserModel();

  var session_login = GetStorage();

  var dtActivity = <ActivityModel>[].obs;

  var dtRepair = <WoRepairModel>[].obs;
  var dtRepairRealiz = <WoRepairRealizationModel>[].obs;

  var dtServis = <WoServiceModel>[].obs;
  var dtServisRealiz = <WoServiceRealizationModel>[].obs;

  var dtProject = <WoProjectModel>[].obs;
  var dtProjectRealiz = <WoProjectRealizationModel>[].obs;

  var dtKpiList = <KpiModel>[].obs;
  var dtKpi = KpiModel().obs;

  var dtOnProgress = <WoOnProgressModel>[].obs;

  var dtGoodRequest = <GoodsRequestModel>[].obs;
  var dtGoodRequestCheck = 0.0.obs;
  var dtGoodRequestReceived = 0.0.obs;

  var lastSync = "".obs;

  var isKadept = "Operator";
  var totalWo = 0.obs;
  var totalProgres = 0.obs;
  var valueProgres = 0.0.obs;
  var progressPercentage = 0.0.obs;
  var notivyHelper;

  var result_page = "";

  @override
  void onInit() {
    super.onInit();
    notivyHelper = NotifyHelper();
    notivyHelper.initializeNotification();
    notivyHelper.requestIOSPermissions();

    progressPercentage.value = 10 * 100;
    if (session_login.read("last_sync") == null) {
      session_login.write("last_sync", DateTime.now().toString());
    }
    lastSync.value = "${session_login.read("last_sync") ?? '0'}";

    loginEmployee = EmployeeModel.fromMap(session_login.read("login_employee"));
    loginuser = UserModel.fromMap(session_login.read("login_user"));

    fetchWo();
    getWoOnprogress();
    getGoodsRequest();
    checkUpdateData();

    if (session_login.read("is_kadept") == true) {
      isKadept = "Kadept";
    }
  }

  onResultpage(var page, var arg) async {
    try {
      if (arg != "" && arg != null) {
        result_page = await Get.toNamed(page, arguments: arg);
      } else {
        result_page = await Get.toNamed(page);
      }
    } catch (e) {}
    loadData();
  }

  reSyncData() {
    session_login.write("sync_dayly", 2);
    Get.defaultDialog(
      title: "Confirm",
      middleText: "Update Data?",
      textConfirm: "Ok",
      textCancel: 'Batal',
      barrierDismissible: false,
      onConfirm: () => Get.offAllNamed(AppRoute.getSyncDataRoute()),
      onCancel: () => session_login.write("sync_dayly", 1),
    );
  }

  submitData() {
    Get.defaultDialog(
      title: "Warning",
      middleText: "Submit data? \nData history akan hilang",
      textConfirm: "Ok",
      textCancel: 'Batal',
      barrierDismissible: false,
      onConfirm: () async {
        var result = await Get.toNamed(AppRoute.getSubmitDataRoute());
        loadData();
      },
    );
  }

  logout() {
    Get.defaultDialog(
      title: "Warning",
      middleText: "Apakah anda ingin keluar?",
      textCancel: "Batal",
      textConfirm: "Ok",
      barrierDismissible: false,
      onConfirm: () {
        session_login.erase();
        session_login.write("last_sync", DateTime.now().toString());

        Get.offAllNamed(AppRoute.getLoginRoute());
      },
      onCancel: () {},
    );
  }

  loadData() async {
    isLoading.value = true;
    try {
      // Get.snackbar('Success', 'Successfully Refressh Page',
      //     snackPosition: SnackPosition.BOTTOM);
      // notivyHelper.displayNotification(
      //     title: "Refresh Succes", body: "Your just refresh the page, Cool");

      getWoOnprogress();
      getGoodsRequest();

      loginEmployee =
          EmployeeModel.fromMap(session_login.read("login_employee"));
      loginuser = UserModel.fromMap(session_login.read("login_user"));

      fetchWo();
      fetchActivity();

      if (session_login.read("is_kadept") == true) {
        isKadept = "Kadept";
      }

      refreshController.refreshCompleted();
      isLoading.value = false;
    } catch (err) {
      isLoading.value = false;
      rethrow;
    }
  }

  getWoOnprogress() async {
    var _dtOnProgress = await woOnProgressRepo.getData();
    dtOnProgress.value = _dtOnProgress;

    if (dtOnProgress.length > 0) {
      Get.defaultDialog(
        title: "Warning",
        middleText: "Selesaikan kerjaan yang sedang berlangsung.",
        textConfirm: "Ok",
        barrierDismissible: false,
        onWillPop: () async {
          return Future.value(false);
        },
        onConfirm: () async {
          Get.back();

          if (dtOnProgress[0].workType == "Repair") {
            WoRepairModel dtRepairSend =
                await repairRepo.getDataById(dtOnProgress[0].woId);

            onResultpage(AppRoute.getWoRepairDetailRoute(), dtRepairSend);
          }

          if (dtOnProgress[0].workType == "Service") {
            WoServiceModel dtRepairSend =
                await serviceRepo.getDataById(dtOnProgress[0].woId);

            onResultpage(AppRoute.getWoServiceDetailRoute(), dtRepairSend);
          }

          if (dtOnProgress[0].workType == "Project") {
            WoProjectModel dtSend =
                await projectRepo.getDataById(dtOnProgress[0].woId);

            onResultpage(AppRoute.getWoProjectDetailRoute(), dtSend);
          }
        },
      );
    }
  }

  fetchWo() async {
    dtWoAll.value.clear();
    var _dtRepair = await repairRepo.getDataByEmp(loginEmployee.id);
    dtRepair.value = _dtRepair;
    for (var i = 0; i < dtRepair.length; i++) {
      dtWoAll.add(WoAllModel(
        id: dtRepair[i].id,
        activityCode: dtRepair.value[i].activityCode,
        machineCode: dtRepair.value[i].machineCode,
        startAt: dtRepair.value[i].startAt,
        finishAt: dtRepair.value[i].finishAt,
        score: dtRepair.value[i].score,
        description: dtRepair.value[i].description,
        duration: dtRepair.value[i].duration,
        adminNote: dtRepair.value[i].adminNote,
        workType: "Repair",
      ));
    }

    var _dtRepairRealiz = await repairRealizRepo.getDataByEmp(loginEmployee.id);
    dtRepairRealiz.value = _dtRepairRealiz;

    var _dtServis = await serviceRepo.getDataByEmp(loginEmployee.id);
    dtServis.value = _dtServis;
    for (var i = 0; i < dtServis.value.length; i++) {
      dtWoAll.add(WoAllModel(
        id: dtServis.value[i].id,
        activityCode: dtServis.value[i].activityCode,
        machineCode: dtServis.value[i].machineCode,
        startAt: dtServis.value[i].startAt,
        finishAt: dtServis.value[i].finishAt,
        score: dtServis.value[i].score,
        description: dtServis.value[i].description,
        duration: dtServis.value[i].duration,
        adminNote: dtServis.value[i].adminNote,
        workType: "Service",
      ));
    }

    var _dtServisRealiz = await serviceRealizRepo.getData();
    dtServisRealiz.value = _dtServisRealiz;

    var _dtProject = await projectRepo.getDataByEmp(loginEmployee.id);
    dtProject.value = _dtProject;
    for (var i = 0; i < dtProject.value.length; i++) {
      dtWoAll.add(WoAllModel(
        id: dtProject.value[i].id,
        activityCode: dtProject.value[i].name,
        machineCode: "Project",
        startAt: dtProject.value[i].startAt,
        finishAt: dtProject.value[i].finishAt,
        score: dtProject.value[i].score,
        description: "",
        duration: dtProject.value[i].duration,
        adminNote: dtProject.value[i].adminNote,
        workType: "Project",
      ));
    }

    dtWoAll.sort((a, b) => a.startAt!.compareTo(b.startAt.toString()));

    var _dtProjectRealiz =
        await projectRealizRepo.getDataByEmp(loginEmployee.id);
    dtProjectRealiz.value = _dtProjectRealiz;

    totalWo.value =
        dtRepair.value.length + dtServis.value.length + dtProject.value.length;
    totalProgres.value = dtRepairRealiz.value.length +
        dtServisRealiz.value.length +
        dtProjectRealiz.value.length;

    totalWo.value += totalProgres.value;

    var _dtKpi = await kpiRpo.getDataByEmp(loginEmployee.id);
    dtKpiList.value = _dtKpi;
    if (dtKpiList.isNotEmpty) {
      dtKpi.value = dtKpiList.value[0];
    }

    if (totalWo.value == 0) {
      valueProgres.value = 0.0;
    } else {
      valueProgres.value = (totalProgres.value / (totalWo.value));
    }
  }

  fetchActivity() async {
    var _dtActivity = await activityRepo.getData();
    dtActivity.value = _dtActivity;
  }

  getGoodsRequest() async {
    dtGoodRequestCheck.value = 0;
    dtGoodRequestReceived.value = 0;
    var dt = goodsRequestRepository.getDataByEmp(loginEmployee.id);
    dtGoodRequest.value = await dt;

    for (var i = 0; i < dtGoodRequest.length; i++) {
      if (dtGoodRequest.value[i].goodsTakerId != null) {
        dtGoodRequestCheck.value += dtGoodRequestCheck.value +
            double.parse(dtGoodRequest.value[i].goodsTakerId.toString());
      }

      if (dtGoodRequest.value[i].requestVerifyBy != null) {
        dtGoodRequestReceived.value += dtGoodRequestReceived.value +
            double.parse(dtGoodRequest.value[i].requestVerifyBy.toString());
      }
    }
  }

  checkUpdateData() async {
    final startAt = await DateTime.parse(lastSync.value);
    final dateNow = DateTime.now();
    final difference = dateNow.difference(startAt).inDays;

    if (difference > 0) {
      Get.defaultDialog(
        title: "Warning",
        middleText:
            "Waduh, sepertinya data kamu usang, segera update data di pos !",
        textConfirm: "Ok",
        barrierDismissible: false,
        onConfirm: () {
          Get.back();
        },
      );
    }
  }

  woDetail(var dt) {
    if (dt.workType == "Repair") {
      var sendData = dtRepair.where((wo) {
        final actCode = (wo.id ?? "").toLowerCase();
        final input = dt.id;
        return actCode.contains(input!);
      }).toList();
      onResultpage(AppRoute.getWoRepairDetailRoute(), sendData[0]);
    }
    if (dt.workType == "Service") {
      var sendData = dtServis.where((wo) {
        final actCode = (wo.id ?? "").toLowerCase();
        final input = dt.id;
        return actCode.contains(input!);
      }).toList();
      onResultpage(AppRoute.getWoServiceDetailRoute(), sendData[0]);
    }
    if (dt.workType == "Project") {
      var sendData = dtProject.where((wo) {
        final actCode = (wo.id ?? "").toLowerCase();
        final input = dt.id;
        return actCode.contains(input!);
      }).toList();
      onResultpage(AppRoute.getWoProjectDetailRoute(), sendData[0]);
    }
  }
}
