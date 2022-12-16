import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sentra_mobile/config/image_upload_helper.dart';
import 'package:sentra_mobile/config/network_helper.dart';
import 'package:sentra_mobile/model/employee_model.dart';
import 'package:sentra_mobile/modules/engineering/model/good_request_item_model.dart';
import 'package:sentra_mobile/modules/engineering/model/goods_request_model.dart';
import 'package:sentra_mobile/modules/engineering/model/image_content_model.dart';
import 'package:sentra_mobile/modules/engineering/model/inspection_check_realization_model.dart';
import 'package:sentra_mobile/modules/engineering/model/project_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_inspection_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_inspection_realization_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_project_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_project_realization_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_repair_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_repair_realization_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_service_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_service_realization_model.dart';
import 'package:sentra_mobile/modules/engineering/repositories/goods_request_item_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/goods_request_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/image_content_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/inspection_check_realization_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/project_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_inspection_realization_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_inspection_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_project_realization_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_project_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_repair_realization_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_repair_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_service_realization_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_service_repository.dart';
import 'package:sentra_mobile/routes/api_routes.dart';
import 'package:http/http.dart' as http;
import 'package:sentra_mobile/routes/app_routes.dart';

class SubmitDataController extends GetxController {
  final session_login = GetStorage();
  late EmployeeModel loginEmployee = EmployeeModel();

  bool isLoading = false;

  var dtRepairRealiz = <WoRepairRealizationModel>[].obs;
  WoRepairRealizationRepository woRepoRepairRealiz =
      WoRepairRealizationRepository();

  var dtRepair = <WoRepairModel>[].obs;
  WoRepairRepository woRepairRepository = WoRepairRepository();

  var dtServiceRealiz = <WoServiceRealizationModel>[].obs;
  WoServiceRealizationRepository woRepoServiceRealiz =
      WoServiceRealizationRepository();

  var dtService = <WoServiceModel>[].obs;
  WoServiceRepository woServiceRepository = WoServiceRepository();

  var dtProjectRealiz = <WoProjectRealizationModel>[].obs;
  WoProjectRealizationRepository woRepoProjectRealiz =
      WoProjectRealizationRepository();

  var dtProject = <ProjectModel>[].obs;
  ProjectRepository projectRepository = ProjectRepository();

  var dtWoProject = <WoProjectModel>[].obs;
  WoProjectRepository woProjectRepository = WoProjectRepository();

  var dtInspectionRealiz = <WoInspectionRealizationModel>[].obs;
  WoInspectionRealizationRepository woRepoInspectionRealiz =
      WoInspectionRealizationRepository();

  var dtInspection = <WoInspectionModel>[].obs;
  WoInspectionRepository woInspectionRepository = WoInspectionRepository();

  var dtInspectionCheckRealiz = <InspectionCheckRealizationModel>[].obs;
  InspectionCheckRealizationRepository repoInspectionCheckRealiz =
      InspectionCheckRealizationRepository();

  var dtImage = <ImageContentModel>[].obs;
  ImageContentRepository repoImage = ImageContentRepository();

  var dtGr = <GoodsRequestModel>[].obs;
  GoodsRequestRepository repoGr = GoodsRequestRepository();

  var dtGrItem = <GoodRequestItemModel>[].obs;
  GoodsRequestItemRepository repoGrItem = GoodsRequestItemRepository();

  WoRepairRepository woRepoRepair = WoRepairRepository();
  WoServiceRepository woRepoService = WoServiceRepository();
  WoProjectRepository woRepoProject = WoProjectRepository();
  WoInspectionRepository woRepoInspection = WoInspectionRepository();

  var data = {};

  @override
  void onInit() {
    super.onInit();

    loginEmployee = EmployeeModel.fromMap(session_login.read("login_employee"));
    fetchWo();
  }

