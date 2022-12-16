import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sentra_mobile/model/user_model.dart';
import 'package:sentra_mobile/modules/engineering/model/activity_model.dart';
import 'package:sentra_mobile/modules/engineering/model/goods_request_model.dart';
import 'package:sentra_mobile/modules/engineering/model/image_content_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_all_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_inspection_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_project_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_repair_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_service_model.dart';
import 'package:sentra_mobile/modules/engineering/repositories/activity_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/goods_request_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/image_content_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_inspection_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_project_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_repair_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_service_repository.dart';
import 'package:sentra_mobile/routes/app_routes.dart';
import 'package:uuid/uuid.dart';

class WoHistoryDetailController extends GetxController {
  var data = Get.arguments;
  List<File> images = [];
  var imgContent = <ImageContentModel>[].obs;
  var dtGoodRequest = <GoodsRequestModel>[].obs;

  var session_login = GetStorage();
  late UserModel loginuser = UserModel();

  var isGoodReceived = false.obs;
  var isHistory = 0.obs;

  GoodsRequestRepository goodsRequestRepository = GoodsRequestRepository();

  var dtActivity = ActivityModel().obs;
  ImageContentRepository imgRepo = ImageContentRepository();
  ActivityRepository activityRepo = ActivityRepository();

  var dtWoService = <WoServiceModel>[].obs;
  WoServiceRepository woRepoService = WoServiceRepository();

  var dtWoProject = <WoProjectModel>[].obs;
  WoProjectRepository woRepoProject = WoProjectRepository();

  var dtWoRepair = <WoRepairModel>[].obs;
  WoRepairRepository woRepoRepair = WoRepairRepository();

  var dtWoInspeksi = <WoInspectionModel>[].obs;
  WoInspectionRepository woRepoInspeksi = WoInspectionRepository();

  var woPlan = WoAllModel().obs;

  @override
  void onInit() {
    super.onInit();

    loginuser = UserModel.fromMap(session_login.read("login_user"));
    isHistory.value = session_login.read("is_history");
    getImageContent();
    getGoodsRequest();
    fetchData();
  }

  Future pickImage() async {
    try {
      final pickedfiles =
          await ImagePicker().pickImage(source: ImageSource.camera);
      //var pickedfiles = await imgpicker.pickMultiImage();
      if (pickedfiles == null) return;
      images.add(File(pickedfiles.path));

      addImageContent(File(pickedfiles.path));
    } on PlatformException catch (e) {}
  }

  getGoodsRequest() async {
    print("cek");
    String woId = data.relationableId;
    isGoodReceived.value = true;
    var dt = goodsRequestRepository.getDataByWo(woId);
    dtGoodRequest.value = await dt;

    if (dtGoodRequest.length > 0) {
      for (int i = 0; i < dtGoodRequest.length; i++) {
        print(isGoodReceived.value);
        if (dtGoodRequest[i].goodsTaker != "1") {
          isGoodReceived.value = false;
          var result = await Get.toNamed(AppRoute.getUpdateBarangRoute(),
              arguments: data);

          getImageContent();
          getGoodsRequest();
        }
      }
    }
  }

  addImageContent(File img) {
    var uuid = Uuid();
    imgRepo.add(ImageContentModel(
      id: uuid.v4(),
      name: basename(img.path),
      path: img.path,
      relationalId: data.relationableId,
      relationalType: data.workType,
      createdBy: loginuser.id,
      updatedBy: loginuser.id,
      createdAt: DateTime.now().toString(),
      updatedAt: DateTime.now().toString(),
      deletedAt: "",
    ));

    getImageContent();
  }

  getActivityByWo() async {
    var dt = activityRepo.getDataByWo(data.activityCode.toString());
    dtActivity.value = await dt;
  }

  getImageContent() async {
    var dt = imgRepo.getDataWoId(data.relationableId);
    imgContent.value = await dt;

    update();
  }

