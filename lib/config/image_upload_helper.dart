import 'dart:io';

import 'package:get/get.dart';
import 'package:sentra_mobile/modules/engineering/model/image_content_model.dart';
import 'package:sentra_mobile/modules/engineering/repositories/image_content_repository.dart';
import 'package:sentra_mobile/routes/api_routes.dart';

class ImageUploadHelper extends GetConnect {
  var dtImage = <ImageContentModel>[].obs;
  ImageContentRepository repoImage = ImageContentRepository();

  Future<String> uploadImage() async {
    try {
      var _dtImage = await repoImage.getData();
      dtImage.value = _dtImage;

      final form = FormData({});
      for (ImageContentModel dt in dtImage) {
        form.files.add(MapEntry("file[]",
            MultipartFile(File(dt.path.toString()), filename: "${dt.name}")));
      }

      final response = await post(buildUrl(ApiRoute.submitImage), form);
      if (response.status.hasError) {
        return Future.error(response.body);
      } else {
        return response.body['status'];
      }
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static String buildUrl(String endpoint) {
    //CHANGE THIS FOR HOST API
    String host = ApiRoute().getApiRoute();
    final apiPath = host + endpoint;
    print("call APi ${Uri.parse(apiPath)}");

    return apiPath;
  }
}
