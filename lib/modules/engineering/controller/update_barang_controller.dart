import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sentra_mobile/modules/engineering/model/good_request_item_model.dart';
import 'package:sentra_mobile/modules/engineering/model/goods_request_model.dart';
import 'package:sentra_mobile/modules/engineering/model/item_lups_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_repair_model.dart';
import 'package:sentra_mobile/modules/engineering/repositories/goods_request_item_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/goods_request_repository.dart';
import 'package:sentra_mobile/modules/engineering/repositories/item_lups_repository.dart';
import 'package:uuid/uuid.dart';

class UpdateBarangController extends GetxController {
  var data = Get.arguments;

  final txtController = TextEditingController().obs;
  var updtBrgEc = <TextEditingController>[].obs;

  var dt = <GoodsRequestModel>[].obs;
  GoodsRequestRepository repo = GoodsRequestRepository();

  ItemLupsRepository _itemLupsRepository = ItemLupsRepository();

  @override
  void onInit() {
    super.onInit();

    fetchData();
  }

  fetchData() async {
    String woId = data.relationableId;
    var _dt = await repo.getDataByWo(woId);
    dt.value = _dt;
    print(dt.length);
    for (int i = 0; i < dt.length; i++) {
      var nilai = "0";
      if (dt.value[i].goodsTaker != null) {
        nilai = dt.value[i].goodsTaker.toString();
      }
      updtBrgEc.add(TextEditingController(text: nilai));
    }
  }

  updateBarang(GoodsRequestModel dt, String nilai) {
    Get.defaultDialog(
      title: "Warning",
      middleText: "Pemakaian barang dengan jumlah : ${nilai}?",
      textConfirm: "Simpan",
      textCancel: "Batal",
      barrierDismissible: false,
      onConfirm: () {
        if (int.parse(nilai) > double.parse(dt.requestVerifyBy.toString())) {
          Get.defaultDialog(
            title: "Error",
            middleText:
                "Barang yang di terima hanya  : ${dt.requestVerifyBy} \n Harap buka permintaan jika perlu barang lagi.",
            textConfirm: "Ok",
            barrierDismissible: false,
            onConfirm: () {
              Get.back();
            },
          );
        } else {
          Get.back();

          dt.requestVerifyById = nilai;
          dt.goodsTaker = "1";
          repo.update(dt);

          update();
          Get.back();
        }
      },
      onCancel: () {
        Get.back();
      },
    );
  }

  itemLup(GoodsRequestModel dt, String nilai) async {
    if (dt.requestVerifyNote == null || dt.requestVerifyNote == "") {
      dt.requestVerifyNote = "Item Lup";
      repo.update(dt);

      print(dt.requestVerifyNote);

      var uuid = Uuid();
      _itemLupsRepository.add(ItemLupsModel(
        id: uuid.v4(),
        itemId: dt.goodsWhTakerId,
        createdBy: 0,
        updatedBy: 0,
        createdAt: DateTime.now().toString(),
        updatedAt: "",
        deletedAt: "",
      ));
    } else {
      dt.requestVerifyNote = "";
      repo.update(dt);

      print(dt.requestVerifyNote);
      _itemLupsRepository.delete(dt.goodsWhTakerId);
    }

    update();
  }
}
