import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:sentra_mobile/model/employee_model.dart';
import 'package:sentra_mobile/model/user_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_project_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_repair_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_service_model.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_project_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_repair_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_service_repository.dart';
import 'package:sentra_mobile/routes/app_routes.dart';

class TakeoverController extends GetxController {
  var dtWoService = <WoServiceModel>[].obs;
  WoServiceRepository woRepoService = WoServiceRepository();

  var dtWoProject = <WoProjectModel>[].obs;
  WoProjectRepository woRepoProject = WoProjectRepository();

  var dtWoRepair = <WoRepairModel>[].obs;
  WoRepairRepository woRepoRepair = WoRepairRepository();

  var session_login = GetStorage();
  late EmployeeModel loginEmployee = EmployeeModel();
  late UserModel loginuser = UserModel();

  @override
  void onInit() {
    super.onInit();

    loginEmployee = EmployeeModel.fromMap(session_login.read("login_employee"));
    loginuser = UserModel.fromMap(session_login.read("login_user"));
  }

  woDetailRepair(WoRepairModel dt) {
    Get.toNamed(AppRoute.getWoRepairDetailRoute(), arguments: dt);
  }

  woDetailService(WoServiceModel dt) {
    Get.toNamed(AppRoute.getWoServiceDetailRoute(), arguments: dt);
  }

  woDetailProject(WoProjectModel dt) {
    Get.toNamed(AppRoute.getWoProjectDetailRoute(), arguments: dt);
  }

  scanBarcode() {
    Get.defaultDialog(
      title: "Info",
      middleText: "Scan qrcode wo?",
      textCancel: "Batal",
      textConfirm: "Mulai",
      onConfirm: () async {
        Get.back();

        var notFoundData = false;

        Map<Permission, PermissionStatus> statuses = await [
          Permission.camera,
          Permission.storage,
        ].request();

        if (statuses[Permission.camera] == PermissionStatus.granted) {
          var resultData = (await scanner.scan())!;
          var str = resultData.split("|");

          if (str[1] == "Service") {
            var dt = await woRepoService.getDataById(str[0]);
            if (dt.id != null) {
              woDetailService(dt);
            } else {
              notFoundData = true;
            }
          } else if (str[1] == "Repair") {
            var dt2 = await woRepoRepair.getDataById(str[0]);
            if (dt2.code != null) {
              woDetailRepair(dt2);
            } else {
              notFoundData = true;
            }
          } else if (str[1] == "Project") {
            var dt3 = await woRepoProject.getDataById(str[0]);
            if (dt3.id != null) {
              woDetailProject(dt3);
            } else {
              notFoundData = true;
            }
          } else {
            Get.defaultDialog(
              title: "Warning",
              middleText:
                  "Ops, Tidak ada data yang di scan di hp ini. coba update data ke pos.",
              textConfirm: "Ok",
              onConfirm: () {
                Get.back();
              },
            );
          }
        }

        if (notFoundData) {
          Get.defaultDialog(
            title: "Warning",
            middleText:
                "Ops, Tidak ada data yang di scan di hp ini. coba update data ke pos.",
            textConfirm: "Ok",
            onConfirm: () {
              Get.back();
            },
          );
        }
      },
    );
  }
}
