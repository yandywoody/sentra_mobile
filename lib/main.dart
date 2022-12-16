import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sentra_mobile/routes/app_routes.dart';

void main() async {
  await GetStorage.init();
  final sessionlogin = GetStorage();
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: (sessionlogin.read("login_name") == null)
        ? AppRoute.getSplashRoute()
        : AppRoute.getHomeRoute(),
    getPages: AppRoute.routes,
  ));
}
