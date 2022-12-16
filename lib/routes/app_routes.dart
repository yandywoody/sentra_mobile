import 'package:get/get.dart';
import 'package:sentra_mobile/modules/engineering/view/Item_check.dart';
import 'package:sentra_mobile/modules/engineering/view/add_item.dart';
import 'package:sentra_mobile/modules/engineering/view/hadnover.dart';
import 'package:sentra_mobile/modules/engineering/view/inspection_check.dart';
import 'package:sentra_mobile/modules/engineering/view/submit_data.dart';
import 'package:sentra_mobile/modules/engineering/view/sync_data.dart';
import 'package:sentra_mobile/modules/engineering/view/takeover.dart';
import 'package:sentra_mobile/modules/engineering/view/update_barang.dart';
import 'package:sentra_mobile/modules/engineering/view/wo_all.dart';
import 'package:sentra_mobile/modules/engineering/view/wo_done.dart';
import 'package:sentra_mobile/modules/engineering/view/wo_employee.dart';
import 'package:sentra_mobile/modules/engineering/view/wo_history.dart';
import 'package:sentra_mobile/modules/engineering/view/wo_history_detail.dart';
import 'package:sentra_mobile/modules/engineering/view/wo_history_inspection_detail.dart';
import 'package:sentra_mobile/modules/engineering/view/wo_inspection.dart';
import 'package:sentra_mobile/modules/engineering/view/wo_inspection_detail.dart';
import 'package:sentra_mobile/modules/engineering/view/wo_manual.dart';
import 'package:sentra_mobile/modules/engineering/view/wo_project.dart';
import 'package:sentra_mobile/modules/engineering/view/wo_project_detail.dart';
import 'package:sentra_mobile/modules/engineering/view/wo_repair.dart';
import 'package:sentra_mobile/modules/engineering/view/wo_repair_detail.dart';
import 'package:sentra_mobile/modules/engineering/view/wo_service.dart';
import 'package:sentra_mobile/modules/engineering/view/wo_service_detail.dart';
import 'package:sentra_mobile/modules/general/view/kpi.dart';
import 'package:sentra_mobile/modules/general/view/kpi_list.dart';
import 'package:sentra_mobile/modules/general/view/login.dart';
import 'package:sentra_mobile/modules/general/view/profile.dart';
import 'package:sentra_mobile/modules/general/view/splash.dart';
import 'package:sentra_mobile/view/home.dart';

class AppRoute {
  //ROUTES AUTH
  static String splash = "/splash";
  static String getSplashRoute() => splash;
  static String login = "/login";
  static String getLoginRoute() => login;

  static String profile = "/profile";
  static String getProfileRoute() => profile;

  static String syncData = "/sync-data";
  static String getSyncDataRoute() => syncData;
  static String submitData = "/submit-data";
  static String getSubmitDataRoute() => submitData;

  static String home = "/home";
  static String getHomeRoute() => home;
  static String kpi = "/kpi";
  static String getKpiRoute() => kpi;
  static String kpiList = "/kpi-list";
  static String getKpiDetailRoute() => kpiList;
  static String woEmployee = "/wo-employee";
  static String getWoEmployeeRoute() => woEmployee;
  static String itemCheck = "/item-check";
  static String getItemCheckRoute() => itemCheck;

  static String woDone = "/wo-done";
  static String getWoDoneRoute() => woDone;
  static String addItem = "/add-item";
  static String getAddItemRoute() => addItem;

  static String woRepair = "/wo-repair";
  static String getWoRepairRoute() => woRepair;
  static String woRepairDetail = "/wo-repair-detail";
  static String getWoRepairDetailRoute() => woRepairDetail;

  static String woService = "/wo-service";
  static String getWoServiceRoute() => woService;
  static String woServiceDetail = "/wo-service-detail";
  static String getWoServiceDetailRoute() => woServiceDetail;

  static String woProject = "/wo-project";
  static String getWoProjectRoute() => woProject;
  static String woProjectDetail = "/wo-project-detail";
  static String getWoProjectDetailRoute() => woProjectDetail;

  static String woAll = "/wo-all";
  static String getWoAllRoute() => woAll;
  static String woManual = "/wo-manual";
  static String getWoManualRoute() => woManual;
  static String woHistory = "/wo-history";
  static String getWoHistoryRoute() => woHistory;
  static String woHistoryDetail = "/wo-history-detail";
  static String getWoHistoryDetailRoute() => woHistoryDetail;
  static String woHistoryInspectionDetail = "/wo-history-inspection-detail";
  static String getWoHistoryInspectionDetailRoute() =>
      woHistoryInspectionDetail;

  static String woInspection = "/wo-inspection";
  static String getWoInspectionRoute() => woInspection;
  static String woInspectionDetail = "/wo-inspection-detail";
  static String getWoInspectionDetailRoute() => woInspectionDetail;

  static String updateBarang = "/update-barang";
  static String getUpdateBarangRoute() => updateBarang;
  static String handover = "/handover";
  static String getHandoverRoute() => handover;
  static String takeover = "/takeover";
  static String getTakeoverRoute() => takeover;
  static String inspectionCheck = "/inspection-check";
  static String getInspectionCheckRoute() => inspectionCheck;

  static List<GetPage> routes = [
    //AUTH
    GetPage(
      name: splash,
      page: () => Splash(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: login,
      page: () => Login(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    //AUTH
    GetPage(
      name: profile,
      page: () => Profile(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
      name: syncData,
      page: () => SyncData(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: submitData,
      page: () => SubmitData(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
      name: home,
      page: () => Home(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: kpi,
      page: () => Kpi(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: woEmployee,
      page: () => WoEmployees(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: kpiList,
      page: () => KpiList(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: itemCheck,
      page: () => ItemCheck(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: woDone,
      page: () => WoDone(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: addItem,
      page: () => AddItem(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    //ROUTES WO REPAIR ===============================
    GetPage(
      name: woRepair,
      page: () => WoRepair(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: woRepairDetail,
      page: () => WoRepairDetail(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    //ROUTES WO SERVICE ===============================
    GetPage(
      name: woService,
      page: () => WoService(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: woServiceDetail,
      page: () => WoServiceDetail(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    //ROUTES WO PROJECT ===============================
    GetPage(
      name: woProject,
      page: () => WoProject(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: woProjectDetail,
      page: () => WoProjectDetail(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
      name: woAll,
      page: () => WoAll(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: woManual,
      page: () => WoManual(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: woHistory,
      page: () => WoHistory(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: woHistoryDetail,
      page: () => WoHistoryDetail(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: woHistoryInspectionDetail,
      page: () => WoHistoryInspectionDetail(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
      name: updateBarang,
      page: () => UpdateBarang(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
      name: handover,
      page: () => Handover(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
      name: takeover,
      page: () => Takeover(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),

    GetPage(
      name: inspectionCheck,
      page: () => InspectionCheck(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),

//ROUTES WO INSPECTION ===============================
    GetPage(
      name: woInspection,
      page: () => WoInspection(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: woInspectionDetail,
      page: () => WoInspectionDetail(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
  ];
}
