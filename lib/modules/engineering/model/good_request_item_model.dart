import 'dart:convert';

class GoodRequestItemModel {
  GoodRequestItemModel({
    this.id,
    this.icGoodsRequestCode,
    this.reqItemId,
    this.reqItemName,
    this.reqStock,
    this.reqQuantity,
    this.reqUnitConversionId,
    this.reqUnitConversionName,
    this.reqDesc,
    this.reqStatus,
    this.parentId,
    this.verifyStock,
    this.verifyStatus,
    this.verifyBy,
    this.verifyById,
    this.verifyDate,
    this.verifyNote,
    this.changeItem,
    this.addItem,
    this.itemId,
    this.quantity,
    this.itemUnitConversionId,
    this.reqItemUnitConversionId,
    this.description,
    this.quantityOrder,
    this.quantityOut,
    this.quantityLocationUsed,
    this.quantityMoneyUsed,
    this.targetArrivalDate,
    this.isActive,
    this.isPriority,
    this.isOperational,
    this.status,
    this.statusStock,
    this.goodsReceiptStatus,
    this.relationableType,
    this.relationableId,
    this.machineCode,
    this.programmerNote,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? icGoodsRequestCode;
  int? reqItemId;
  String? reqItemName;
  num? reqStock;
  num? reqQuantity;
  int? reqUnitConversionId;
  String? reqUnitConversionName;
  String? reqDesc;
  int? reqStatus;
  String? parentId;
  num? verifyStock;
  int? verifyStatus;
  String? verifyBy;
  String? verifyById;
  String? verifyDate;
  String? verifyNote;
  int? changeItem;
  int? addItem;
  int? itemId;
  num? quantity;
  int? itemUnitConversionId;
  int? reqItemUnitConversionId;
  String? description;
  num? quantityOrder;
  num? quantityOut;
  num? quantityLocationUsed;
  num? quantityMoneyUsed;
  String? targetArrivalDate;
  int? isActive;
  int? isPriority;
  int? isOperational;
  int? status;
  int? statusStock;
  int? goodsReceiptStatus;
  String? relationableType;
  String? relationableId;
  String? machineCode;
  String? programmerNote;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  factory GoodRequestItemModel.fromJson(String str) =>
      GoodRequestItemModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GoodRequestItemModel.fromMap(Map<dynamic, dynamic> json) =>
      GoodRequestItemModel(
        id: json["id"] == null ? null : json["id"],
        icGoodsRequestCode: json["ic_goods_request_code"] == null
            ? null
            : json["ic_goods_request_code"],
        reqItemId: json["req_item_id"] == null ? null : json["req_item_id"],
        reqItemName:
            json["req_item_name"] == null ? null : json["req_item_name"],
        reqStock: json["req_stock"] == null ? null : json["req_stock"],
        reqQuantity: json["req_quantity"] == null ? null : json["req_quantity"],
        reqUnitConversionId: json["req_unit_conversion_id"] == null
            ? null
            : json["req_unit_conversion_id"],
        reqUnitConversionName: json["req_unit_conversion_name"] == null
            ? null
            : json["req_unit_conversion_name"],
        reqDesc: json["req_desc"] == null ? null : json["req_desc"],
        reqStatus: json["req_status"] == null ? null : json["req_status"],
        parentId: json["parent_id"],
        verifyStock: json["verify_stock"] == null ? null : json["verify_stock"],
        verifyStatus:
            json["verify_status"] == null ? null : json["verify_status"],
        verifyBy: json["verify_by"] == null ? null : json["verify_by"],
        verifyById: json["verify_by_id"] == null ? null : json["verify_by_id"],
        verifyDate: json["verify_date"] == null ? null : json["verify_date"],
        verifyNote: json["verify_note"],
        changeItem: json["change_item"] == null ? null : json["change_item"],
        addItem: json["add_item"] == null ? null : json["add_item"],
        itemId: json["item_id"] == null ? null : json["item_id"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        itemUnitConversionId: json["item_unit_conversion_id"] == null
            ? null
            : json["item_unit_conversion_id"],
        reqItemUnitConversionId: json["req_item_unit_conversion_id"] == null
            ? null
            : json["req_item_unit_conversion_id"],
        description: json["description"],
        quantityOrder:
            json["quantity_order"] == null ? null : json["quantity_order"],
        quantityOut: json["quantity_out"] == null ? null : json["quantity_out"],
        quantityLocationUsed: json["quantity_location_used"],
        quantityMoneyUsed: json["quantity_money_used"],
        targetArrivalDate: json["target_arrival_date"] == null
            ? null
            : json["target_arrival_date"],
        isActive: json["is_active"] == null ? null : json["is_active"],
        isPriority: json["is_priority"] == null ? null : json["is_priority"],
        isOperational:
            json["is_operational"] == null ? null : json["is_operational"],
        status: json["status"] == null ? null : json["status"],
        statusStock: json["status_stock"] == null ? null : json["status_stock"],
        goodsReceiptStatus: json["goods_receipt_status"] == null
            ? null
            : json["goods_receipt_status"],
        relationableType: json["relationable_type"],
        relationableId: json["relationable_id"],
        machineCode: json["machine_code"] == null ? null : json["machine_code"],
        programmerNote: json["programmer_note"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "ic_goods_request_code":
            icGoodsRequestCode == null ? null : icGoodsRequestCode,
        "req_item_id": reqItemId == null ? null : reqItemId,
        "req_item_name": reqItemName == null ? null : reqItemName,
        "req_stock": reqStock == null ? null : reqStock,
        "req_quantity": reqQuantity == null ? null : reqQuantity,
        "req_unit_conversion_id":
            reqUnitConversionId == null ? null : reqUnitConversionId,
        "req_unit_conversion_name":
            reqUnitConversionName == null ? null : reqUnitConversionName,
        "req_desc": reqDesc == null ? null : reqDesc,
        "req_status": reqStatus == null ? null : reqStatus,
        "parent_id": parentId,
        "verify_stock": verifyStock == null ? null : verifyStock,
        "verify_status": verifyStatus == null ? null : verifyStatus,
        "verify_by": verifyBy == null ? null : verifyBy,
        "verify_by_id": verifyById == null ? null : verifyById,
        "verify_date": verifyDate == null ? null : verifyDate,
        "verify_note": verifyNote,
        "change_item": changeItem == null ? null : changeItem,
        "add_item": addItem == null ? null : addItem,
        "item_id": itemId == null ? null : itemId,
        "quantity": quantity == null ? null : quantity,
        "item_unit_conversion_id":
            itemUnitConversionId == null ? null : itemUnitConversionId,
        "req_item_unit_conversion_id":
            reqItemUnitConversionId == null ? null : reqItemUnitConversionId,
        "description": description,
        "quantity_order": quantityOrder == null ? null : quantityOrder,
        "quantity_out": quantityOut == null ? null : quantityOut,
        "quantity_location_used": quantityLocationUsed,
        "quantity_money_used": quantityMoneyUsed,
        "target_arrival_date":
            targetArrivalDate == null ? null : targetArrivalDate,
        "is_active": isActive == null ? null : isActive,
        "is_priority": isPriority == null ? null : isPriority,
        "is_operational": isOperational == null ? null : isOperational,
        "status": status == null ? null : status,
        "status_stock": statusStock == null ? null : statusStock,
        "goods_receipt_status":
            goodsReceiptStatus == null ? null : goodsReceiptStatus,
        "relationable_type": relationableType,
        "relationable_id": relationableId,
        "machine_code": machineCode == null ? null : machineCode,
        "programmer_note": programmerNote,
        "deleted_at": deletedAt,
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
      };
}
