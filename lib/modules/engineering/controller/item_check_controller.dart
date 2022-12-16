import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sentra_mobile/model/employee_model.dart';
import "package:collection/collection.dart";
import 'package:sentra_mobile/model/user_model.dart';
import 'package:sentra_mobile/modules/engineering/model/good_request_item_model.dart';
import 'package:sentra_mobile/modules/engineering/model/goods_request_model.dart';
import 'package:sentra_mobile/modules/engineering/repositories/goods_request_item_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/goods_request_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_project_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_repair_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/wo_service_repository.dart';
import 'package:sentra_mobile/routes/app_routes.dart';

class ItemCheckController extends GetxController {
  var dtWo = Get.arguments;

  var dt = <GoodsRequestModel>[].obs;
  var dt2 = <GoodRequestItemModel>[].obs;

  var dtDetail = <GoodsRequestModel>[].obs;
  var totItemDiterma = 0.0.obs;

  GoodsRequestRepository repo = GoodsRequestRepository();
  GoodsRequestItemRepository repo2 = GoodsRequestItemRepository();

  var jmlEc = <TextEditingController>[].obs;
  TextEditingController jmlEcx = TextEditingController();

  WoRepairRepository repoRepair = WoRepairRepository();
  WoServiceRepository repoService = WoServiceRepository();
  WoProjectRepository repoProject = WoProjectRepository();

  var session_login = GetStorage();
  late EmployeeModel loginEmployee = EmployeeModel();
  late UserModel loginuser = UserModel();

  var isManual = 0.obs;

  @override
  void onInit() {
    super.onInit();

    loginEmployee = EmployeeModel.fromMap(session_login.read("login_employee"));
    loginuser = UserModel.fromMap(session_login.read("login_user"));

    fetchWo();
  }

  getAllWo(var itemId) async {
    var _dtDetail =
        await repo.getDataByEmpItem(loginEmployee.id, itemId.goodsRequesterId);
    dtDetail.value = _dtDetail;
    for (int i = 0; i < dtDetail.length; i++) {
      var nilai = "0";
      if (dtDetail.value[i].requestVerifyBy != null) {
        nilai = dtDetail.value[i].requestVerifyBy.toString();
      }
      jmlEc.add(TextEditingController(text: nilai));
    }
  }

  woDetail(var id, var type) async {
    if (type == "Repair") {
      var sendData = await repoRepair.getDataById(id);
      Get.toNamed(AppRoute.getWoRepairDetailRoute(), arguments: sendData);
    }
    if (type == "Service") {
      var sendData = await repoService.getDataById(id);
      Get.toNamed(AppRoute.getWoServiceDetailRoute(), arguments: sendData);
    }
    if (type == "Project") {
      var sendData = await repoProject.getDataById(id);
      Get.toNamed(AppRoute.getWoProjectDetailRoute(), arguments: sendData);
    }
  }

  fetchWo() async {
    if (dtWo != null) {
      var _dt = await repo.getCheckDataByWo(dtWo.id);
      dt.value = _dt;
    } else {
      var _dt = await repo.getDataByEmp(loginEmployee.id);
      dt.value = _dt;
    }

    for (int i = 0; i < dt.length; i++) {
      if (dt[i].requestVerifyBy != null) {
        totItemDiterma.value = totItemDiterma.value +
            double.parse(dt[i].requestVerifyBy.toString());
      }
    }

    var _dt2 = await repo.getDataNewItemAll();
    dt2.value = _dt2;
  }

  @override
  void dispose() {
    super.dispose();
  }

  terimaBarangAll(GoodsRequestModel grDt) {
    Get.defaultDialog(
      title: "Warning",
      middleText: "Terima semua barang.",
      textConfirm: "Ok",
      textCancel: "Batal",
      barrierDismissible: false,
      onConfirm: () async {
        Get.back();

        totItemDiterma.value = 0;

        var listAllGr = await repo.getDataByEmpItem(
            loginEmployee.id, grDt.goodsRequesterId);

        for (int i = 0; i < listAllGr.length; i++) {
          if (listAllGr[i].isReceived == 0) {
            listAllGr[i].requestVerifyBy =
                double.parse(listAllGr[i].goodsTakerId.toString())
                    .toStringAsFixed(0);
            listAllGr[i].isReceived = 1;

            print(listAllGr[i].isReceived);

            totItemDiterma.value = totItemDiterma.value +
                double.parse(listAllGr[i].requestVerifyBy.toString());

            repo.update(listAllGr[i]);
          }
        }

        grDt.isReceived = 1;
        repo.update(grDt);

        update();

        Get.back();

        Get.defaultDialog(
          title: "Success",
          middleText: "Item sudah diterima semua",
          textConfirm: "Ok",
          barrierDismissible: false,
          onConfirm: () {
            Get.offNamed(AppRoute.getHomeRoute());
          },
        );
      },
    );
  }

  terimaBarang(GoodsRequestModel grDt, var nilai) async {
    Get.defaultDialog(
      title: "Warning",
      middleText: "Terima barang dengan jumlah : ${nilai}?",
      textConfirm: "Simpan",
      textCancel: "Batal",
      barrierDismissible: false,
      onConfirm: () {
        totItemDiterma.value += int.parse(nilai);

        if (totItemDiterma.value > double.parse(grDt.goodsTakerId.toString())) {
          Get.defaultDialog(
            title: "Error",
            middleText:
                "Barang yang di planing hanya  : ${grDt.goodsTakerId} \n Harap buka permintaan jika perlu barang lagi.",
            textConfirm: "Ok",
            barrierDismissible: false,
            onConfirm: () {
              Get.back();
            },
          );
        } else {
          Get.back();
          grDt.requestVerifyBy = totItemDiterma.value.toString();
          grDt.isReceived = 1;

          repo.update(grDt);

          update();
          Get.back();
        }
      },
      onCancel: () {
        Get.back();
      },
    );
  }

  changeStatusItemManual(GoodRequestItemModel grDt) {
    int indx = dt2.indexOf(grDt);
    if (dt2[indx].isOperational == 0) {
      dt2[indx].isOperational = 1;
    } else {
      dt2[indx].isOperational = 0;
    }

    repo2.update(dt2[indx]);

    update();
  }
}
