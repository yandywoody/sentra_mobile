import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sentra_mobile/config/app_theme.dart';
import 'package:sentra_mobile/modules/engineering/controller/submit_data_controller.dart';
import 'package:sentra_mobile/modules/engineering/controller/sync_data_controller.dart';
import 'package:sentra_mobile/routes/app_routes.dart';

class SubmitData extends GetView<SubmitDataController> {
  SubmitData({Key? key}) : super(key: key);
  @override
  final controller = Get.put(SubmitDataController());

  @override
  Widget build(BuildContext context) {
    double maxValue = 19;
    double width = 300;

    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        padding: EdgeInsets.fromLTRB(16, 25, 16, 0),
        decoration: BoxDecoration(
          color: Colors.blue[800],
          // image: DecorationImage(
          //   fit: BoxFit.fitHeight,
          //   colorFilter: ColorFilter.mode(
          //       Colors.white.withOpacity(0.2), BlendMode.dstATop),
          //   image: const AssetImage("assets/images/banner-1.png"),
          // ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/animations/upload-data-animation.json',
                  fit: BoxFit.fill),
              SizedBox(
                height: 30.0,
              ),
              CircularProgressIndicator(
                color: Colors.orange,
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ElevatedButton(
                  //   style: ButtonStyle(
                  //     padding:
                  //         MaterialStateProperty.all(const EdgeInsets.all(20)),
                  //     minimumSize: MaterialStateProperty.all(
                  //       Size(Get.width * 0.3, 40),
                  //     ),
                  //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  //       RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(12.0),
                  //       ),
                  //     ),
                  //     backgroundColor:
                  //         MaterialStateProperty.all(Colors.grey[600]),
                  //   ),
                  //   child: Text('Hit Again'),
                  //   onPressed: () => controller.fetchWo(),
                  // ),
                  // SizedBox(width: 10),
                  ElevatedButton(
                    style: ButtonStyle(
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(20)),
                      minimumSize: MaterialStateProperty.all(
                        Size(Get.width * 0.3, 40),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.grey[600]),
                    ),
                    child: Text('Batal'),
                    onPressed: () => Get.offAndToNamed(AppRoute.getHomeRoute()),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
