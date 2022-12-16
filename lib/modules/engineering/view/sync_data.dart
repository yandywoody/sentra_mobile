import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sentra_mobile/config/app_theme.dart';
import 'package:sentra_mobile/modules/engineering/controller/sync_data_controller.dart';
import 'package:sentra_mobile/routes/app_routes.dart';

class SyncData extends GetView<SyncDataController> {
  SyncData({Key? key}) : super(key: key);
  @override
  final controller = Get.put(SyncDataController());

  @override
  Widget build(BuildContext context) {
    double maxValue = 19;
    double width = 300;

    return Scaffold(
      body: Obx(
        () => Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppTheme.primaryColor,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/animations/transfer-files-animation.json'),
                GetBuilder<SyncDataController>(
                  builder: (controller) => controller.isLoading
                      ? CircularProgressIndicator()
                      : Stack(
                          children: [
                            Container(
                              width: width,
                              height: 20,
                              decoration: BoxDecoration(
                                color: Colors.white60,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            Material(
                              elevation: 5,
                              borderRadius: BorderRadius.circular(20),
                              child: AnimatedContainer(
                                width:
                                    width * (controller.valProgress / maxValue),
                                height: 20,
                                duration: Duration(milliseconds: 500),
                                decoration: BoxDecoration(
                                  color: ((controller.valProgress / maxValue) <
                                          0.3)
                                      ? AppTheme.dangerColor
                                      : ((controller.valProgress / maxValue) <
                                              0.6)
                                          ? AppTheme.warningColor
                                          : AppTheme.succesColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Text(
                  controller.statusProgress.value,
                  style: AppTheme.titleLight,
                ),
                SizedBox(height: 30),
                (controller.session_login.read("sync_dayly") == 2)
                    ? ElevatedButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(20)),
                          minimumSize: MaterialStateProperty.all(
                            Size(Get.width * 0.3, 40),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey[600]),
                        ),
                        child: Text('Batal'),
                        onPressed: () =>
                            Get.offAndToNamed(AppRoute.getHomeRoute()),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
