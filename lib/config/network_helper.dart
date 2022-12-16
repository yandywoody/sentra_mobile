import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:sentra_mobile/modules/engineering/model/image_content_model.dart';
import 'package:sentra_mobile/modules/engineering/repositories/image_content_repository.dart';
import 'package:sentra_mobile/routes/api_routes.dart';
import 'package:sentra_mobile/routes/app_routes.dart';

class NetwrokHelper {
  static final client = http.Client();
  static final storage = GetStorage();

  var dtImage = <ImageContentModel>[].obs;
  ImageContentRepository repoImage = ImageContentRepository();

  static Future<String> get(String endpoint) async {
    var strResponse = "";

    try {
      var response = await client.get(
        buildUrl(endpoint),
        headers: {
          'Content-type': 'application/json;charset=UTF-8',
          'Accept': 'application/json',
        },
      ).timeout(
        Duration(seconds: 240),
      );

      if (response == null) {
        strResponse = "error_time_out";
      } else {
        strResponse = response.body;
      }
    } catch (e) {
      strResponse = "";
    }

    return strResponse;
  }

  static Future<String> post(var body, String endpoint) async {
    var response;
    try {
      response = await client.post(
        buildUrl(endpoint),
        body: body,
        headers: {
          'Content-type': 'application/json;charset=UTF-8',
          'Accept': 'application/json',
        },
      );
    } catch (e) {
      Get.defaultDialog(
          title: "Warning", middleText: e.toString(), textCancel: "Ok");
    }

    return response.body;
  }

  static Uri buildUrl(String endpoint) {
    //CHANGE THIS FOR HOST API
    String host = ApiRoute().getApiRoute();
    final apiPath = host + endpoint;
    print("call APi ${Uri.parse(apiPath)}");

    return Uri.parse(apiPath);
  }

  static void storeToken(String token) async {
    await storage.write("token", token);
  }

  static Future<String> getToken(String token) async {
    return await storage.read("token");
  }
}
