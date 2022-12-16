import 'dart:convert';

import 'package:sentra_mobile/model/employee_model.dart';
import 'package:sentra_mobile/model/user_model.dart';
import 'package:sentra_mobile/modules/engineering/model/activity_model.dart';
import 'package:sentra_mobile/modules/engineering/model/good_request_item_model.dart';
import 'package:sentra_mobile/modules/engineering/model/goods_request_model.dart';
import 'package:sentra_mobile/modules/engineering/model/inspection_check.dart';
import 'package:sentra_mobile/modules/engineering/model/machine_model.dart';
import 'package:sentra_mobile/modules/engineering/model/project_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_inspection_employee_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_inspection_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_project_employee_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_project_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_repair_employee_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_repair_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_service_employee_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_service_model.dart';
import 'package:sentra_mobile/modules/general/model/kpi_detail_model.dart';
import 'package:sentra_mobile/modules/general/model/kpi_model.dart';

class SyncModel {
  SyncModel({
    this.date,
    this.mUser,
    this.mEmployees,
    this.mMachines,
    this.mActivity,
    this.mInspectionCheck,
    this.kpi,
    this.kpiDetail,
    this.woService,
    this.woRepair,
    this.goodsRequest,
    this.goodsRequestItem,
    this.project,
    this.woProject,
    this.woInspection,
    this.woInspectionEmployee,
    this.woRepairEmployee,
    this.woServiceEmployee,
    this.woProjectEmployee,
  });

  DateTime? date;
  List<UserModel>? mUser;
  List<EmployeeModel>? mEmployees;
  List<MachineModel>? mMachines;
  List<ActivityModel>? mActivity;
  List<InspectionCheckModel>? mInspectionCheck;
  List<KpiModel>? kpi;
  List<KpiDetailModel>? kpiDetail;
  List<WoServiceModel>? woService;
  List<WoRepairModel>? woRepair;
  List<ProjectModel>? project;
  List<GoodsRequestModel>? goodsRequest;
  List<GoodRequestItemModel>? goodsRequestItem;
  List<WoProjectModel>? woProject;
  List<WoInspectionModel>? woInspection;
  List<WoInspectionEmployeeModel>? woInspectionEmployee;
  List<WoRepairEmployeeModel>? woRepairEmployee;
  List<WoServiceEmployeeModel>? woServiceEmployee;
  List<WoProjectEmployeeModel>? woProjectEmployee;

  factory SyncModel.fromJson(String str) => SyncModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SyncModel.fromMap(Map<String, dynamic> json) => SyncModel(
        date: DateTime.parse(json["date"]),
        mUser: List<UserModel>.from(
            json["m_user"].map((x) => UserModel.fromMap(x))),
        mEmployees: List<EmployeeModel>.from(
            json["m_employees"].map((x) => EmployeeModel.fromMap(x))),
        mMachines: List<MachineModel>.from(
            json["m_machines"].map((x) => MachineModel.fromMap(x))),
        mActivity: List<ActivityModel>.from(
            json["m_activity"].map((x) => ActivityModel.fromMap(x))),
        kpi: List<KpiModel>.from(json["kpi"].map((x) => KpiModel.fromMap(x))),
        kpiDetail: List<KpiDetailModel>.from(
            json["kpi_detail"].map((x) => KpiDetailModel.fromMap(x))),
        goodsRequest: List<GoodsRequestModel>.from(
            json["goods_request"].map((x) => GoodsRequestModel.fromMap(x))),
        goodsRequestItem: List<GoodRequestItemModel>.from(
            json["goods_request_items"]
                .map((x) => GoodRequestItemModel.fromMap(x))),
        mInspectionCheck: List<InspectionCheckModel>.from(
            json["inspection_check"]
                .map((x) => InspectionCheckModel.fromMap(x))),
        woService: List<WoServiceModel>.from(
            json["wo_service"].map((x) => WoServiceModel.fromMap(x))),
        woRepair: List<WoRepairModel>.from(
            json["wo_repair"].map((x) => WoRepairModel.fromMap(x))),
        project: List<ProjectModel>.from(
            json["wo_project"].map((x) => ProjectModel.fromMap(x))),
        woProject: List<WoProjectModel>.from(
            json["wo_project_detail"].map((x) => WoProjectModel.fromMap(x))),
        woInspection: List<WoInspectionModel>.from(
            json["wo_inspection"].map((x) => WoInspectionModel.fromMap(x))),
        woServiceEmployee: List<WoServiceEmployeeModel>.from(
            json["wo_service_employee"]
                .map((x) => WoServiceEmployeeModel.fromMap(x))),
        woRepairEmployee: List<WoRepairEmployeeModel>.from(
            json["wo_repair_employee"]
                .map((x) => WoRepairEmployeeModel.fromMap(x))),
        woProjectEmployee: List<WoProjectEmployeeModel>.from(
            json["wo_project_detail_employee"]
                .map((x) => WoProjectEmployeeModel.fromMap(x))),
        woInspectionEmployee: List<WoInspectionEmployeeModel>.from(
            json["wo_inspection_employee"]
                .map((x) => WoInspectionEmployeeModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "date": date,
        "m_user": List<UserModel>.from(mUser!.map((x) => x.toMap())),
        "m_employees":
            List<EmployeeModel>.from(mEmployees!.map((x) => x.toMap())),
        "m_machines": List<MachineModel>.from(mMachines!.map((x) => x.toMap())),
        "m_activity":
            List<ActivityModel>.from(mActivity!.map((x) => x.toMap())),
        "inspection_check": List<InspectionCheckModel>.from(
            mInspectionCheck!.map((x) => x.toMap())),
        "kpi": List<KpiModel>.from(kpi!.map((x) => x.toMap())),
        "kpi_detail":
            List<KpiDetailModel>.from(kpiDetail!.map((x) => x.toMap())),
        "goods_request":
            List<GoodsRequestModel>.from(goodsRequest!.map((x) => x.toMap())),
        "goods_request_item": List<GoodRequestItemModel>.from(
            goodsRequestItem!.map((x) => x.toMap())),
        "wo_project": List<ProjectModel>.from(project!.map((x) => x.toMap())),
        "wo_service":
            List<WoServiceModel>.from(woService!.map((x) => x.toMap())),
        "wo_repair": List<WoRepairModel>.from(woRepair!.map((x) => x.toMap())),
        "wo_project_detail":
            List<WoProjectModel>.from(woProject!.map((x) => x.toMap())),
        "wo_inspection":
            List<WoInspectionModel>.from(woInspection!.map((x) => x.toMap())),
        "wo_service_employee": List<WoServiceEmployeeModel>.from(
            woServiceEmployee!.map((x) => x.toMap())),
        "wo_repair_employee": List<WoRepairEmployeeModel>.from(
            woRepairEmployee!.map((x) => x.toMap())),
        "wo_project_detail_employee": List<WoProjectEmployeeModel>.from(
            woProjectEmployee!.map((x) => x.toMap())),
        "wo_inspection_employee": List<WoInspectionEmployeeModel>.from(
            woInspectionEmployee!.map((x) => x.toMap())),
      };
}
