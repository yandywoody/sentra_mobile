import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sentra_mobile/config/app_theme.dart';
import 'package:sentra_mobile/modules/engineering/controller/takeover_controller.dart';

class Takeover extends GetView<TakeoverController> {
  final controller = Get.put(TakeoverController());

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
          "Takeover Work Order",
          style: AppTheme.titleLight,
        ),
        elevation: 1,
        leading: IconButton(
          onPressed: () => Get.back(result: ""),
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppTheme.bgColorLight,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: AppTheme.bgGradient,
          ),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 50),
                Lottie.asset(
                  'assets/animations/scan-qr-animation.json',
                ),
                SizedBox(height: 100),
                Text("Siapkan qr wo yang akan di scan \nuntuk ditakeover.",
                    style: AppTheme.bigSubTitleLight),
                SizedBox(height: 50),
                Container(
                  width: Get.width * 0.6,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.warningColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12), // <-- Radius
                        ),
                      ),
                      onPressed: () => controller.scanBarcode(),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Scan", style: AppTheme.bigTitleLight),
                            SizedBox(width: 5),
                            Icon(Icons.qr_code_scanner),
                          ],
                        ),
                      )),
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
