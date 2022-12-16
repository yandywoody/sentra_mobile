import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sentra_mobile/routes/app_routes.dart';

class SplashController extends GetxController {
  final sessionlogin = GetStorage();

  @override
  Future<void> onInit() async {
    super.onInit();
    var duration = const Duration(seconds: 3);
    if (await checkDbFile()) {
      Timer(duration, () {
        if (sessionlogin.read("login_name") != null) {
          Get.offAllNamed(AppRoute.getHomeRoute());
        } else {
          Get.offAllNamed(AppRoute.getLoginRoute());
        }
      });
    } else {
      Get.offAllNamed(AppRoute.getSyncDataRoute());
    }
  }

  Future<bool> checkDbFile() async {
    io.Directory? documentDirectory = await getExternalStorageDirectory();
    String path = join(documentDirectory!.path, 'sentra_dev_0009227.db');
    var syncPath = path;
    //io.File(syncPath).existsSync();
    return await io.File(syncPath).exists();
  }
}
