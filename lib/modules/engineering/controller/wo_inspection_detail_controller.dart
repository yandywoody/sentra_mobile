import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sentra_mobile/model/user_model.dart';
import 'package:sentra_mobile/modules/engineering/model/image_content_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_all_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_all_realization_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_inspection_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_inspection_realization_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_onprogres_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_project_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_repair_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_service_model.dart';
import 'package:sentra_mobile/modules/engineering/repositories/image_content_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_inspection_realization_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_inspection_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_onprogress_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_project_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_repair_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_service_repository.dart';
import 'package:sentra_mobile/routes/app_routes.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:uuid/uuid.dart';

class WoInspectionDetailController extends GetxController {
  WoInspectionModel data = Get.arguments;

  var woInspec = <WoInspectionModel>[].obs;
  WoInspectionRepository woInspectionRepo = WoInspectionRepository();
  WoInspectionRealizationRepository woRealizRepo =
      WoInspectionRealizationRepository();

  var imgContent = <ImageContentModel>[].obs;
  ImageContentRepository imgRepo = ImageContentRepository();
  List<File> images = [];

  var startTimesecond = 0;
  var addSeconds = 1.obs;
  var hours = "".obs;
  var minutes = "".obs;
  var seconds = "".obs;

  var timeStart = "".obs;
  var timeStop = "".obs;
  var timeDuration = "0".obs;
  var isStart = false.obs;
  var woType = "";

  var statusWo = "".obs;

  var dtOnProgress = <WoOnProgressModel>[].obs;
  WoOnProgressRepository woOnProgressRepo = WoOnProgressRepository();

  var dtWoRepair = WoRepairModel().obs;
  WoRepairRepository woRepoRepair = WoRepairRepository();
  var dtWoService = WoServiceModel().obs;
  WoServiceRepository woRepoService = WoServiceRepository();
  var dtWoProject = WoProjectModel().obs;
  WoProjectRepository woRepoProject = WoProjectRepository();

  WoInspectionRepository repo = WoInspectionRepository();

  var session_login = GetStorage();
  late UserModel loginuser = UserModel();
  late WoAllRealizationModel dtWoAll = WoAllRealizationModel();

  DateTime datetimeStart = DateTime.now();
  DateTime datetimeStop = DateTime.now();
  Duration duration = Duration();
  Timer? timer;

  var dtWo = WoAllModel().obs;

  get imageseDe => null;

  @override
  void onInit() {
    super.onInit();
    loginuser = UserModel.fromMap(session_login.read("login_user"));
    woType = data.relationableType.toString().split("\\")[3];
    getWoOnprogres();
    //getDataWo();
  }

  getDataWo() async {
    if (woType == "Repair") {
      var _dt = await woRepoRepair.getDataById(data.relationableId);
      dtWoRepair.value = _dt;
      dtWo.value = WoAllModel(
        id: dtWoRepair.value.id,
        activityCode: dtWoRepair.value.activityCode,
        machineCode: dtWoRepair.value.machineCode,
        startAt: dtWoRepair.value.startAt,
        finishAt: dtWoRepair.value.finishAt,
        score: dtWoRepair.value.score,
        description: dtWoRepair.value.description,
        duration: dtWoRepair.value.duration,
        workType: "Repair",
      );
    } else if (woType == "Service") {
      var _dt = await woRepoService.getDataById(data.relationableId);
      dtWoService.value = _dt;
      dtWo.value = WoAllModel(
        id: dtWoService.value.id,
        activityCode: dtWoService.value.activityCode,
        machineCode: dtWoService.value.machineCode,
        startAt: dtWoService.value.startAt,
        finishAt: dtWoService.value.finishAt,
        score: dtWoService.value.score,
        description: dtWoService.value.description,
        duration: dtWoService.value.duration,
        workType: "Service",
      );
    } else {
      var _dt = await woRepoProject.getDataById(data.relationableId);
      dtWoProject.value = _dt;
      dtWo.value = WoAllModel(
        id: dtWoProject.value.id,
        activityCode: "-",
        machineCode: "-",
        startAt: dtWoProject.value.startAt,
        finishAt: dtWoProject.value.finishAt,
        score: dtWoProject.value.score,
        description: "",
        duration: dtWoProject.value.duration,
        workType: "Project",
      );
    }
  }

  var statusType = "good".obs;
  void setStatusType(String type) {
    statusType.value = type;
    update();
  }

