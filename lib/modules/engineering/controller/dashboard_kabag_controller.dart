import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sentra_mobile/config/notify_helper.dart';
import 'package:sentra_mobile/model/employee_model.dart';
import 'package:sentra_mobile/model/user_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_inspection_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_inspection_realization_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_onprogres_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_project_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_repair_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_service_model.dart';
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

class DashboardKabagController extends GetxController {
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

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

  late EmployeeModel loginEmployee = EmployeeModel();
  late UserModel loginuser = UserModel();

  WoOnProgressRepository woOnProgressRepo = WoOnProgressRepository();

  ScrollController scrollController = ScrollController();
  var isScroll = true.obs;

  KpiRepository kpiRpo = KpiRepository();
  var dtKpiList = <KpiModel>[].obs;
  var dtKpi = KpiModel().obs;

  var session_login = GetStorage();
  var dtInspeksi = <WoInspectionModel>[].obs;
  var dtInspeksiRealiz = <WoInspectionRealizationModel>[].obs;
  var dtOnProgress = <WoOnProgressModel>[].obs;

  var isKadept = "Operator";
  var totalWo = 0.obs;
  var totalProgres = 0.obs;
  var valueProgres = 0.0.obs;
  var notivyHelper;
  var lastSync = "".obs;
  var result_page = "";

  @override
  void onInit() {
    super.onInit();
    notivyHelper = NotifyHelper();
    notivyHelper.initializeNotification();
    notivyHelper.requestIOSPermissions();

    lastSync.value = session_login.read("last_sync");

    loginEmployee = EmployeeModel.fromMap(session_login.read("login_employee"));
    loginuser = UserModel.fromMap(session_login.read("login_user"));

    fetchWo();
    getWoOnprogress();
    checkUpdateData();

    if (session_login.read("is_kadept") == true) {
      isKadept = "Kadept";
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

          if (dtOnProgress[0].workType == "Inspeksi") {
            WoInspectionModel dtRepairSend =
                await inspeksiRepo.getDataById(dtOnProgress[0].woId);

            var result = await Get.toNamed(
                AppRoute.getWoInspectionDetailRoute(),
                arguments: dtRepairSend);
          }
        },
      );
    }
  }

  reSyncData() {
    Get.defaultDialog(
      title: "Confirm",
      middleText: "Update Data?",
      textConfirm: "Ok",
      barrierDismissible: false,
      onConfirm: () {
        session_login.write("sync_dayly", 2);
        Get.offAllNamed(AppRoute.getSyncDataRoute());
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
        session_login.remove('login_user');
        session_login.remove('login_employee');
        session_login.remove('login_name');
        Get.offAndToNamed(AppRoute.getLoginRoute());
      },
      onCancel: () {},
    );
  }

  loadData() async {
    try {
      // Get.snackbar('Success', 'Successfully Refressh Page',
      //     snackPosition: SnackPosition.BOTTOM);
      // notivyHelper.displayNotification(
      //     title: "Refresh Succes", body: "Your just refresh the page, Cool");
      // refreshController.refreshCompleted();

      fetchWo();
      getWoOnprogress();

      loginEmployee =
          EmployeeModel.fromMap(session_login.read("login_employee"));
      loginuser = UserModel.fromMap(session_login.read("login_user"));

      if (session_login.read("is_kadept") == true) {
        isKadept = "Kadept";
      }
      refreshController.refreshCompleted();
    } catch (err) {
      rethrow;
    }
  }

  fetchWo() async {
    var dt = await inspeksiRepo.getDataByEmp(loginEmployee.id);
    dtInspeksi.value = dt;

    var _dtInspeksiRealiz = await inspeksiRealizRepo.getData();
    dtInspeksiRealiz.value = _dtInspeksiRealiz;

    var _dtKpi = await kpiRpo.getDataByEmp(loginEmployee.id);
    dtKpiList.value = _dtKpi;
    if (dtKpiList.isNotEmpty) {
      dtKpi.value = dtKpiList.value[0];
    }

    totalWo.value = dtInspeksi.value.length + dtInspeksiRealiz.value.length;
    totalProgres.value = dtInspeksiRealiz.value.length;

    if (dtInspeksi.length == 0) {
      valueProgres.value = 0.0;
    } else {
      valueProgres.value =
          (totalProgres.value / (totalWo.value + totalProgres.value));
    }
  }

  woDetail(WoInspectionModel dt) async {
    var result =
        await Get.toNamed(AppRoute.getWoInspectionDetailRoute(), arguments: dt);

    loadData();
  }
}
