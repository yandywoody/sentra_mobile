import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sentra_mobile/config/notify_helper.dart';
import 'package:sentra_mobile/model/employee_model.dart';
import 'package:sentra_mobile/model/user_model.dart';
import 'package:sentra_mobile/modules/engineering/model/activity_model.dart';
import 'package:sentra_mobile/modules/engineering/model/good_request_item_model.dart';
import 'package:sentra_mobile/modules/engineering/model/goods_request_model.dart';
import 'package:sentra_mobile/modules/engineering/model/image_content_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_all_realization_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_onprogres_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_repair_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_repair_realization_model.dart';
import 'package:sentra_mobile/modules/engineering/repositories/activity_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/goods_request_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/image_content_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_onprogress_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_repair_employee_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_repair_realization_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_repair_repository.dart';
import 'package:sentra_mobile/routes/app_routes.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:uuid/uuid.dart';

class WoRepairDetailController extends GetxController {
  WoRepairModel data = Get.arguments;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  var dtActivity = ActivityModel().obs;
  var dtEmp = <EmployeeModel>[].obs;
  var dtGoodRequest = <GoodsRequestModel>[].obs;
  var dtGoodRequestItem = <GoodRequestItemModel>[].obs;

  WoRepairRepository repo = WoRepairRepository();
  WoRepairEmployeeRepository woEmpRepo = WoRepairEmployeeRepository();
  ActivityRepository activityRepo = ActivityRepository();

  var session_login = GetStorage();
  late UserModel loginuser = UserModel();

  late WoAllRealizationModel dtWoAll = WoAllRealizationModel();

  WoRepairRealizationRepository repairRealizRepo =
      WoRepairRealizationRepository();

  GoodsRequestRepository goodsRequestRepository = GoodsRequestRepository();
  ImageContentRepository imgRepo = ImageContentRepository();

  TextEditingController descEc = TextEditingController();

  List<File> images = [];
  var imgContent = <ImageContentModel>[].obs;

  var startTimesecond = 0;
  var addSeconds = 1.obs;
  var hours = "".obs;
  var minutes = "".obs;
  var seconds = "".obs;

  var timeStart = "".obs;
  var timeStop = "".obs;
  var timeDuration = "0".obs;
  var isStart = false.obs;
  var isGoodReceived = true.obs;
  var isFinish = 1.obs;

  var statusWo = "".obs;

  var isPause = false.obs;

  var dtOnProgress = <WoOnProgressModel>[].obs;
  WoOnProgressRepository woOnProgressRepo = WoOnProgressRepository();

  DateTime datetimeStart = DateTime.now();
  DateTime datetimeStop = DateTime.now();
  Duration duration = Duration();
  Timer? timer;

  var notivyHelper;

