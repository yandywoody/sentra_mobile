import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:sentra_mobile/model/employee_model.dart';
import 'package:sentra_mobile/modules/engineering/model/activity_model.dart';
import 'package:sentra_mobile/modules/engineering/model/machine_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_repair_employee_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_repair_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_service_employee_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_service_model.dart';
import 'package:sentra_mobile/modules/engineering/repositories/activity_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/employee_task_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_repair_employee_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_repair_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_service_employee_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_service_repository.dart';
import 'package:sentra_mobile/routes/app_routes.dart';
import 'package:uuid/uuid.dart';

class WoManualController extends GetxController {
  var session_login = GetStorage();
  late EmployeeModel loginEmployee = EmployeeModel();

  WoRepairRepository woRepairRepo = WoRepairRepository();
  WoRepairEmployeeRepository woRepairEmpRepo = WoRepairEmployeeRepository();

  WoServiceRepository woServiceRepo = WoServiceRepository();
  WoServiceEmployeeRepository woServiceEmpRepo = WoServiceEmployeeRepository();

  var dtWo = <WoRepairModel>[].obs;

  TextEditingController sActivityEc = TextEditingController();
  TextEditingController sMachineEc = TextEditingController();
  TextEditingController sOptEc = TextEditingController();

  var dtActivity = <ActivityModel>[].obs;
  var dtActivityTemp = <ActivityModel>[].obs;
  ActivityRepository activityRepo = ActivityRepository();

  var dtMachine = <MachineModel>[].obs;
  var dtMachineTemp = <MachineModel>[].obs;
  MachineRepository machineRepo = MachineRepository();

  var dtWorkType = ["Repair", "Service"];
  var frmActivityModel = ActivityModel().obs;

  TimeOfDay timeStart =
      TimeOfDay(hour: TimeOfDay.now().hour, minute: TimeOfDay.now().minute);

  TextEditingController activityEc = TextEditingController();
  TextEditingController machineEc = TextEditingController();
  TextEditingController strtEc = TextEditingController();
  TextEditingController endEc = TextEditingController();
  TextEditingController descEc = TextEditingController();

  var frmWorkType = "Repair".obs;
  ActivityModel frmActivity = ActivityModel();
  var frmMachine = "".obs;
  var frmStartAt = TimeOfDay(hour: 01, minute: 00).obs;
  var frmEndAt = TimeOfDay(hour: 01, minute: 00).obs;
  var frmDesc = "".obs;

  @override
  void onInit() {
    super.onInit();
    loginEmployee = EmployeeModel.fromMap(session_login.read("login_employee"));
    getActivity();
    getMachine();
  }

  searchDataActivity(String data) {
    final result = dtActivityTemp.where((dt) {
      final actCode = (dt.code ?? "").toLowerCase();
      final input = data.toLowerCase();
      return actCode.contains(input);
    }).toList();

    dtActivity.value = result;
    update();
  }

  searchDataMachine(String data) {
    final result = dtMachineTemp.where((dt) {
      final actCode = (dt.code ?? "").toLowerCase();
      final input = data.toLowerCase();
      return actCode.contains(input);
    }).toList();

    dtMachine.value = result;
    update();
  }

  getActivity() async {
    var _dt = await activityRepo.getData();
    dtActivity.value = _dt;
    dtActivityTemp.value = _dt;

    dtActivity.sort((a, b) => a.name!.compareTo(b.name.toString()));
  }

  getMachine() async {
    var _dt = await machineRepo.getData();
    dtMachine.value = _dt;
    dtMachineTemp.value = _dt;

    dtMachine.sort((a, b) => a.code!.compareTo(b.code.toString()));
  }

  setWorkType(String value) {
    frmWorkType.value = value;
  }

  setActivity(var value) {
    frmActivity = value;
    print(frmActivity);
  }

  setMachine(String? value) {
    frmMachine.value = value!;
    print(frmMachine.value);
  }

  setStartAt(TimeOfDay value) {
    frmStartAt.value = value;
    strtEc.text =
        '${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}';
  }

