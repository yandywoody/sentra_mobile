import 'dart:convert';

class GoodsRequestModel {
  GoodsRequestModel({
    this.id,
    this.code,
    this.goodsRequester,
    this.prevGoodsRequester,
    this.goodsRequesterId,
    this.goodsTaker,
    this.goodsTakerId,
    this.goodsSubmitter,
    this.goodsSubmitterId,
    this.goodsWhTaker,
    this.goodsWhTakerId,
    this.processType,
    this.departmentId,
    this.prevDepartmentId,
    this.newDepartmentId,
    this.companyId,
    this.approvedBy,
    this.approvedById,
    this.transactionDate,
    this.itemOutDate,
    this.targetArrivalDate,
    this.note,
    this.foto,
    this.input,
    this.status,
    this.statusData,
    this.isActive,
    this.isReceived,
    this.requestVerify,
    this.requestVerifyBy,
    this.requestVerifyById,
    this.requestVerifyDate,
    this.requestVerifyNote,
    this.reportVerify,
    this.reportVerifyBy,
    this.reportVerifyById,
    this.reportVerifyDate,
    this.reportVerifyNote,
    this.editedReason,
    this.editedById,
    this.editedDate,
    this.canceledReasonId,
    this.canceledReqById,
    this.canceledNote,
    this.canceledById,
    this.canceledDate,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.relationableType,
    this.relationableId,
    this.programmerNote,
  });

  String? id;
  String? code;
  String? goodsRequester;
  String? prevGoodsRequester;
  String? goodsRequesterId;
  String? goodsTaker;
  String? goodsTakerId;
  String? goodsSubmitter;
  String? goodsSubmitterId;
  String? goodsWhTaker;
  String? goodsWhTakerId;
  int? processType;
  int? departmentId;
  String? prevDepartmentId;
  String? newDepartmentId;
  String? companyId;
  String? approvedBy;
  String? approvedById;
  String? transactionDate;
  String? itemOutDate;
  String? targetArrivalDate;
  String? note;
  String? foto;
  int? input;
  int? status;
  int? statusData;
  int? isActive;
  int? isReceived;
  int? requestVerify;
  String? requestVerifyBy;
  String? requestVerifyById;
  String? requestVerifyDate;
  String? requestVerifyNote;
  int? reportVerify;
  String? reportVerifyBy;
  String? reportVerifyById;
  String? reportVerifyDate;
  String? reportVerifyNote;
  String? editedReason;
  String? editedById;
  String? editedDate;
  String? canceledReasonId;
  String? canceledReqById;
  String? canceledNote;
  String? canceledById;
  String? canceledDate;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  String? relationableType;
  String? relationableId;
  String? programmerNote;

