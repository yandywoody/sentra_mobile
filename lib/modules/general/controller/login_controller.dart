import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sentra_mobile/modules/general/model/login_model.dart';
import 'package:sentra_mobile/repositories/user_repository.dart';
import 'package:sentra_mobile/routes/app_routes.dart';

class LoginController extends GetxController {
  TextEditingController userEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  UserRepository repo = UserRepository();

  var passwordIsVisible = false.obs;

  var x = GetStorage();

  final isPlay = false.obs;
  double opacity = 1.0;

  void toggleAnimation() {
    isPlay(!isPlay.value);
    opacity = isPlay.value == false ? 1.0 : 0.0;
    login();
  }

  visiblePassword() {
    passwordIsVisible.value = !passwordIsVisible.value;
    update();
  }

  void login() async {
    //x.erase();
    LoginModel loginModel = LoginModel(
        name: userEditingController.text,
        password: passwordEditingController.text);
    try {
      if (await repo.login(loginModel)) {
        isPlay(!isPlay.value);
        opacity = isPlay.value == false ? 1.0 : 0.0;

        Get.defaultDialog(
          title: "Success",
          middleText: "Success Login",
          textConfirm: "Ok",
          barrierDismissible: false,
          onConfirm: () {
            Get.offAllNamed(AppRoute.getHomeRoute());
          },
        );
      } else {
        Get.defaultDialog(
            title: "Warning",
            middleText: "User atau Password Salah",
            textCancel: "Ok");
      }
    } catch (e) {
      Get.defaultDialog(
          title: "Warning",
          middleText: "User atau Password Salah",
          textCancel: "Ok");
    }

    isPlay(!isPlay.value);
    opacity = isPlay.value == false ? 1.0 : 0.0;
  }
}
