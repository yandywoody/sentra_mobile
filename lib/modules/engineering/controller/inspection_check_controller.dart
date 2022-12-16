import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sentra_mobile/model/employee_model.dart';
import 'package:sentra_mobile/model/user_model.dart';
import 'package:sentra_mobile/modules/engineering/model/image_content_model.dart';
import 'package:sentra_mobile/modules/engineering/model/inspection_check.dart';
import 'package:sentra_mobile/modules/engineering/model/inspection_check_realization_model.dart';
import 'package:sentra_mobile/modules/engineering/repositories/image_content_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/inspection_check_realization_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/inspection_check_repository.dart';
import 'package:uuid/uuid.dart';

class InspectionCheckController extends GetxController {
  var data = Get.arguments;

  var dt = <InspectionCheckModel>[].obs;
  var dtMultiChecked = <InspectionCheckModel>[].obs;
  InspectionCheckRepository repo = InspectionCheckRepository();

  List<File> images = [];
  var img = <ImageContentModel>[].obs;
  var imgList = <ImageContentModel>[].obs;
  ImageContentRepository repoImg = ImageContentRepository();

  var dtRealiz = <InspectionCheckRealizationModel>[].obs;
  InspectionCheckRealizationRepository repoRealiz =
      InspectionCheckRealizationRepository();

  var session_login = GetStorage();
  late EmployeeModel loginEmployee = EmployeeModel();
  late UserModel loginuser = UserModel();

  var descEc = <TextEditingController>[].obs;

  var checkChose = "".obs;

  @override
  void onInit() {
    super.onInit();
    loginEmployee = EmployeeModel.fromMap(session_login.read("login_employee"));
    loginuser = UserModel.fromMap(session_login.read("login_user"));

    fetchData();
    allGoodInit();
  }

  @override
  void dispose() {
    fetchData();
    super.dispose();
  }

  Future pickImage(String? id) async {
    try {
      final pickedfiles =
          await ImagePicker().pickImage(source: ImageSource.camera);
      //var pickedfiles = await imgpicker.pickMultiImage();
      if (pickedfiles == null) return;
      images.add(File(pickedfiles.path));

      addImageContent(File(pickedfiles.path), id);
    } on PlatformException catch (e) {}
  }

  addImageContent(File img, String? id) {
    var uuid = Uuid();
    repoImg.add(ImageContentModel(
      id: uuid.v4(),
      name: basename(img.path),
      path: img.path,
      relationalId: id,
      relationalType: data.id,
      createdBy: loginuser.id,
      updatedBy: loginuser.id,
      createdAt: DateTime.now().toString(),
      updatedAt: "",
      deletedAt: "",
    ));

    Get.back();
  }

  changeStatus(int item, var checkdata) {
    checkChose.value = item.toString();
    dt.value.asMap().forEach((index, dtCheck) {
      if (dtCheck.id.contains(checkdata.id)) {
        dt[index].condition = item;
      }
    });

    update();
  }

  simpanData(var checkdata, String desc) {
    var uuid = Uuid();
    var realizId = uuid.v4();
    InspectionCheckRealizationModel inspectionCheckRealizationModel =
        InspectionCheckRealizationModel(
            id: realizId,
            inspectionId: data.id,
            inspectionCheckId: checkdata.id,
            condition: checkdata.condition,
            description: desc,
            createdBy: loginuser.id,
            updatedBy: loginuser.id,
            createdAt: DateTime.now().toString(),
            updatedAt: "",
            deletedAt: "");

    repoRealiz.insertUpdate(inspectionCheckRealizationModel);
    //fetchData();
    update();
  }

  fetchData() async {
    var _dt = await repo.getDataRealization(data.id);
    dt.value = _dt;

    for (int i = 0; i < dt.length; i++) {
      var desc = "";
      if (dt.value[i].description != null) {
        desc = dt.value[i].description ?? '';
      }
      descEc.add(TextEditingController(text: desc));
    }

    checkChose.value = "good";
    update();
  }

  getImage(String? idCheck) async {
    var dt = await repoImg.getDataInspeksiCheck(data.id, idCheck);
    img.value = dt;

    update();
  }

  Future<String> getImageList(String? idCheck) async {
    var dt = await repoImg.getDataInspeksiCheck(data.id, idCheck);
    imgList.value = dt;

    return imgList.length.toString();
  }

  selectChecked(InspectionCheckModel inscheck) {
    var isSelected = dtMultiChecked.contains(inscheck);
    isSelected ? dtMultiChecked.remove(inscheck) : dtMultiChecked.add(inscheck);
  }

  allGoodInit() async {
    if (data.isActive == 1) {
      var _dt = await repo.getDataRealization(data.id);
      dt.value = _dt;

      for (int i = 0; i < dt.length; i++) {
        var uuid = Uuid();
        var realizId = uuid.v4();
        InspectionCheckRealizationModel inspectionCheckRealizationModel =
            InspectionCheckRealizationModel(
                id: realizId,
                inspectionId: data.id,
                inspectionCheckId: dt.value[i].id,
                condition: 1,
                description: "All Good",
                createdBy: loginuser.id,
                updatedBy: loginuser.id,
                createdAt: DateTime.now().toString(),
                updatedAt: "",
                deletedAt: "");

        repoRealiz.insertCheck(inspectionCheckRealizationModel);
        descEc.add(TextEditingController(text: "All Good"));

        checkChose.value = "good";
      }
    }
  }

  allGood() {
    Get.defaultDialog(
      title: "Warning",
      middleText: "Update semua cek inspeksi bagus?",
      textConfirm: "Ok",
      textCancel: "Tidak",
      barrierDismissible: false,
      onConfirm: () async {
        Get.back();

        var _dt = await repo.getDataRealization(data.id);
        dt.value = _dt;

        for (int i = 0; i < dt.length; i++) {
          var uuid = Uuid();
          var realizId = uuid.v4();
          InspectionCheckRealizationModel inspectionCheckRealizationModel =
              InspectionCheckRealizationModel(
                  id: realizId,
                  inspectionId: data.id,
                  inspectionCheckId: dt.value[i].id,
                  condition: 1,
                  description: "All Good",
                  createdBy: loginuser.id,
                  updatedBy: loginuser.id,
                  createdAt: DateTime.now().toString(),
                  updatedAt: "",
                  deletedAt: "");

          repoRealiz.insertUpdate(inspectionCheckRealizationModel);
          descEc.add(TextEditingController(text: "All Good"));

          checkChose.value = "good";
        }

        Get.defaultDialog(
          title: "Succes",
          middleText: "Update semua cek inspeksi berhasil",
          textConfirm: "Ok",
          barrierDismissible: false,
          onConfirm: () {
            Get.back();

            fetchData();
            update();
          },
        );
      },
    );
  }
}