  @override
  void onInit() {
    super.onInit();
    notivyHelper = NotifyHelper();
    notivyHelper.initializeNotification();
    notivyHelper.requestIOSPermissions();

    session_login.write("is_history", 0);
    getActivityByWo();
    getWoEmp();
    getGoodsRequest();
    loginuser = UserModel.fromMap(session_login.read("login_user"));
    getWoOnprogres();
    data.workType = "Repair";
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
    var _dtOnProgress = await woOnProgressRepo.getDataByWo(data.id, "Repair");
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

  getWoOnprogres() async {
    WoOnProgressRepository woOnProgressRepo = WoOnProgressRepository();
    var _dtOnProgress = await woOnProgressRepo.getDataByWo(data.id, "Repair");
    dtOnProgress.value = _dtOnProgress;
    if (dtOnProgress.length > 0) {
      if (dtOnProgress[0].status == 2) {
        final startAt = DateTime.parse(dtOnProgress[0].createdAt.toString());
        final dateNow = DateTime.now();
        final difference = dateNow.difference(startAt).inSeconds;

        startTimesecond = difference;
        isStart.value = false;
        datetimeStart = startAt;
        timeStart.value = dtOnProgress[0].startAt.toString();

        isPause.value = true;
      } else {
        final startAt = DateTime.parse(dtOnProgress[0].createdAt.toString());
        final dateNow = DateTime.now();
        final difference = dateNow.difference(startAt).inSeconds;

        startTimesecond = difference;
        timeDuration.value = dtOnProgress[0].duration.toString();
        isStart.value = true;
        datetimeStart = startAt;
        timeStart.value = dtOnProgress[0].startAt.toString();
        timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
      }
    }
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

  startTimer() {
    if (!isGoodReceived.value) {
      Get.defaultDialog(
          title: "Warning",
          barrierDismissible: false,
          middleText: "Ada barang yang belum di terima? \nCek di list item",
          textConfirm: "Check",
          onConfirm: () async {
            var result = await Get.offNamed(AppRoute.getItemCheckRoute(),
                arguments: data);
            loadData();
          });
    } else {
      Get.defaultDialog(
        title: "Info",
        middleText:
            "Untuk memulai Wo, \n Harap scan barcode mesin ${data.machineCode}?",
        textCancel: "Batal",
        textConfirm: "Mulai",
        onConfirm: () async {
          Get.back();

          // isStart.value = true;
          // datetimeStart = DateTime.now();
          // timeStart.value = DateFormat('kk:mm:ss').format(DateTime.now());
          // timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
          // notivyHelper.displayNotification(
          //     title: "Wo Starting",
          //     body: "Semangat ngerjainnya ya, kamu pasti bisa :) !!");

          // addWoProgress();

          Map<Permission, PermissionStatus> statuses = await [
            Permission.camera,
            Permission.storage,
          ].request();

          if (statuses[Permission.camera] == PermissionStatus.granted) {
            var resultData = (await scanner.scan())!;

            print(resultData);

            if (resultData != data.machineCode) {
              Get.defaultDialog(
                title: "Warning",
                middleText: "Harap Scan mesin ${data.machineCode}",
                textConfirm: "Ok",
                //barrierDismissible: false,
                onConfirm: () {
                  Get.back();
                },
              );
            } else {
              isStart.value = true;
              datetimeStart = DateTime.now();
              timeStart.value = DateFormat('kk:mm:ss').format(DateTime.now());
              timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
              notivyHelper.displayNotification(
                  title: "Wo Starting",
                  body: "Semangat ngerjainnya ya, kamu pasti bisa :) !!");

              addWoProgress();
            }
          }
        },
      );
    }
  }

  addWoProgress() async {
    statusWo.value = "On Progress";

    woOnProgressRepo.add(WoOnProgressModel(
        id: int.parse(DateFormat('kkmmss').format(DateTime.now())),
        woId: data.id,
        startAt: timeStart.value,
        finishAt: null,
        employeeId: loginuser.employeeId,
        duration: 0,
        status: 1,
        createdAt: DateTime.now().toString(),
        updatedAt: "",
        workType: "Repair"));
  }

  pauseWo() async {
    Get.defaultDialog(
        title: "Info",
        barrierDismissible: false,
        middleText: "Pause Wo",
        textConfirm: "Pause",
        textCancel: "Tidak",
        onConfirm: () async {
          statusWo.value = "Paused";

          WoOnProgressRepository woOnProgressRepo = WoOnProgressRepository();
          var _dtOnProgress =
              await woOnProgressRepo.getDataByWo(data.id, data.workType);
          var dtTemp = _dtOnProgress;

          datetimeStop = DateTime.now();
          var pauseTime = DateFormat('kk:mm:ss').format(DateTime.now());
          Duration diff =
              datetimeStop.difference(DateTime.parse(dtTemp[0].createdAt!));
          var duration = diff.inMinutes.toString();
          timer?.cancel();

          dtTemp[0].status = 2;
          dtTemp[0].pauseAt = pauseTime.toString();
          dtTemp[0].durationPause =
              int.parse(duration) + int.parse(timeDuration.value);

          woOnProgressRepo.update(dtTemp[0]);

          Get.offAllNamed(AppRoute.getHomeRoute());
        });
  }

  resumeWo() {
    Get.defaultDialog(
      title: "Info",
      middleText: "Mulai Kerja Kembali WO ini?",
      textCancel: "Batal",
      textConfirm: "Mulai",
      onConfirm: () async {
        Get.back();

        isStart.value = true;
        datetimeStart = DateTime.now();
        timeStart.value = DateFormat('kk:mm:ss').format(DateTime.now());
        timeDuration.value = dtOnProgress[0].durationPause.toString();

        timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
        notivyHelper.displayNotification(
            title: "Wo Mulai Kembali", body: "Semangat lagi ya :D");

        WoOnProgressRepository woOnProgressRepo = WoOnProgressRepository();
        var dtOnProgressTemp =
            await woOnProgressRepo.getDataByWo(data.id, data.workType);
        var dtTemp = dtOnProgressTemp;

        timeDuration.value = dtTemp[0].durationPause.toString();

        dtTemp[0].status = 1;
        dtTemp[0].createdAt = datetimeStart.toString();
        dtTemp[0].startAt = timeStart.value;
        dtTemp[0].duration = int.parse(timeDuration.value);

        woOnProgressRepo.update(dtTemp[0]);
        Get.offAllNamed(AppRoute.getHomeRoute());

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
        //   }
        // }
      },
    );
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
          workType: "Service"),
    );
  }

