import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sentra_mobile/model/employee_model.dart';
import 'package:sentra_mobile/model/user_model.dart';
import 'package:sentra_mobile/routes/app_routes.dart';

class ProfileController extends GetxController {
  final session_login = GetStorage();
  late EmployeeModel loginEmployee = EmployeeModel();
  late UserModel loginuser = UserModel();

  @override
  void onInit() {
    super.onInit();

    loginEmployee = EmployeeModel.fromMap(session_login.read("login_employee"));
    loginuser = UserModel.fromMap(session_login.read("login_user"));
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
        Get.offAllNamed(AppRoute.getLoginRoute());
      },
      onCancel: () {},
    );
  }
}