  setEndAt(TimeOfDay value) {
    frmEndAt.value = value;
    endEc.text =
        '${value.hour.toString().padLeft(2, '0')}:${value.minute.toString().padLeft(2, '0')}';
  }

  createWo() {
    Get.defaultDialog(
      title: "Info",
      middleText: "Buat WO Manual?",
      textCancel: "Batal",
      textConfirm: "Buat",
      onConfirm: () async {
        Get.back();

        if (frmWorkType.value == "Repair") {
          createWoRepair();
        } else if (frmWorkType.value == "Service") {
          createWoService();
        } else {}
      },
    );
  }

  createWoRepair() async {
    var uuid = Uuid();
    var idWo = uuid.v4();
    var code =
        "RPR/BS/${frmMachine.value}/${DateFormat('y-M-d').format(DateTime.now()).replaceAll(RegExp('-'), '')}/M1";
    double strTime = frmStartAt.value.hour.toDouble() +
        (frmStartAt.value.minute.toDouble() / 60);
    double endTime = frmEndAt.value.hour.toDouble() +
        (frmEndAt.value.minute.toDouble() / 60);
    double _timeDiff = (endTime - strTime) * 60;

    if (frmActivity.code == null) {
      Get.defaultDialog(
          title: "Error",
          middleText: "Silahkan pilih aktifitas terlebih dahulu",
          textConfirm: "Ok",
          onConfirm: () {
            Get.back();
          });
    } else if (frmMachine.value.isEmpty) {
      Get.defaultDialog(
          title: "Error",
          middleText: "Silahkan pilih mesin terlebih dahulu",
          textConfirm: "Ok",
          onConfirm: () {
            Get.back();
          });
    } else if (strtEc.text == "") {
      Get.defaultDialog(
          title: "Error",
          middleText: "Silahkan pilih jam awal terlebih dahulu",
          textConfirm: "Ok",
          onConfirm: () {
            Get.back();
          });
    } else if (endEc.text == "") {
      Get.defaultDialog(
          title: "Error",
          middleText: "Silahkan pilih jam akhir terlebih dahulu",
          textConfirm: "Ok",
          onConfirm: () {
            Get.back();
          });
    } else if (strTime > endTime) {
      Get.defaultDialog(
          title: "Error",
          middleText: "Start time lebih besar dari End Time",
          textConfirm: "Ok",
          onConfirm: () {
            Get.back();
          });
    } else {
      try {
        woRepairRepo.add(
          WoRepairModel(
            id: idWo,
            relationableType: "",
            relationableId: "",
            code: code,
            groupCode: "MM",
            machineCode: frmMachine.value,
            activityCode: frmActivity.code,
            inspectionId: null,
            executedAt: DateFormat('y-M-d').format(DateTime.now()).toString(),
            startAt: "${strtEc.text}:00",
            finishAt: "${endEc.text}:00",
            duration: _timeDiff.round(),
            durationRealization: 0,
            score: 1.0,
            point: 1.0,
            description: descEc.text,
            needElectrician: 0,
            type: 1,
            isActive: 1,
            isFinish: 0,
            isOvertime: 0,
            approved: 0,
            isAdminNote: 1,
            adminNote: "Manual",
            isSuitable: 0,
            createdBy: 10,
            updatedBy: 10,
            createdAt:
                DateFormat('y-M-d hh:mm:ss').format(DateTime.now()).toString(),
            updatedAt:
                DateFormat('y-M-d hh:mm:ss').format(DateTime.now()).toString(),
            deletedAt: null,
            workType: "Repair",
          ),
        );

        woRepairEmpRepo.add(WoRepairEmployeeModel(
            id: uuid.v1(),
            repairId: idWo,
            employeeId: loginEmployee.id,
            createdBy: 10,
            updatedBy: 10,
            createdAt:
                DateFormat('y-M-d hh:mm:ss').format(DateTime.now()).toString(),
            updatedAt:
                DateFormat('y-M-d hh:mm:ss').format(DateTime.now()).toString(),
            deletedAt: null));

        Get.defaultDialog(
            title: "Success",
            middleText: "Buat WO Manual Berhasil",
            textConfirm: "Ok",
            onConfirm: () => Get.offAllNamed(AppRoute.getHomeRoute()));
      } catch (e) {}
    }
  }