  submitDone() {
    if (images.length > 0) {
      Get.defaultDialog(
        title: "Warning",
        middleText: "Submit Pekerjaan?",
        textCancel: "Cancel",
        textConfirm: "Submit",
        onConfirm: () {
          //addRealization();
          woOnProgressRepo.delete(dtOnProgress[0].id);
          Get.offNamed(AppRoute.getWoDoneRoute());
        },
      );
    } else {
      Get.defaultDialog(
        title: "Warning",
        middleText: "Mohon photo bukti pekerjaan",
        textConfirm: "Ambil Photo",
        textCancel: "Batal",
        barrierDismissible: false,
        onConfirm: () {
          pickImage();
          Get.back();
        },
      );
    }
  }

  stopTimer(WoRepairModel dt, String type) {
    statusWo.value = type;

    Get.defaultDialog(
      title: "Warning",
      middleText: "Scan mesin ${dt.machineCode} untuk akhiri WO?",
      textCancel: "Batal",
      textConfirm: "Ok",
      barrierDismissible: false,
      onConfirm: () async {
        Get.back();

        //getWoProgress();

        Map<Permission, PermissionStatus> statuses = await [
          Permission.camera,
          Permission.storage,
        ].request();

        if (statuses[Permission.camera] == PermissionStatus.granted) {
          var resultData = (await scanner.scan())!;

          if (resultData != data.machineCode) {
            Get.defaultDialog(
              title: "Warning",
              middleText: "Harap Scan mesin ${dt.machineCode}",
              textConfirm: "Ok",
              //barrierDismissible: false,
              onConfirm: () {
                Get.back();
              },
            );
          } else {
            getWoProgress();
          }
        }
      },
    );
  }