  String toDigit(int n) => n.toString().padLeft(2, '0');
  addTime() {
    final second = startTimesecond + duration.inSeconds + addSeconds.value;
    startTimesecond = 0;
    duration = Duration(seconds: second);

    hours.value = toDigit(duration.inHours.remainder(60));
    minutes.value = toDigit(duration.inMinutes.remainder(60));
    seconds.value = toDigit(duration.inSeconds.remainder(60));
  }

  checkWoOnprogres() async {
    WoOnProgressRepository woOnProgressRepo = WoOnProgressRepository();
    var _dtOnProgress = await woOnProgressRepo.getDataByWo(data.id, "Service");
    dtOnProgress.value = _dtOnProgress;

    if (dtOnProgress.length > 0) {
      final startAt = DateTime.parse(dtOnProgress[0].createdAt.toString());
      final dateNow = DateTime.now();
      final difference = dateNow.difference(startAt).inSeconds;

      startTimesecond = difference;
      isStart.value = true;
      datetimeStart = startAt;
      timeStart.value = dtOnProgress[0].startAt.toString();
      timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
    }
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

  addImageContent(File img) {
    var uuid = Uuid();
    imgRepo.add(ImageContentModel(
      id: uuid.v4(),
      name: basename(img.path),
      path: img.path,
      relationalId: data.id,
      relationalType: "Repair",
      createdBy: loginuser.id,
      updatedBy: loginuser.id,
      createdAt: DateTime.now().toString(),
      updatedAt: "",
      deletedAt: "",
    ));

    if (statusWo.value == "handover") {
      Get.offNamed(AppRoute.getHandoverRoute(), arguments: data);
    } else {
      Get.offNamed(AppRoute.getWoDoneRoute(), arguments: dtWoAll);
    }

    //getImageContent();
  }

  getWoOnprogres() async {
    WoOnProgressRepository woOnProgressRepo = WoOnProgressRepository();
    var _dtOnProgress = await woOnProgressRepo.getDataByWo(data.id, "Inspeksi");
    dtOnProgress.value = _dtOnProgress;
    if (dtOnProgress.length > 0) {
      if (dtOnProgress[0].duration == 0) {
        final startAt = DateTime.parse(dtOnProgress[0].createdAt.toString());
        final dateNow = DateTime.now();
        final difference = dateNow.difference(startAt).inSeconds;

        startTimesecond = difference;
        isStart.value = true;
        datetimeStart = startAt;
        timeStart.value = dtOnProgress[0].startAt.toString();
        timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
      } else {
        isStart.value = false;
        timeStart.value = dtOnProgress[0].startAt!;
        timeStop.value = dtOnProgress[0].finishAt ?? "";
        timeDuration.value = dtOnProgress[0].duration.toString();
      }
    }
  }

  startTimer() {
    Get.defaultDialog(
      title: "Info",
      middleText:
          "Untuk memulai Wo, \n Harap scan barcode mesin ${data.machineCode}?",
      textCancel: "Batal",
      textConfirm: "Mulai",
      onConfirm: () async {
        Get.back();

        isStart.value = true;
        datetimeStart = DateTime.now();
        timeStart.value = DateFormat('kk:mm:ss').format(DateTime.now());
        timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());

        addWoProgress();

        // Map<Permission, PermissionStatus> statuses = await [
        //   Permission.camera,
        //   Permission.storage,
        // ].request();

        // if (statuses[Permission.camera] == PermissionStatus.granted) {
        //   var resultData = (await scanner.scan())!;

        //   if (resultData != data.machineCode) {
        //     Get.defaultDialog(
        //       title: "Warning",
        //       middleText: "Harap Scan mesin ${data.machineCode}",
        //       textConfirm: "Ok",
        //       //barrierDismissible: false,
        //       onConfirm: () {
        //         Get.back();
        //       },
        //     );
        //   } else {
        //     isStart.value = true;
        //     datetimeStart = DateTime.now();
        //     timeStart.value = DateFormat('kk:mm:ss').format(DateTime.now());
        //     timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());

        //     addWoProgress();

        //     Get.toNamed(AppRoute.getInspectionCheckRoute());
        //   }
        // }
      },
    );
  }

  addWoProgress() async {
    statusWo.value = "On Progress";

    woOnProgressRepo.turncateTable();
    woOnProgressRepo.add(WoOnProgressModel(
        id: null,
        woId: data.id,
        startAt: timeStart.value,
        finishAt: null,
        employeeId: loginuser.employeeId,
        duration: 0,
        status: 1,
        createdAt: DateTime.now().toString(),
        updatedAt: "",
        workType: "Inspeksi"));

    var result =
        await Get.toNamed(AppRoute.getInspectionCheckRoute(), arguments: data);
    //getWoOnprogres();
  }