  createWoService() async {
    var uuid = Uuid();
    var idWo = uuid.v4();
    var code =
        "SRV/BS/${frmMachine.value}/${DateFormat('y-M-d').format(DateTime.now()).replaceAll(RegExp('-'), '')}/M1";
    double strTime = frmStartAt.value.hour.toDouble() +
        (frmStartAt.value.minute.toDouble() / 60);
    double endTime = frmEndAt.value.hour.toDouble() +
        (frmEndAt.value.minute.toDouble() / 60);
    double _timeDiff = (endTime - strTime) * 60;
    if (frmActivity.code == null) {
      Get.defaultDialog(
          title: "Error",
          middleText: "Silahkan pilih aktifitas terlebih dahulu",
          textConfirm: "Ok",
          onConfirm: () {
            Get.back();
          });
    } else if (frmMachine.value.isEmpty) {
      Get.defaultDialog(
          title: "Error",
          middleText: "Silahkan pilih mesin terlebih dahulu",
          textConfirm: "Ok",
          onConfirm: () {
            Get.back();
          });
    } else if (strtEc.text == "") {
      Get.defaultDialog(
          title: "Error",
          middleText: "Silahkan pilih jam awal terlebih dahulu",
          textConfirm: "Ok",
          onConfirm: () {
            Get.back();
          });
    } else if (endEc.text == "") {
      Get.defaultDialog(
          title: "Error",
          middleText: "Silahkan pilih jam akhir terlebih dahulu",
          textConfirm: "Ok",
          onConfirm: () {
            Get.back();
          });
    } else if (strTime > endTime) {
      Get.defaultDialog(
          title: "Error",
          middleText: "Start time lebih besar dari End Time",
          textConfirm: "Ok",
          onConfirm: () {
            Get.back();
          });
    } else {
      try {
        woServiceRepo.add(
          WoServiceModel(
            id: idWo,
            relationableType: "",
            relationableId: "",
            code: code,
            groupCode: "MM",
            machineCode: frmMachine.value,
            activityCode: frmActivity.code,
            inspectionId: null,
            executedAt: DateFormat('y-M-d').format(DateTime.now()).toString(),
            startAt: "${strtEc.text}:00",
            finishAt: "${endEc.text}:00",
            duration: _timeDiff.round(),
            durationRealization: 0,
            score: 1.0,
            point: 1.0,
            description: descEc.text,
            needElectrician: 0,
            type: 1,
            isActive: 1,
            isFinish: 0,
            isOvertime: 0,
            isAdminNote: 1,
            durationActualTeam: 0,
            adminNote: "Manual",
            isSuitable: 0,
            createdBy: 10,
            updatedBy: 10,
            createdAt:
                DateFormat('y-M-d hh:mm:ss').format(DateTime.now()).toString(),
            updatedAt:
                DateFormat('y-M-d hh:mm:ss').format(DateTime.now()).toString(),
            deletedAt: null,
            workType: "Service",
          ),
        );

        woServiceEmpRepo.add(WoServiceEmployeeModel(
            id: uuid.v1(),
            serviceId: idWo,
            employeeId: loginEmployee.id,
            createdBy: 10,
            updatedBy: 10,
            createdAt:
                DateFormat('y-M-d hh:mm:ss').format(DateTime.now()).toString(),
            updatedAt:
                DateFormat('y-M-d hh:mm:ss').format(DateTime.now()).toString(),
            deletedAt: null));

        Get.defaultDialog(
            title: "Success",
            middleText: "Buat WO Manual Berhasil",
            textConfirm: "Ok",
            onConfirm: () => Get.offAllNamed(AppRoute.getHomeRoute()));
      } catch (e) {}
    }
  }
}
