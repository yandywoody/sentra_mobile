import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:sentra_mobile/model/employee_model.dart';
import 'package:sentra_mobile/modules/engineering/model/good_request_item_model.dart';
import 'package:sentra_mobile/modules/engineering/model/goods_request_model.dart';
import 'package:sentra_mobile/modules/engineering/model/items_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_all_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_project_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_repair_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_service_model.dart';
import 'package:sentra_mobile/modules/engineering/repositories/goods_request_item_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/goods_request_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/items_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_project_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_repair_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_service_repository.dart';
import 'package:sentra_mobile/routes/app_routes.dart';
import 'package:uuid/uuid.dart';

class AddItemController extends GetxController {
  var dtWo = Get.arguments;

  TextEditingController woEc = TextEditingController();
  TextEditingController itemEc = TextEditingController();
  TextEditingController totItemEc = TextEditingController();

  GoodsRequestItemRepository repo = GoodsRequestItemRepository();

  var dtGoodsRequest = <GoodsRequestModel>[].obs;
  GoodsRequestRepository repoGr = GoodsRequestRepository();

  var dtGoodsItemRequest = <GoodRequestItemModel>[].obs;
  GoodsRequestItemRepository repoGrItem = GoodsRequestItemRepository();

  var dtWoService = <WoServiceModel>[].obs;
  WoServiceRepository woRepoService = WoServiceRepository();

  var dtWoProject = <WoProjectModel>[].obs;
  WoProjectRepository woRepoProject = WoProjectRepository();

  var dtWoRepair = <WoRepairModel>[].obs;
  WoRepairRepository woRepoRepair = WoRepairRepository();

  var dtItems = <ItemsModel>[].obs;
  ItemsRepository itemRepo = ItemsRepository();

  late EmployeeModel loginEmployee = EmployeeModel();
  var session_login = GetStorage();

  var dtWoAll = <WoAllModel>[].obs;
  var frmWo = WoAllModel().obs;
  var frmItem = GoodsRequestModel().obs;

  var lblActivity = "".obs;

  @override
  void onInit() {
    super.onInit();

    loginEmployee = EmployeeModel.fromMap(session_login.read("login_employee"));
    lblActivity.value = dtWo.activityCode;

    gethWo();
    getGR();
  }

  setGr(GoodsRequestModel? value) async {
    frmItem.value = value!;

    var _dt = await repoGrItem.getDataByIdGr(value.code);
    dtGoodsItemRequest.value = _dt;

    update();
  }

  additem() {
    if (frmItem.value.code == null) {
      Get.defaultDialog(
        title: "Error",
        middleText: "Kode request belum dipilih",
        textConfirm: "ok",
        onConfirm: () => Get.back(),
      );
    } else {
      Get.defaultDialog(
        title: "Info",
        middleText: "Pilih kode penerimaan ${frmItem.value.code}?",
        textCancel: "Batal",
        textConfirm: "Buat",
        onConfirm: () async {
          Get.back(result: "ok");
          saveItem();
        },
      );
    }
  }

  getItem() async {
    var _dt = await itemRepo.getData();
    dtItems.value = _dt;
  }

  getGR() async {
    var _dt = await repoGr.getData();
    dtGoodsRequest.value = _dt;
  }

  gethWo() async {
    var dt2 = await woRepoRepair.getDataByEmpOther(loginEmployee.id);
    dtWoRepair.value = dt2;
    for (var i = 0; i < dt2.length; i++) {
      dtWoAll.add(WoAllModel(
        id: dt2[i].id,
        activityCode: dt2[i].activityCode,
        machineCode: dt2[i].machineCode,
        startAt: dt2[i].startAt,
        finishAt: dt2[i].finishAt,
        score: dt2[i].score,
        description: dt2[i].description,
        duration: dt2[i].duration,
        workType: "Repair",
      ));
    }

    var dt = await woRepoService.getDataByEmpOther(loginEmployee.id);
    dtWoService.value = dt;
    for (var i = 0; i < dt.length; i++) {
      dtWoAll.add(WoAllModel(
        id: dt[i].id,
        activityCode: dt[i].activityCode,
        machineCode: dt[i].machineCode,
        startAt: dt[i].startAt,
        finishAt: dt[i].finishAt,
        score: dt[i].score,
        description: dt[i].description,
        duration: dt[i].duration,
        workType: "Service",
      ));
    }

    var dt3 = await woRepoProject.getDataByEmpOther(loginEmployee.id);
    dtWoProject.value = dt3;
    for (var i = 0; i < dt3.length; i++) {
      dtWoAll.add(WoAllModel(
        id: dt3[i].id,
        activityCode: dt3[i].name,
        machineCode: "-",
        startAt: dt3[i].startAt,
        finishAt: dt3[i].finishAt,
        score: dt3[i].score,
        description: "",
        duration: dt3[i].duration,
        workType: "Project",
      ));
    }

    update();
  }

  saveItem() async {
    try {
      frmItem.value.relationableId = dtWo.id;
      repoGr.update(frmItem.value);

      Get.defaultDialog(
        title: "Success",
        middleText: "Tambah Item Berhasil",
        textConfirm: "Ok",
        onConfirm: () {
          Get.back(result: "ok");

          Get.back(result: "ok");
        },
      );
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }
}
