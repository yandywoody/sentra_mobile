import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sentra_mobile/model/employee_model.dart';
import 'package:sentra_mobile/model/user_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_onprogres_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_service_model.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_onprogress_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_service_repository.dart';
import 'package:sentra_mobile/routes/app_routes.dart';

class WoServiceController extends GetxController {
  var dtWo = <WoServiceModel>[].obs;
  WoServiceRepository woRepo = WoServiceRepository();
  var session_login = GetStorage();
  late EmployeeModel loginEmployee = EmployeeModel();
  late UserModel loginuser = UserModel();

  var dtOnProgress = <WoOnProgressModel>[].obs;
  WoOnProgressRepository woOnProgressRepo = WoOnProgressRepository();

  @override
  void onInit() {
    super.onInit();

    loginEmployee = EmployeeModel.fromMap(session_login.read("login_employee"));
    loginuser = UserModel.fromMap(session_login.read("login_user"));

    fetchWo();
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
          WoServiceModel dtRepairSend =
              await woRepo.getDataById(dtOnProgress[0].woId);

          var result = await Get.toNamed(AppRoute.getWoServiceDetailRoute(),
              arguments: dtRepairSend);

          getWoOnprogress();
        },
      );
    }
  }

  fetchWo() async {
    var dt = await woRepo.getDataByEmp(loginEmployee.id);
    dtWo.value = dt;
  }

  woDetail(WoServiceModel dt) async {
    var result =
        await Get.toNamed(AppRoute.getWoServiceDetailRoute(), arguments: dt);

    getWoOnprogress();
  }
}
