import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sentra_mobile/config/app_theme.dart';
import 'package:sentra_mobile/controller/home_controller.dart';

class Home extends GetView<HomeController> {
  Home({Key? key}) : super(key: key);

  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Scaffold(
          body: DoubleBackToCloseApp(
            snackBar: SnackBar(
              content: Text("Tap again to exit app"),
            ),
            child: SafeArea(
                child: IndexedStack(
              index: controller.tabIndex,
              children: controller.getPage,
            )),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: controller.getItem,
            currentIndex: controller.tabIndex,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            onTap: controller.changTabIndex,
            elevation: 2,
          ),
        );
      },
    );
  }
}