  fetchWo() async {
    var _dtRepair = await woRepairRepository.getDataManualWo();
    dtRepair.value = _dtRepair;

    var _dtService = await woServiceRepository.getDataManualWo();
    dtService.value = _dtService;

    var dt = await woRepoRepairRealiz.getDataByEmp(loginEmployee.id);
    dtRepairRealiz.value = dt;

    var dt2 = await woRepoServiceRealiz.getDataByEmp(loginEmployee.id);
    dtServiceRealiz.value = dt2;

    var dt3 = await woRepoProjectRealiz.getDataByEmp(loginEmployee.id);
    dtProjectRealiz.value = dt3;

    var dt4 = await woRepoInspectionRealiz.getDataByEmp(loginEmployee.id);
    dtInspectionRealiz.value = dt4;

    var dtInspekCheck = await repoInspectionCheckRealiz.getData();
    dtInspectionCheckRealiz.value = dtInspekCheck;

    var _dtImage = await repoImage.getData();
    dtImage.value = _dtImage;

    var _dtGr = await repoGr.getData();
    dtGr.value = _dtGr;

    var _dtGrItem = await repoGrItem.getData();
    dtGrItem.value = _dtGrItem;

    var totalRealiz = dtRepairRealiz.length +
        dtServiceRealiz.length +
        dtProjectRealiz.length +
        dtInspectionRealiz.length;

    if (totalRealiz == 0) {
      Get.defaultDialog(
        title: "Warning",
        middleText: "Tidak ada history wo,tetap delete data?",
        textConfirm: "Delete Data",
        textCancel: "Batal",
        onCancel: () => Get.offAllNamed(AppRoute.getHomeRoute()),
        onConfirm: () async {
          woRepairRepository.turncateTable();
          woServiceRepository.turncateTable();
          projectRepository.turncateTable();
          woProjectRepository.turncateTable();
          woInspectionRepository.turncateTable();
          repoGr.turncateTable();
          repoGrItem.turncateTable();

          Get.defaultDialog(
            title: "Success",
            middleText: "Data terhapus,",
            textConfirm: "Ok",
            onConfirm: () => Get.offAllNamed(AppRoute.getHomeRoute()),
          );
        },
      );
    } else {
      try {
        data['repair'] = dtRepairRealiz.value.toList();
        data['repair_manual'] = dtRepair.value.toList();
        data['service'] = dtServiceRealiz.value.toList();
        data['service_manual'] = dtService.value.toList();
        data['project'] = dtProjectRealiz.value.toList();
        data['inspection'] = dtInspectionRealiz.value.toList();
        data['inspection_check'] = dtInspectionCheckRealiz.value.toList();
        data['images'] = dtImage.value.toList();
        data['gr'] = dtGr.value.toList();
        data['gritem'] = dtGrItem.value.toList();

        var response = await NetwrokHelper.post(
          json.encode(
            data,
          ),
          ApiRoute.submitData.toString(),
        );

        var res = json.decode(response);
        print(res);
        if (res['status'] == "success") {
          for (var i = 0; i < dtRepairRealiz.length; i++) {
            woRepoRepair.delete(dtRepairRealiz[i].repairId);
          }
          woRepoRepairRealiz.turncateTable();

          for (var i = 0; i < dtServiceRealiz.length; i++) {
            woRepoService.delete(dtServiceRealiz[i].serviceId);
          }
          woRepoServiceRealiz.turncateTable();

          for (var i = 0; i < dtInspectionRealiz.length; i++) {
            woRepoInspection.delete(dtInspectionRealiz[i].inspectionId);
          }
          woRepoInspectionRealiz.turncateTable();

          submitImage();
        } else {
          Get.defaultDialog(
              title: "Failed",
              middleText: "Submit data gagal. Terjadi kesalahan di server",
              textConfirm: "Ok",
              onConfirm: () {
                Get.offAllNamed(AppRoute.getHomeRoute());
              });
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }

  submitImage() {
    ImageUploadHelper().uploadImage().then((resp) {
      if (resp == "success") {
        woRepairRepository.turncateTable();
        woServiceRepository.turncateTable();
        projectRepository.turncateTable();
        woProjectRepository.turncateTable();
        woInspectionRepository.turncateTable();
        repoGr.turncateTable();
        repoGrItem.turncateTable();
        repoImage.turncateTable();
        imageCache.clear();

        Get.defaultDialog(
            title: "Success",
            middleText: "Submit data berhasil ..",
            textConfirm: "Ok",
            onConfirm: () {
              Get.offAllNamed(AppRoute.getHomeRoute());
            });
      }
    }).onError((error, stackTrace) {
      print(error);
    });
  }
}
