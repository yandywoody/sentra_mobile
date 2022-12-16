import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sentra_mobile/config/app_theme.dart';
import 'package:sentra_mobile/modules/general/controller/profile_controller.dart';
import 'package:sentra_mobile/routes/app_routes.dart';

class Profile extends GetView<ProfileController> {
  Profile({Key? key}) : super(key: key);
  final controller = Get.put(ProfileController());

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
          "Setting",
          style: AppTheme.titleLight,
        ),
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(32, 25, 32, 0),
          decoration: BoxDecoration(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Center(
                    child: Container(
                      width: 130,
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 4,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1),
                            offset: Offset(0, 19),
                          ),
                        ],
                        shape: BoxShape.circle,
                      ),
                      child: Lottie.asset(
                          'assets/animations/avatar-animation.json'),
                    ),
                  ),
                  Positioned(
                    top: 100,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          color: Colors.grey[400],
                          padding: EdgeInsets.all(5),
                          child: Text(
                            "${controller.loginEmployee.name}",
                            style: AppTheme.text14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 55),
              InkWell(
                onTap: () => Get.toNamed(AppRoute.getKpiDetailRoute()),
                child: Container(
                  color: Colors.transparent,
                  width: Get.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Key Performance Indicator",
                            style: AppTheme.text14,
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text(
                        "KPI pegawai ",
                        style: AppTheme.text10opc50,
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(thickness: 0.5, color: AppTheme.primaryColor),
              InkWell(
                onTap: () => Get.toNamed(AppRoute.getWoAllRoute()),
                child: Container(
                  color: Colors.transparent,
                  width: Get.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Semua WO",
                            style: AppTheme.text14,
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Daftar semua Wo hari ini ",
                        style: AppTheme.text10opc50,
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(thickness: 0.5, color: AppTheme.primaryColor),
              InkWell(
                onTap: () => Get.toNamed(AppRoute.getTakeoverRoute()),
                child: Container(
                  color: Colors.transparent,
                  width: Get.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Takeover",
                            style: AppTheme.text14,
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Mengerjakan WO orang lain ",
                        style: AppTheme.text10opc50,
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(thickness: 0.5, color: AppTheme.primaryColor),
              InkWell(
                onTap: () => Get.toNamed(AppRoute.getWoHistoryRoute()),
                child: Container(
                  color: Colors.transparent,
                  width: Get.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Riwayat",
                            style: AppTheme.text14,
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Riwayat WO yang telah dikerjakan ",
                        style: AppTheme.text10opc50,
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(thickness: 0.5, color: AppTheme.primaryColor),
              SizedBox(height: 50),
              Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(10)),
                    minimumSize: MaterialStateProperty.all(
                      Size(Get.width * 0.3, 40),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.grey[600]),
                  ),
                  child: Text('Logout'),
                  onPressed: () => controller.logout(),
                ),
              ),
              SizedBox(height: 55),
            ],
          ),
        ),
      ),
    );
  }
}
