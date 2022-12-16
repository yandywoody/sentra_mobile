import 'package:sentra_mobile/config/sqflite_helper.dart';
import 'package:sentra_mobile/modules/engineering/model/good_request_item_model.dart';
import 'package:sentra_mobile/modules/engineering/model/goods_request_model.dart';

class GoodsRequestItemRepository {
  final SQFliteHelper _sqFliteHelper = SQFliteHelper();
  String tblName = "wh_goods_request_items";

  var columnUsable = [
    "id",
    "ic_goods_request_code",
    "req_item_id",
    "req_item_name",
    "req_stock",
    "req_quantity",
    "req_unit_conversion_id",
    "req_unit_conversion_name",
    "req_desc",
    "req_status",
    "parent_id",
    "verify_stock",
    "verify_status",
    "verify_by",
    "verify_by_id",
    "verify_date",
    "verify_note",
    "change_item",
    "add_item",
    "item_id",
    "quantity",
    "item_unit_conversion_id",
    "req_item_unit_conversion_id",
    "description",
    "quantity_order",
    "quantity_out",
    "quantity_location_used",
    "quantity_money_used",
    "target_arrival_date",
    "is_active",
    "is_priority",
    "is_operational",
    "status",
    "status_stock",
    "goods_receipt_status",
    "relationable_type",
    "relationable_id",
    "machine_code",
    "programmer_note",
    "deleted_at",
    "created_at",
    "updated_at",
  ];

  Future<List<GoodRequestItemModel>> getData() async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.query(tblName, columns: columnUsable);
    List<GoodRequestItemModel> dt = [];

    for (int i = 0; i < maps.length; i++) {
      dt.add(GoodRequestItemModel.fromMap(maps[i]));
    }

    return dt;
  }

  Future<List<GoodRequestItemModel>> getDataByIdGr(String? id) async {
    var dbClient = await _sqFliteHelper.db;
    List<Map> maps = await dbClient.query(tblName,
        columns: columnUsable,
        where: "ic_goods_request_code = ?",
        whereArgs: [id]);
    List<GoodRequestItemModel> dt = [];

    for (int i = 0; i < maps.length; i++) {
      dt.add(GoodRequestItemModel.fromMap(maps[i]));
    }

    return dt;
  }

  Future<int> add(GoodRequestItemModel dtModel) async {
    var dbClient = await _sqFliteHelper.db;
    return await dbClient.insert(tblName, dtModel.toMap());
  }

  Future<int> update(GoodRequestItemModel dtModel) async {
    var dbClient = await _sqFliteHelper.db;
    return await dbClient.update(tblName, dtModel.toMap(),
        where: "id = ?", whereArgs: [dtModel.id]);
  }

  Future<int> delete(int id) async {
    var dbClient = await _sqFliteHelper.db;
    return await dbClient.delete(tblName, where: "id = ?", whereArgs: [id]);
  }

  Future<void> turncateTable() async {
    var dbClient = await _sqFliteHelper.db;
    return await dbClient.execute("DELETE FROM ${tblName}");
  }
}
