import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sentra_mobile/config/app_theme.dart';
import 'package:sentra_mobile/modules/engineering/controller/wo_done_controller.dart';

class WoDone extends GetView<WoDoneController> {
  WoDone({Key? key}) : super(key: key);
  @override
  final controller = Get.put(WoDoneController());

  @override
  Widget build(BuildContext context) {
    double maxValue = 15;
    double width = 300;

    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/animations/done-animation.json'),
            SizedBox(
              height: 30.0,
            ),
            Text(
              "Pekerjaan mu telah selesai",
              style: AppTheme.bigSubTitleLight,
            ),
          ],
        ),
      ),
    );
  }
}