  factory GoodsRequestModel.fromJson(String str) =>
      GoodsRequestModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GoodsRequestModel.fromMap(Map<dynamic, dynamic> json) =>
      GoodsRequestModel(
        id: json["code"] == null ? null : json["code"],
        code: json["code"] == null ? null : json["code"],
        goodsRequester:
            json["goods_requester"] == null ? null : json["goods_requester"],
        prevGoodsRequester: json["prev_goods_requester"] == null
            ? null
            : json["prev_goods_requester"],
        goodsRequesterId: json["goods_requester_id"] == null
            ? null
            : json["goods_requester_id"],
        goodsTaker: json["goods_taker"] == null ? null : json["goods_taker"],
        goodsTakerId:
            json["goods_taker_id"] == null ? null : json["goods_taker_id"],
        goodsSubmitter:
            json["goods_submitter"] == null ? null : json["goods_submitter"],
        goodsSubmitterId: json["goods_submitter_id"] == null
            ? null
            : json["goods_submitter_id"],
        goodsWhTaker:
            json["goods_wh_taker"] == null ? null : json["goods_wh_taker"],
        goodsWhTakerId: json["goods_wh_taker_id"] == null
            ? null
            : json["goods_wh_taker_id"],
        processType: json["process_type"] == null ? null : json["process_type"],
        departmentId:
            json["department_id"] == null ? null : json["department_id"],
        prevDepartmentId: json["prev_department_id"] == null
            ? null
            : json["prev_department_id"],
        newDepartmentId: json["new_department_id"] == null
            ? null
            : json["new_department_id"],
        companyId: json["company_id"] == null ? null : json["company_id"],
        approvedBy: json["approved_by"] == null ? null : json["approved_by"],
        approvedById:
            json["approved_by_id"] == null ? null : json["approved_by_id"],
        transactionDate:
            json["transaction_date"] == null ? null : json["transaction_date"],
        itemOutDate:
            json["item_out_date"] == null ? null : json["item_out_date"],
        targetArrivalDate: json["target_arrival_date"] == null
            ? null
            : (json["target_arrival_date"]),
        note: json["note"] == null ? null : json["note"],
        foto: json["foto"] == null ? null : json["foto"],
        input: json["input"] == null ? null : json["input"],
        status: json["status"] == null ? null : json["status"],
        statusData: json["status_data"] == null ? null : json["status_data"],
        isActive: json["is_active"] == null ? null : json["is_active"],
        isReceived: json["is_received"] == null ? 0 : json["is_received"],
        requestVerify:
            json["request_verify"] == null ? null : json["request_verify"],
        requestVerifyBy: json["request_verify_by"] == null
            ? null
            : json["request_verify_by"],
        requestVerifyById: json["request_verify_by_id"] == null
            ? null
            : json["request_verify_by_id"],
        requestVerifyDate: json["request_verify_date"] == null
            ? null
            : json["request_verify_date"],
        requestVerifyNote: json["request_verify_note"] == null
            ? null
            : json["request_verify_note"],
        reportVerify:
            json["report_verify"] == null ? null : json["report_verify"],
        reportVerifyBy:
            json["report_verify_by"] == null ? null : json["report_verify_by"],
        reportVerifyById: json["report_verify_by_id"] == null
            ? null
            : json["report_verify_by_id"],
        reportVerifyDate: json["report_verify_date"] == null
            ? null
            : (json["report_verify_date"]),
        reportVerifyNote: json["report_verify_note"] == null
            ? null
            : json["report_verify_note"],
        editedReason:
            json["edited_reason"] == null ? null : json["edited_reason"],
        editedById: json["edited_by_id"] == null ? null : json["edited_by_id"],
        editedDate: json["edited_date"] == null ? null : json["edited_date"],
        canceledReasonId: json["canceled_reason_id"] == null
            ? null
            : json["canceled_reason_id"],
        canceledReqById: json["canceled_req_by_id"] == null
            ? null
            : json["canceled_req_by_id"],
        canceledNote:
            json["canceled_note"] == null ? null : json["canceled_note"],
        canceledById:
            json["canceled_by_id"] == null ? null : json["canceled_by_id"],
        canceledDate:
            json["canceled_date"] == null ? null : json["canceled_date"],
        deletedAt: json["deleted_at"] == null ? null : json["deleted_at"],
        createdAt: json["created_at"] == null ? null : (json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : (json["updated_at"]),
        relationableType: json["relationable_type"] == null
            ? null
            : json["relationable_type"],
        relationableId:
            json["relationable_id"] == null ? null : json["relationable_id"],
        programmerNote:
            json["programmer_note"] == null ? null : json["programmer_note"],
      );

  Map<String, dynamic> toMap() => {
        "id": code == null ? null : code,
        "code": code == null ? null : code,
        "goods_requester": goodsRequester == null ? null : goodsRequester,
        "prev_goods_requester":
            prevGoodsRequester == null ? null : prevGoodsRequester,
        "goods_requester_id":
            goodsRequesterId == null ? null : goodsRequesterId,
        "goods_taker": goodsTaker == null ? null : goodsTaker,
        "goods_taker_id": goodsTakerId == null ? null : goodsTakerId,
        "goods_submitter": goodsSubmitter == null ? null : goodsSubmitter,
        "goods_submitter_id":
            goodsSubmitterId == null ? null : goodsSubmitterId,
        "goods_wh_taker": goodsWhTaker == null ? null : goodsWhTaker,
        "goods_wh_taker_id": goodsWhTakerId == null ? null : goodsWhTakerId,
        "process_type": processType == null ? null : processType,
        "department_id": departmentId == null ? null : departmentId,
        "prev_department_id":
            prevDepartmentId == null ? null : prevDepartmentId,
        "new_department_id": newDepartmentId == null ? null : newDepartmentId,
        "company_id": companyId == null ? null : companyId,
        "approved_by": approvedBy == null ? null : approvedBy,
        "approved_by_id": approvedById == null ? null : approvedById,
        "transaction_date": transactionDate == null ? null : transactionDate,
        "item_out_date": itemOutDate == null ? null : itemOutDate,
        "target_arrival_date":
            targetArrivalDate == null ? null : targetArrivalDate,
        "note": note == null ? null : note,
        "foto": foto == null ? null : foto,
        "input": input == null ? null : input,
        "status": status == null ? null : status,
        "status_data": statusData == null ? null : statusData,
        "is_active": isActive == null ? null : isActive,
        "is_received": isReceived == null ? 0 : isReceived,
        "request_verify": requestVerify == null ? null : requestVerify,
        "request_verify_by": requestVerifyBy == null ? null : requestVerifyBy,
        "request_verify_by_id":
            requestVerifyById == null ? null : requestVerifyById,
        "request_verify_date":
            requestVerifyDate == null ? null : requestVerifyDate,
        "request_verify_note":
            requestVerifyNote == null ? null : requestVerifyNote,
        "report_verify": reportVerify == null ? null : reportVerify,
        "report_verify_by": reportVerifyBy == null ? null : reportVerifyBy,
        "report_verify_by_id":
            reportVerifyById == null ? null : reportVerifyById,
        "report_verify_date":
            reportVerifyDate == null ? null : reportVerifyDate,
        "report_verify_note":
            reportVerifyNote == null ? null : reportVerifyNote,
        "edited_reason": editedReason == null ? null : editedReason,
        "edited_by_id": editedById == null ? null : editedById,
        "edited_date": editedDate == null ? null : editedDate,
        "canceled_reason_id":
            canceledReasonId == null ? null : canceledReasonId,
        "canceled_req_by_id": canceledReqById == null ? null : canceledReqById,
        "canceled_note": canceledNote == null ? null : canceledNote,
        "canceled_by_id": canceledById == null ? null : canceledById,
        "canceled_date": canceledDate == null ? null : canceledDate,
        "deleted_at": deletedAt == null ? null : deletedAt,
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
        "relationable_type": relationableType == null ? null : relationableType,
        "relationable_id": relationableId == null ? null : relationableId,
        "programmer_note": programmerNote == null ? null : programmerNote,
      };
}