  fetchData() async {
    if (data.workType == "Repair") {
      var dt = await woRepoRepair.getDataById(data.relationableId);
      woPlan.value = WoAllModel(
        id: dt.id,
        relationableType: dt.id,
        relationableId: "Repair",
        code: dt.code,
        groupCode: dt.groupCode,
        machineCode: dt.machineCode,
        activityCode: dt.activityCode,
        inspectionId: dt.inspectionId,
        executedAt: dt.executedAt,
        startAt: dt.startAt,
        finishAt: dt.finishAt,
        duration: dt.duration,
        durationRealization: dt.durationRealization,
        score: dt.score,
        point: dt.point,
        description: dt.description,
        needElectrician: dt.needElectrician,
        type: dt.type,
        isActive: dt.isActive,
        isFinish: dt.isFinish,
        isOvertime: dt.isOvertime,
        approved: dt.approved,
        isAdminNote: dt.isAdminNote,
        adminNote: dt.adminNote,
        isSuitable: dt.isSuitable,
        createdBy: dt.createdBy,
        updatedBy: dt.updatedBy,
        createdAt: dt.createdAt,
        updatedAt: dt.updatedAt,
        deletedAt: dt.deletedAt,
        workType: dt.workType,
      );
    } else if (data.workType == "Service") {
      var dt = await woRepoService.getDataById(data.relationableId);
      woPlan.value = WoAllModel(
        id: dt.id,
        relationableType: dt.id,
        relationableId: "Service",
        code: dt.code,
        groupCode: dt.groupCode,
        machineCode: dt.machineCode,
        activityCode: dt.activityCode,
        inspectionId: 0,
        executedAt: dt.executedAt,
        startAt: dt.startAt,
        finishAt: dt.finishAt,
        duration: dt.duration,
        durationRealization: dt.durationRealization,
        score: dt.score,
        point: dt.point,
        description: dt.description,
        needElectrician: dt.needElectrician,
        type: dt.type,
        isActive: dt.isActive,
        isFinish: dt.isFinish,
        isOvertime: dt.isOvertime,
        approved: 0,
        isAdminNote: dt.isAdminNote,
        adminNote: dt.adminNote,
        isSuitable: dt.isSuitable,
        createdBy: dt.createdBy,
        updatedBy: dt.updatedBy,
        createdAt: dt.createdAt,
        updatedAt: dt.updatedAt,
        deletedAt: dt.deletedAt,
        workType: dt.workType,
      );
    } else if (data.workType == "Project") {
      var dt = await woRepoProject.getDataById(data.relationableId);
      woPlan.value = WoAllModel(
        id: dt.id,
        relationableType: dt.id,
        relationableId: "Project",
        code: dt.code,
        groupCode: "0",
        machineCode: "0",
        activityCode: dt.activityCode,
        inspectionId: 0,
        executedAt: dt.executedAt,
        startAt: dt.startAt,
        finishAt: dt.finishAt,
        duration: dt.duration,
        durationRealization: dt.durationRealization,
        score: dt.score,
        point: dt.point,
        description: "",
        needElectrician: 0,
        type: 0,
        isActive: dt.isActive,
        isFinish: 0,
        isOvertime: 0,
        approved: 0,
        isAdminNote: dt.isAdminNote,
        adminNote: dt.adminNote,
        isSuitable: dt.isSuitable,
        createdBy: dt.createdBy,
        updatedBy: dt.updatedBy,
        createdAt: dt.createdAt,
        updatedAt: dt.updatedAt,
        deletedAt: dt.deletedAt,
        workType: dt.workType,
      );
    } else if (data.workType == "Inspeksi") {
      var dt = await woRepoInspeksi.getDataById(data.relationableId);
      woPlan.value = WoAllModel(
        id: dt.id,
        relationableType: dt.id,
        relationableId: "Inspection",
        code: dt.code,
        groupCode: "0",
        machineCode: "0",
        activityCode: "",
        inspectionId: 0,
        executedAt: dt.executedAt,
        startAt: "00:00:00",
        finishAt: "00:00:00",
        duration: dt.duration,
        durationRealization: dt.durationRealization,
        score: dt.score,
        point: dt.point,
        description: "",
        needElectrician: 0,
        type: 0,
        isActive: dt.isActive,
        isFinish: 0,
        isOvertime: 0,
        approved: 0,
        isAdminNote: dt.isAdminNote,
        adminNote: dt.adminNote,
        isSuitable: dt.isSuitable,
        createdBy: dt.createdBy,
        updatedBy: dt.updatedBy,
        createdAt: dt.createdAt,
        updatedAt: dt.updatedAt,
        deletedAt: dt.deletedAt,
        workType: dt.workType,
      );
    }
  }
}
