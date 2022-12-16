import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sentra_mobile/config/app_theme.dart';
import 'package:sentra_mobile/modules/engineering/controller/handover_controller.dart';
import 'package:sentra_mobile/routes/app_routes.dart';

class Handover extends GetView<HandoverController> {
  final controller = Get.put(HandoverController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        backgroundColor: AppTheme.primaryColor,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fitWidth,
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.1), BlendMode.dstATop),
              image: AssetImage("assets/images/banner-1.png"),
            ),
          ),
        ),
        title: Text(
          "Handover Work Order",
          style: AppTheme.titleLight,
        ),
        elevation: 1,
      ),
      body: Container(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: AppTheme.bgGradient,
                image: DecorationImage(
                  fit: BoxFit.fitHeight,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.3), BlendMode.dstATop),
                  image: const AssetImage("assets/images/banner-1.png"),
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Handover Work Order", style: AppTheme.bigTitleLight),
                    SizedBox(height: 70),
                    QrImage(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue[800],
                      data: "${controller.data.id}|${controller.data.workType}",
                      version: QrVersions.auto,
                      size: 200.0,
                    ),
                    SizedBox(height: 100),
                    Text("Scan untuk takeover WO ${controller.data.workType}",
                        style: AppTheme.titleLight),
                    SizedBox(height: 10),
                    Text("${controller.data.code ?? '-'}",
                        style: AppTheme.titleLight),
                    SizedBox(height: 10),
                    ElevatedButton(
                      style: ButtonStyle(
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(20)),
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
                      child: Text('Kembali'),
                      onPressed: () => Get.offAllNamed(AppRoute.getHomeRoute()),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Lottie.asset(
                'assets/animations/scan-animation.json',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