  addRealization(var woProgress) {
    var uuid = Uuid();
    var realizId = uuid.v4();
    var difference = int.parse(timeDuration.value);

    WoRepairRealizationModel realiztionMdl = WoRepairRealizationModel(
      id: realizId,
      repairId: data.id,
      code: data.code,
      activityCode: data.activityCode,
      machineCode: data.machineCode,
      employeeId: loginuser.employeeId,
      startAt: woProgress.startAt,
      finishAt: timeStop.value,
      duration: difference,
      effectivity: 0,
      pointEffectivity: 0,
      point: data.point,
      description: descEc.text,
      isFinish: isFinish.value,
      createdBy: loginuser.id,
      updatedBy: loginuser.id,
      createdAt: woProgress.createdAt.toString(),
      updatedAt: DateTime.now().toString(),
      deletedAt: "",
      workType: "Repair",
    );
    repairRealizRepo.add(realiztionMdl);

    data.startAt = woProgress.startAt;
    data.finishAt = timeStop.value;
    data.duration = difference;
    data.relationableId = realizId;

    dtWoAll = WoAllRealizationModel(
      id: realiztionMdl.id,
      relationableId: realiztionMdl.repairId,
      code: realiztionMdl.code,
      activityCode: realiztionMdl.activityCode,
      machineCode: realiztionMdl.machineCode,
      startAt: realiztionMdl.startAt,
      finishAt: realiztionMdl.finishAt,
      description: realiztionMdl.description,
      duration: realiztionMdl.duration,
      isFinish: realiztionMdl.isFinish,
      workType: "Repair",
    );

    woOnProgressRepo.delete(woProgress.id);

    if (statusWo.value == "handover") {
      Get.offAllNamed(AppRoute.getHandoverRoute(), arguments: data);
    } else {
      Get.defaultDialog(
        title: "Warning",
        middleText: "Ambil poto bukti pekerjaan",
        textConfirm: "Ambil Photo",
        textCancel: "Tidak",
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
  }

  getActivityByWo() async {
    var dt = activityRepo.getDataByWo(data.activityCode.toString());
    dtActivity.value = await dt;

    if (dtActivity.value.name == null) {
      var tempDt = await repo.getDataWo(data.id);
      print(tempDt.activityCode);

      var dtNewActivity =
          await activityRepo.getDataByCode(tempDt.activityCode.toString());
      if (dtNewActivity.name == null) {
        dtActivity.value.name = tempDt.activityCode;
        data.activityCode = tempDt.activityCode;
      } else {
        dtActivity.value.name = dtNewActivity.name;
        data.activityCode = dtNewActivity.name;
      }
    }

    update();
  }

  getWoEmp() async {
    var dt = woEmpRepo.getEmpByWo(data.id);
    dtEmp.value = await dt;
  }

  getGoodsRequest() async {
    isGoodReceived.value = true;
    var dt = goodsRequestRepository.getDataByWo(data.id);
    dtGoodRequest.value = await dt;
    for (int i = 0; i < dtGoodRequest.length; i++) {
      if (dtGoodRequest.value[i].isReceived == 0) {
        isGoodReceived.value = false;
      }
    }

    var dt2 = goodsRequestRepository.getDataNewItemByWo(data.id);
    dtGoodRequestItem.value = await dt2;
    print(dtGoodRequestItem.length);
    for (int i = 0; i < dtGoodRequestItem.length; i++) {
      print(dtGoodRequestItem.value[i].isOperational);
      if (dtGoodRequestItem.value[i].isOperational == 0) {
        isGoodReceived.value = false;
      }
    }
  }

  getImageContent() async {
    var dt = imgRepo.getDataWoId(data.id);
    imgContent.value = await dt;
    update();
  }

  getWoProgress() async {
    WoOnProgressRepository woOnProgressRepo = WoOnProgressRepository();
    var dtOnProgressTemp =
        await woOnProgressRepo.getDataByWo(data.id, data.workType);
    dtOnProgress.value = dtOnProgressTemp;

    if (dtOnProgress[0].status == 2) {
      datetimeStop = DateTime.parse(dtOnProgress[0].createdAt.toString());
      timeStop.value = dtOnProgress[0].pauseAt.toString();
      timeDuration.value = dtOnProgress[0].durationPause.toString();
    } else {
      datetimeStop = DateTime.now();
      timeStop.value = DateFormat('kk:mm:ss').format(DateTime.now());
      Duration diff =
          datetimeStop.difference(DateTime.parse(dtOnProgress[0].createdAt!));
      timeDuration.value =
          ((dtOnProgress[0].durationPause ?? 0) + diff.inMinutes).toString();
    }
    timer?.cancel();

    addRealization(dtOnProgress[0]);
  }

  goToItem(var route, var arg) {
    var result_item = Get.toNamed(route, arguments: arg);
    if (result_item == "ok") {
      loadData();
    }
  }

  loadData() async {
    try {
      getActivityByWo();
      getWoEmp();
      getGoodsRequest();

      update();
    } catch (err) {
      rethrow;
    }
  }
}
