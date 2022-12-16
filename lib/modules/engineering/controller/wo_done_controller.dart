import 'dart:async';

import 'package:get/get.dart';
import 'package:sentra_mobile/routes/app_routes.dart';

class WoDoneController extends GetxController {
  var data = Get.arguments;

  @override
  void onInit() {
    super.onInit();
    var duration = const Duration(milliseconds: 1500);
    Timer(duration, () {
      if (data.workType == "Inspeksi") {
        Get.offAllNamed(AppRoute.getWoHistoryInspectionDetailRoute(),
            arguments: data);
      } else {
        Get.offAllNamed(AppRoute.getWoHistoryDetailRoute(), arguments: data);
      }
    });
  }
}