  updateWoProgress() {
    woOnProgressRepo.update(
      WoOnProgressModel(
          id: dtOnProgress[0].id,
          woId: data.id,
          startAt: dtOnProgress[0].startAt,
          finishAt: timeStop.value,
          employeeId: loginuser.employeeId,
          duration: int.parse(timeDuration.value),
          status: 1,
          createdAt: dtOnProgress[0].createdAt,
          updatedAt: DateTime.now().toString(),
          workType: "Inspeksi"),
    );
  }

  submitDone() {
    Get.defaultDialog(
      title: "Warning",
      middleText: "Submit Pekerjaan?",
      textCancel: "Cancel",
      textConfirm: "Submit",
      onConfirm: () {
        //addRealization();
        woOnProgressRepo.turncateTable();
        Get.offAllNamed(AppRoute.getWoDoneRoute());
      },
    );
  }

  addRealization(var woProgress) {
    var uuid = Uuid();
    var realizId = uuid.v4();
    final startAt = DateTime.parse(woProgress.createdAt.toString());
    final dateNow = DateTime.now();
    final difference = dateNow.difference(startAt).inMinutes;

    WoInspectionRealizationModel realiztionMdl = WoInspectionRealizationModel(
      id: realizId,
      inspectionId: data.id,
      code: data.code,
      employeeId: loginuser.employeeId,
      startAt: woProgress.startAt,
      finishAt: timeStop.value,
      duration: difference,
      effectivity: 0,
      pointEffectivity: 0,
      point: 0,
      description: "",
      createdBy: loginuser.id,
      updatedBy: loginuser.id,
      createdAt: DateTime.now().toString(),
      updatedAt: "",
      deletedAt: "",
      workType: "Inspeksi",
    );

    woRealizRepo.add(realiztionMdl);
    data.duration = difference;
    data.relationableId = realizId;

    data.workType = "Inspeksi";

    dtWoAll = WoAllRealizationModel(
      id: realiztionMdl.inspectionId,
      relationableId: realiztionMdl.inspectionId,
      code: realiztionMdl.code,
      activityCode: realiztionMdl.activityCode,
      machineCode: realiztionMdl.machineCode,
      startAt: realiztionMdl.startAt,
      finishAt: realiztionMdl.finishAt,
      description: realiztionMdl.description,
      duration: realiztionMdl.duration,
      isFinish: 1,
      workType: "Inspeksi",
    );

    woOnProgressRepo.delete(dtOnProgress[0].id);
    Get.defaultDialog(
      title: "Warning",
      middleText: "Ambil poto bukti pekerjaan",
      textConfirm: "Ambil Photo",
      onWillPop: () async => false,
      barrierDismissible: false,
      onConfirm: () {
        pickImage();
      },
      onCancel: () {
        Get.offAllNamed(AppRoute.getWoDoneRoute(), arguments: dtWoAll);
      },
    );
  }

  stopTimer(WoInspectionModel dt) {
    Get.defaultDialog(
      title: "Warning",
      middleText: "Apakah pekerjaan telah selesai?",
      textCancel: "Batal",
      textConfirm: "Ok",
      barrierDismissible: false,
      onConfirm: () async {
        Get.back();

        getWoProgress();
        // Map<Permission, PermissionStatus> statuses = await [
        //   Permission.camera,
        //   Permission.storage,
        // ].request();

        // if (statuses[Permission.camera] == PermissionStatus.granted) {
        //   var resultData = (await scanner.scan())!;

        //   if (resultData != data.machineCode) {
        //     Get.defaultDialog(
        //       title: "Warning",
        //       middleText: "Harap Scan mesin ${dt.machineCode}",
        //       textConfirm: "Ok",
        //       //barrierDismissible: false,
        //       onConfirm: () {
        //         Get.back();
        //       },
        //     );
        //   } else {
        //     getWoProgress();
        //   }
        // }
      },
    );
  }

  getWoProgress() async {
    WoOnProgressRepository woOnProgressRepo = WoOnProgressRepository();
    var _dtOnProgress = await woOnProgressRepo.getDataByWo(data.id, "Inspeksi");
    dtOnProgress.value = _dtOnProgress;

    datetimeStop = DateTime.now();
    timeStop.value = DateFormat('kk:mm:ss').format(DateTime.now());
    Duration diff =
        datetimeStop.difference(DateTime.parse(dtOnProgress[0].createdAt!));
    timeDuration.value = diff.inMinutes.toString();
    timer?.cancel();

    addRealization(dtOnProgress[0]);
  }

  woDone() {
    Get.toNamed(AppRoute.getWoDoneRoute());
  }
}
