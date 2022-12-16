import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sentra_mobile/config/app_theme.dart';
import 'package:sentra_mobile/model/employee_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_onprogres_model.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_onprogress_repository.dart';
import 'package:sentra_mobile/modules/engineering/view/Item_check.dart';
import 'package:sentra_mobile/modules/engineering/view/dashboard_kabag.dart';
import 'package:sentra_mobile/modules/engineering/view/dashboard_operator.dart';
import 'package:sentra_mobile/modules/engineering/view/wo_history.dart';
import 'package:sentra_mobile/modules/engineering/view/wo_pause.dart';
import 'package:sentra_mobile/modules/general/view/kpi_list.dart';
import 'package:sentra_mobile/modules/general/view/profile.dart';
import 'package:sentra_mobile/routes/app_routes.dart';

class HomeController extends GetxController {
  var tabIndex = 0;
  var session_login = GetStorage();
  var isKadept = "Operator";
  List<Widget> getPage = [];
  List<BottomNavigationBarItem> getItem = [];

  late EmployeeModel loginEmployee = EmployeeModel();

  WoOnProgressRepository woOnProgressRepo = WoOnProgressRepository();
  var dtPause = <WoOnProgressModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    if (session_login.read("login_user") == null) {
      Get.offAllNamed(AppRoute.getLoginRoute());
    }

    loginEmployee = EmployeeModel.fromMap(session_login.read("login_employee"));
    pauseCheck();
    getItemBar();
  }

  getItemBar() {
    if (session_login.read("is_kadept") == true) {
      isKadept = "Kadept";
      tabIndex = 0;
      getPage = [
        DashboardKabag(),
        WoPause(),
        WoHistory(),
        KpiList(),
        Profile(),
      ];

      getItem = [
        _bottomNavigationBarItem(CupertinoIcons.home, "Beranda"),
        _bottomNavigationBarItem(CupertinoIcons.pause, "Pause"),
        _bottomNavigationBarItem(CupertinoIcons.time, "Riwayat"),
        _bottomNavigationBarItem(CupertinoIcons.chart_bar, "KPI"),
        _bottomNavigationBarItem(CupertinoIcons.person, "Profile"),
      ];
    } else {
      tabIndex = 0;
      getPage = [
        DashboardOperator(),
        WoPause(),
        WoHistory(),
        KpiList(),
        Profile(),
      ];

      getItem = [
        _bottomNavigationBarItem(CupertinoIcons.home, "Beranda"),
        _bottomNavigationBarItem(CupertinoIcons.pause, "Pause"),
        _bottomNavigationBarItem(CupertinoIcons.time, "Riwayat"),
        _bottomNavigationBarItem(CupertinoIcons.chart_bar, "KPI"),
        _bottomNavigationBarItem(CupertinoIcons.person, "Profile"),
      ];
    }
  }

  _bottomNavigationBarItem(IconData icon, String label) {
    return BottomNavigationBarItem(
        icon: (label == "Pause" && dtPause.isNotEmpty)
            ? GetBuilder<HomeController>(
                builder: (controller) => Stack(
                  children: <Widget>[
                    Icon(Icons.notifications),
                    Positioned(
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 12,
                          minHeight: 12,
                        ),
                        child: Text(
                          '${dtPause.length}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
              )
            : Icon(icon),
        label: label);
  }

  void changTabIndex(int index) {
    tabIndex = index;
    update();
  }

  pauseCheck() async {
    var dt = await woOnProgressRepo.getDataPause(loginEmployee.id);
    dtPause.value = dt;

    if (dtPause.isNotEmpty) {
      Get.defaultDialog(
        title: "Warning",
        middleText: "Wah ada kerjaan yang di hold nih .. ",
        textCancel: "Nanti",
        textConfirm: "Lihat",
        onConfirm: () {
          tabIndex = 1;
          update();

          Get.back();
        },
      );
    }
  }
}
