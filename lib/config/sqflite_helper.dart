import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;

class SQFliteHelper {
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDatabase();
    return _db!;
  }

  initDatabase() async {
    io.Directory? documentDirectory = await getExternalStorageDirectory();
    String path = join(documentDirectory!.path, 'sentra_dev_0009227.db');
    var db = openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(tableUser);
      await db.execute(tableEmployee);
      await db.execute(tableMachines);
      await db.execute(tableActivity);
      await db.execute(tableInspectionCheck);
      await db.execute(tableGoodsRequest);
      await db.execute(tableKpi);
      await db.execute(tableKpiDetail);
      await db.execute(tableOnProgress);
      await db.execute(tableWoService);
      await db.execute(tableWoServiceEmployee);
      await db.execute(tableWoServiceRealization);
      await db.execute(tableWoInspection);
      await db.execute(tableWoInspectionEmployee);
      await db.execute(tableWoInspectionRealization);
      await db.execute(tableWoRepair);
      await db.execute(tableWoRepairEmployee);
      await db.execute(tableWoRepairRealization);
      await db.execute(tableWoProject);
      await db.execute(tableWoProjectDetail);
      await db.execute(tableWoProjectDetailEmployee);
      await db.execute(tableWoProjectDetailRealization);
      await db.execute(tableGoodsRequestItems);
      await db.execute(tableImageContent);
      await db.execute(tablePartUses);
      await db.execute(tableItems);
      await db.execute(tableItemLups);
      await db.execute(tableInspectionCheckRealization);
    });
    return db;
  }

  static const tableImageContent = """
    CREATE TABLE `image_content` (
      `id` char(36)    NULL,
      `relational_id` varchar(255)    NULL,
      `relational_type` varchar(255)   NULL,
      `path` varchar(255) NULL,
      `name` varchar(255)  NULL,
      `created_by` int(10)   NULL,
      `updated_by` int(10)   NULL,
      `created_at` timestamp NULL DEFAULT NULL,
      `updated_at` timestamp NULL DEFAULT NULL,
      `deleted_at` timestamp NULL DEFAULT NULL
    );""";

  static const tableItems = """
    CREATE TABLE `items` (
      `id` char(36)    NULL,
      `code` varchar(255)    NULL,
      `item_measure_id` varchar(255)   NULL,
      `name` varchar(255) NULL,
      `detail` varchar(255)  NULL,
      `slug` varchar(255)   NULL,
      `created_at` timestamp NULL DEFAULT NULL,
      `updated_at` timestamp NULL DEFAULT NULL,
      `deleted_at` timestamp NULL DEFAULT NULL
    );""";

  static const tablePartUses = """
    CREATE TABLE `eng_part_uses` (
      `id` char(36)    NULL,
      `usable_type` varchar(255)    NULL,
      `usable_id` varchar(255)   NULL,
      `item_id` int(10) NULL,
      `quantity` double(8,2)  NULL,
      `unit_conversion_id` varchar(255)  NULL,
      `is_lup` int(10)  NULL,
      `description` text  NULL,
      `is_active` int(10)  NULL,
      `created_by` int(10)   NULL,
      `updated_by` int(10)   NULL,
      `created_at` timestamp NULL DEFAULT NULL,
      `updated_at` timestamp NULL DEFAULT NULL,
      `deleted_at` timestamp NULL DEFAULT NULL
    );""";

  static const tableItemLups = """
    CREATE TABLE `eng_item_lups` (
      `id` char(36)  NULL,
      `item_id` varchar(255)  NULL,
      `created_by` int(10)   NULL,
      `updated_by` int(10)   NULL,
      `created_at` timestamp NULL DEFAULT NULL,
      `updated_at` timestamp NULL DEFAULT NULL,
      `deleted_at` timestamp NULL DEFAULT NULL
    );""";

  static const tableInspectionCheckRealization = """
    CREATE TABLE `eng_inspection_realization_checks` (
      `id` char(36)    NULL,
      `inspection_id` varchar(255)    NULL,
      `inspection_check_id` varchar(255)   NULL,
      `condition` int(10)   NULL,
      `description` text,
      `created_by` int(10)   NULL,
      `updated_by` int(10)   NULL,
      `created_at` timestamp NULL DEFAULT NULL,
      `updated_at` timestamp NULL DEFAULT NULL,
      `deleted_at` timestamp NULL DEFAULT NULL
    );""";

  static const tableUser = """
  CREATE TABLE `user` (
      `id` bigint(20)  NULL,
      `employee_id` varchar(191) DEFAULT NULL,
      `name` varchar(191) NULL,
      `password` varchar(191) NULL,
      `photo` varchar(191) DEFAULT NULL,
      `remember_token` varchar(100) DEFAULT NULL,
      `api_token` varchar(80) DEFAULT NULL,
      `last_logged_ip` varchar(191) DEFAULT NULL,
      `last_logged_at` datetime DEFAULT NULL,
      `is_active` tinyint(1) NULL DEFAULT '1',
      `created_by` int(10) NULL,
      `updated_by` int(10) NULL,
      `created_at` timestamp NULL DEFAULT NULL,
      `updated_at` timestamp NULL DEFAULT NULL,
      `deleted_at` timestamp NULL DEFAULT NULL
    );""";

  static const tableOnProgress = """
  CREATE TABLE `wo_onprogress` (
      `id` INTEGER PRIMARY KEY,
      `wo_id` varchar(255) DEFAULT NULL,
      `employee_id` varchar(255) DEFAULT NULL,
      `start_at` time  NULL,
      `pause_at` time  NULL,
      `finish_at` time  NULL,
      `duration_pause` int(11)  NULL,
      `duration` int(11)  NULL,
      `status` int(11) DEFAULT NULL,
      `created_at` varchar(255) DEFAULT NULL,
      `updated_at` varchar(255) DEFAULT NULL,
      `work_type` varchar(255)   DEFAULT NULL
    );""";

  static const tableKpi = """
    CREATE TABLE  `gnr_key_performance_indicator_results` (
      `id` char(36) NOT NULL,
      `employee_id` varchar(255) NOT NULL,
      `period` date NOT NULL,
      `score` double(8,2) NOT NULL,
      `value` varchar(255)   NOT NULL,
      `created_at` timestamp NULL,
      `updated_at` timestamp NULL
    );""";

  static const tableKpiDetail = """
    CREATE TABLE `gnr_key_performance_indicator_result_details` (
      `id` char(36)   NOT NULL,
      `result_id` varchar(255)  NULL,
      `code` varchar(255) NULL,
      `name` varchar(255) NULL,
      `numerator` text  ,
      `denominator` text  ,
      `category` varchar(255)  NOT NULL,
      `type` varchar(255)   NOT NULL,
      `result` double(8,2) NOT NULL,
      `weight` double(8,2) NOT NULL,
      `score` double(8,2) NOT NULL,
      `value` varchar(255)   NOT NULL,
      `created_at` timestamp NULL,
      `updated_at` timestamp NULL
    );""";

  static const tableGoodsRequest = """
    CREATE TABLE `wh_goods_requests` (
      `id` char(30) NULL,
      `code` char(20)  NOT NULL,
      `goods_requester` varchar(20)   DEFAULT NULL,
      `prev_goods_requester` varchar(50)   DEFAULT NULL,
      `goods_requester_id` varchar(50)   DEFAULT NULL,
      `goods_taker` varchar(20)   DEFAULT NULL,
      `goods_taker_id` varchar(50)   DEFAULT NULL,
      `goods_submitter` varchar(20)   NOT NULL,
      `goods_submitter_id` varchar(50)   DEFAULT NULL,
      `goods_wh_taker` varchar(20)   DEFAULT NULL,
      `goods_wh_taker_id` varchar(50)   DEFAULT NULL,
      `process_type` int(11) NOT NULL DEFAULT '1',
      `department_id` bigint(20) DEFAULT NULL,
      `prev_department_id` int(11) DEFAULT NULL,
      `new_department_id` int(11) DEFAULT NULL,
      `company_id` bigint(20) DEFAULT NULL,
      `approved_by` varchar(20)   DEFAULT NULL,
      `approved_by_id` varchar(50)   DEFAULT NULL,
      `transaction_date` datetime NOT NULL,
      `item_out_date` datetime DEFAULT NULL,
      `target_arrival_date` date DEFAULT NULL,
      `note` longtext  ,
      `foto` varchar(225)   DEFAULT NULL,
      `input` tinyint(4) NOT NULL DEFAULT '0',
      `status` int(11) NOT NULL DEFAULT '1',
      `status_data` int(11) NOT NULL DEFAULT '0',
      `is_active` tinyint(1) NOT NULL DEFAULT '1',
      `is_received` tinyint(1) NULL DEFAULT '0',
      `request_verify` int(11) NOT NULL DEFAULT '0',
      `request_verify_by` varchar(50)   DEFAULT NULL,
      `request_verify_by_id` varchar(50)   DEFAULT NULL,
      `request_verify_date` datetime DEFAULT NULL,
      `request_verify_note` longtext  ,
      `report_verify` int(11) DEFAULT '0',
      `report_verify_by` varchar(50)   DEFAULT NULL,
      `report_verify_by_id` varchar(50)   DEFAULT NULL,
      `report_verify_date` datetime DEFAULT NULL,
      `report_verify_note` longtext  ,
      `edited_reason` text  ,
      `edited_by_id` varchar(50)   DEFAULT NULL,
      `edited_date` datetime DEFAULT NULL,
      `canceled_reason_id` int(11) DEFAULT NULL,
      `canceled_req_by_id` varchar(50)   DEFAULT NULL,
      `canceled_note` longtext  ,
      `canceled_by_id` varchar(50)   DEFAULT NULL,
      `canceled_date` datetime DEFAULT NULL,
      `deleted_at` timestamp NULL DEFAULT NULL,
      `created_at` timestamp NULL DEFAULT NULL,
      `updated_at` timestamp NULL DEFAULT NULL,
      `relationable_type` varchar(255)   DEFAULT NULL,
      `relationable_id` char(36)   DEFAULT NULL,
      `programmer_note` longtext
    );""";

  static const tableGoodsRequestItems = """
    CREATE TABLE `wh_goods_request_items` (
      `id` bigint(20) NOT NULL ,
      `ic_goods_request_code` char(20)   NOT NULL,
      `req_item_id` bigint(20) DEFAULT NULL,
      `req_item_name` varchar(255)   DEFAULT NULL,
      `req_stock` double(12,2) DEFAULT '0.00',
      `req_quantity` double(12,2) DEFAULT '0.00',
      `req_unit_conversion_id` bigint(20) DEFAULT NULL,
      `req_unit_conversion_name` varchar(255)   DEFAULT NULL,
      `req_desc` longtext  ,
      `req_status` int(11) DEFAULT NULL,
      `parent_id` bigint(20) DEFAULT NULL,
      `verify_stock` float(12,2) DEFAULT NULL,
      `verify_status` tinyint(4) DEFAULT NULL,
      `verify_by` varchar(20)   DEFAULT NULL,
      `verify_by_id` varchar(50)   DEFAULT NULL,
      `verify_date` datetime DEFAULT NULL,
      `verify_note` text  ,
      `change_item` tinyint(4) NOT NULL DEFAULT '0',
      `add_item` tinyint(4) NOT NULL DEFAULT '0',
      `item_id` bigint(20) DEFAULT NULL,
      `quantity` double(12,2) DEFAULT '0.00',
      `item_unit_conversion_id` bigint(20) DEFAULT NULL,
      `req_item_unit_conversion_id` bigint(20) DEFAULT NULL,
      `description` text  ,
      `quantity_order` float DEFAULT NULL,
      `quantity_out` double(12,2) DEFAULT '0.00',
      `quantity_location_used` double(8,2) DEFAULT NULL,
      `quantity_money_used` double(8,2) DEFAULT NULL,
      `target_arrival_date` date DEFAULT NULL,
      `is_active` tinyint(1) NOT NULL DEFAULT '1',
      `is_priority` tinyint(1) NOT NULL DEFAULT '0',
      `is_operational` tinyint(1)  DEFAULT '0',
      `status` int(11) NOT NULL DEFAULT '1',
      `status_stock` int(11) NOT NULL DEFAULT '3',
      `goods_receipt_status` int(11) NOT NULL DEFAULT '0',
      `relationable_type` varchar(255)   DEFAULT NULL,
      `relationable_id` char(36)   DEFAULT NULL,
      `machine_code` char(100)   DEFAULT NULL,
      `programmer_note` longtext  ,
      `deleted_at` timestamp NULL DEFAULT NULL,
      `created_at` timestamp NULL DEFAULT NULL,
      `updated_at` timestamp NULL DEFAULT NULL
    );""";

  static const tableEmployee = """
  CREATE TABLE `hr_employees` (
      `id` char(36)    NULL,
      `recruitment_id` bigint(20)  DEFAULT NULL,
      `nik` varchar(50)    NULL,
      `name` varchar(191)    NULL,
      `foto` varchar(191)   DEFAULT NULL,
      `phone` varchar(191)   DEFAULT NULL,
      `mobile` varchar(191)   DEFAULT NULL,
      `email` varchar(191)   DEFAULT NULL,
      `identity_type_id` bigint(20)  DEFAULT NULL,
      `identity_number` varchar(191)   DEFAULT NULL,
      `birth_place` varchar(191)   DEFAULT NULL,
      `birth_date` varchar(191)   DEFAULT NULL,
      `gender` tinyint(4) DEFAULT NULL,
      `marital_id` bigint(20)  DEFAULT NULL,
      `blood_type_id` bigint(20)  DEFAULT NULL,
      `religion_id` bigint(20)  DEFAULT NULL,
      `address` text  ,
      `province_id` char(10)   DEFAULT NULL,
      `regency_id` char(10)   DEFAULT NULL,
      `postal_code` varchar(50)   DEFAULT NULL,
      `residential_status` tinyint(1) DEFAULT NULL,
      `residential_address` text  ,
      `residential_province_id` char(10)   DEFAULT NULL,
      `residential_regency_id` char(10)   DEFAULT NULL,
      `residential_postal_code` varchar(50)   DEFAULT NULL,
      `company_id` bigint(20)  DEFAULT NULL,
      `branch_id` bigint(20)  DEFAULT NULL,
      `department_id` bigint(20)  DEFAULT NULL,
      `job_position_id` bigint(20)  DEFAULT NULL,
      `employee_status_id` bigint(20)  DEFAULT NULL,
      `join_date` date DEFAULT NULL,
      `end_contract_date` date DEFAULT NULL,
      `office_hour_type` bigint(20)  DEFAULT NULL,
      `office_hour_id` bigint(20)  DEFAULT NULL,
      `group_id` bigint(20)  DEFAULT NULL,
      `approvals_line` varchar(50)   DEFAULT NULL,
      `pin` char(10)   DEFAULT NULL,
      `leave_at` date DEFAULT NULL,
      `npwp` varchar(191)   DEFAULT NULL,
      `ptkp_code` char(191)   DEFAULT NULL,
      `bank_id` bigint(20)  DEFAULT NULL,
      `bank_account` varchar(191)   DEFAULT NULL,
      `bank_account_holder` varchar(191)   DEFAULT NULL,
      `bpjs_tk` varchar(100)   DEFAULT NULL,
      `bpjs_ks` varchar(100)   DEFAULT NULL,
      `bpjs_ks_family` int(11) DEFAULT NULL,
      `salary_period` tinyint(4) DEFAULT NULL,
      `salary_type` tinyint(4) DEFAULT NULL ,
      `overtime_status` tinyint(4) DEFAULT NULL,
      `overtime_auto` double(8,2) DEFAULT NULL,
      `is_active` tinyint(1)  NULL DEFAULT '1',
      `created_by` bigint(20)   NULL,
      `updated_by` bigint(20)   NULL,
      `created_at` timestamp NULL DEFAULT NULL,
      `updated_at` timestamp NULL DEFAULT NULL,
      `deleted_at` timestamp NULL DEFAULT NULL
    );""";

  static const tableMachines = """
    CREATE TABLE `eng_machines` (
      `id` char(36)    NULL,
      `code` varchar(255)    NULL,
      `machine_area_code` varchar(255)    NULL,
      `machine_group_code` varchar(255)    NULL,
      `serial_number` varchar(255)   DEFAULT NULL,
      `brand` varchar(255)   DEFAULT NULL,
      `type` varchar(255)   DEFAULT NULL,
      `category` tinyint(4)  NULL DEFAULT '1',
      `year` varchar(255)   DEFAULT NULL,
      `note` varchar(255)   DEFAULT NULL,
      `capacity` float DEFAULT '0',
      `description` text  ,
      `is_dyeing` tinyint(4)  NULL DEFAULT '0',
      `is_active` tinyint(1)  NULL DEFAULT '1',
      `created_by` int(10)  NULL,
      `updated_by` int(10)  NULL,
      `created_at` timestamp NULL DEFAULT NULL,
      `updated_at` timestamp NULL DEFAULT NULL,
      `deleted_at` timestamp NULL DEFAULT NULL
  );""";

  static const tableActivity = """
    CREATE TABLE `eng_activities` (
      `id` char(36)    NULL,
      `group_code` varchar(255)    NULL,
      `department` tinyint(4)  NULL,
      `code` varchar(255)    NULL,
      `name` varchar(255)    NULL,
      `difficulty` varchar(255)    NULL,
      `point` double(8,2)  NULL,
      `score` double(8,2)  NULL,
      `description` text  ,
      `is_urgent` tinyint(1)  DEFAULT NULL,
      `is_active` tinyint(1)  NULL DEFAULT '1',
      `created_by` int(10)   NULL,
      `updated_by` int(10)   NULL,
      `created_at` timestamp NULL DEFAULT NULL,
      `updated_at` timestamp NULL DEFAULT NULL,
      `deleted_at` timestamp NULL DEFAULT NULL
    );""";

  static const tableInspectionCheck = """
    CREATE TABLE `eng_inspection_checks` (
      `id` char(36)    NULL,
      `name` varchar(255)    NULL,
      `category` varchar(255)   NULL,
      `description` text,
      `condition` int(10)   NULL,
      `created_by` int(10)   NULL,
      `updated_by` int(10)   NULL,
      `created_at` timestamp NULL DEFAULT NULL,
      `updated_at` timestamp NULL DEFAULT NULL,
      `deleted_at` timestamp NULL DEFAULT NULL
    );""";

  static const tableWoService = """
    CREATE TABLE `eng_services` (
      `id` char(36)    NULL,
      `relationable_type` varchar(255)   DEFAULT NULL,
      `relationable_id` char(36)   DEFAULT NULL,
      `code` varchar(255)    NULL,
      `group_code` varchar(255)    NULL,
      `machine_code` varchar(255)    NULL,
      `activity_code` varchar(255)   DEFAULT NULL,
      `inspection_id` varchar(255)   DEFAULT NULL,
      `executed_at` date  NULL,
      `start_at` time  NULL,
      `finish_at` time  NULL,
      `duration` int(11)  NULL,
      `duration_realization` int(11)  NULL,
      `score` double(8,2)  NULL,
      `point` double(8,2)  NULL DEFAULT '0.00',
      `need_electrician` tinyint(4) DEFAULT '0',
      `type` tinyint(4)  NULL DEFAULT '0',
      `description` varchar(255)   DEFAULT NULL,
      `is_active` tinyint(1)  NULL DEFAULT '1',
      `is_finish` tinyint(1)  NULL DEFAULT '0',
      `is_overtime` tinyint(1)  NULL DEFAULT '0',
      `is_admin_note` tinyint(1)  NULL DEFAULT '0',
      `admin_note` text  ,
      `is_suitable` tinyint(1) DEFAULT NULL,
      `created_by` int(10)   NULL,
      `updated_by` int(10)   NULL,
      `created_at` timestamp NULL DEFAULT NULL,
      `updated_at` timestamp NULL DEFAULT NULL,
      `deleted_at` timestamp NULL DEFAULT NULL,
      `duration_actual_team` varchar(255)   DEFAULT NULL,
      `work_type` varchar(255)   DEFAULT NULL
    );""";

  static const tableWoServiceEmployee = """
    CREATE TABLE `eng_service_employees` (
      `id` char(36)    NULL,
      `service_id` varchar(255)    NULL,
      `employee_id` varchar(255)    NULL,
      `created_by` int(10)   NULL,
      `updated_by` int(10)   NULL,
      `created_at` timestamp NULL DEFAULT NULL,
      `updated_at` timestamp NULL DEFAULT NULL,
      `deleted_at` timestamp NULL DEFAULT NULL
    );""";

  static const tableWoServiceRealization = """
    CREATE TABLE `eng_service_realizations` (
      `id` char(36)    NULL,
      `service_id` varchar(255)    NULL,
      `employee_id` varchar(255)    NULL,
      `start_at` time  NULL,
      `finish_at` time  NULL,
      `duration` int(11)  NULL,
      `effectivity` double(8,2) DEFAULT NULL,
      `point_effectivity` double(8,2) DEFAULT '0.00',
      `point` double(8,2) DEFAULT '0.00',
      `description` text  ,
      `is_finish` tinyint(1)  NULL DEFAULT '1',
      `created_by` int(10)   NULL,
      `updated_by` int(10)   NULL,
      `created_at` timestamp NULL DEFAULT NULL,
      `updated_at` timestamp NULL DEFAULT NULL,
      `deleted_at` timestamp NULL DEFAULT NULL
    );""";

  static const tableWoRepair = """
    CREATE TABLE `eng_repairs` (
      `id` char(36)    NULL,
      `relationable_type` varchar(255)   DEFAULT NULL,
      `relationable_id` char(36)   DEFAULT NULL,
      `code` varchar(255)    NULL,
      `group_code` varchar(255)    NULL,
      `machine_code` varchar(255)    NULL,
      `activity_code` varchar(255)   DEFAULT NULL,
      `inspection_id` varchar(255)   DEFAULT NULL,
      `executed_at` date  NULL,
      `start_at` time  NULL,
      `finish_at` time  NULL,
      `duration` int(11)  NULL,
      `duration_realization` int(11)  NULL,
      `score` double(8,2)  NULL,
      `point` double(8,2)  NULL DEFAULT '0.00',
      `description` text  ,
      `need_electrician` tinyint(4) DEFAULT '0',
      `type` tinyint(4)  NULL DEFAULT '0',
      `is_active` tinyint(1)  NULL DEFAULT '1',
      `is_finish` tinyint(1)  NULL DEFAULT '0',
      `is_overtime` tinyint(1)  NULL DEFAULT '0',
      `approved` tinyint(1)   NULL DEFAULT '0',
      `is_admin_note` tinyint(1)  NULL DEFAULT '0',
      `admin_note` text  ,
      `is_suitable` tinyint(1) DEFAULT NULL,
      `created_by` int(10)   NULL,
      `updated_by` int(10)   NULL,
      `created_at` timestamp NULL DEFAULT NULL,
      `updated_at` timestamp NULL DEFAULT NULL,
      `deleted_at` timestamp NULL DEFAULT NULL,
      `work_type` varchar(255)   DEFAULT NULL
    );""";

  static const tableWoRepairEmployee = """
    CREATE TABLE `eng_repair_employees` (
      `id` char(36)    NULL,
      `repair_id` varchar(255)    NULL,
      `employee_id` varchar(255)    NULL,
      `created_by` int(10)   NULL,
      `updated_by` int(10)   NULL,
      `created_at` timestamp NULL DEFAULT NULL,
      `updated_at` timestamp NULL DEFAULT NULL,
      `deleted_at` timestamp NULL DEFAULT NULL
    );""";

  static const tableWoRepairRealization = """
    CREATE TABLE `eng_repair_realizations` (
      `id` char(36)    NULL,
      `repair_id` varchar(255)    NULL,
      `employee_id` varchar(255)    NULL,
      `start_at` time  NULL,
      `finish_at` time  NULL,
      `duration` int(11)  NULL,
      `effectivity` double(8,2) DEFAULT NULL,
      `point_effectivity` double(8,2) DEFAULT '0.00',
      `point` double(8,2) DEFAULT '0.00',
      `description` text  ,
      `is_finish` tinyint(1)  NULL DEFAULT '1',
      `created_by` int(10)   NULL,
      `updated_by` int(10)   NULL,
      `created_at` timestamp NULL DEFAULT NULL,
      `updated_at` timestamp NULL DEFAULT NULL,
      `deleted_at` timestamp NULL DEFAULT NULL
    );""";

  static const tableWoInspection = """
    CREATE TABLE `eng_inspections` (
      `id` char(36)    NULL,
      `relationable_type` varchar(255)   DEFAULT NULL,
      `relationable_id` char(36)   DEFAULT NULL,
      `code` varchar(255)    NULL,
      `group_code` varchar(255)    NULL,
      `machine_code` varchar(255)   DEFAULT NULL,
      `executed_at` date  NULL,
      `status` tinyint(4)  NULL DEFAULT '0',
      `duration` int(11)  NULL,
      `duration_realization` int(11)  NULL,
      `score` double(8,2)  NULL,
      `point` double(8,2)  NULL DEFAULT '0.00',
      `description` varchar(255)   DEFAULT NULL,
      `is_active` tinyint(1)  NULL DEFAULT '1',
      `is_admin_note` tinyint(1)  NULL DEFAULT '0',
      `is_suitable` tinyint(1) DEFAULT NULL,
      `is_manual` tinyint(1)  NULL DEFAULT '1',
      `admin_note` text  ,
      `created_by` int(10)   NULL,
      `updated_by` int(10)   NULL,
      `created_at` timestamp NULL DEFAULT NULL,
      `updated_at` timestamp NULL DEFAULT NULL,
      `deleted_at` timestamp NULL DEFAULT NULL,
      `work_type` varchar(255)   DEFAULT NULL
    );""";

  static const tableWoInspectionEmployee = """
    CREATE TABLE `eng_inspection_employees` (
      `id` char(36)    NULL,
      `inspection_id` varchar(255)    NULL,
      `employee_id` varchar(255)    NULL,
      `created_by` int(10)   NULL,
      `updated_by` int(10)   NULL,
      `created_at` timestamp NULL DEFAULT NULL,
      `updated_at` timestamp NULL DEFAULT NULL,
      `deleted_at` timestamp NULL DEFAULT NULL
    );""";

  static const tableWoInspectionRealization = """
    CREATE TABLE `eng_inspection_realizations` (
      `id` char(36)    NULL,
      `inspection_id` varchar(255)    NULL,
      `employee_id` varchar(255)    NULL,
      `start_at` time  NULL,
      `finish_at` time  NULL,
      `duration` int(11)  NULL,
      `effectivity` double(8,2) DEFAULT NULL,
      `point_effectivity` double(8,2) DEFAULT '0.00',
      `point` double(8,2) DEFAULT '0.00',
      `description` text  ,
      `created_by` int(10)   NULL,
      `updated_by` int(10)   NULL,
      `created_at` timestamp NULL DEFAULT NULL,
      `updated_at` timestamp NULL DEFAULT NULL,
      `deleted_at` timestamp NULL DEFAULT NULL
    );""";

  static const tableWoProject = """
    CREATE TABLE `eng_projects` (
      `id` char(36)    NULL,
      `priority_code` varchar(255)    NULL,
      `group_code` varchar(255)    NULL,
      `applicant_id` varchar(255)    NULL,
      `leader_id` varchar(255)    NULL,
      `revision_from` varchar(255)   DEFAULT NULL,
      `code` varchar(255)    NULL,
      `name` varchar(255)    NULL,
      `location` varchar(255)    NULL,
      `duration` int(11)  NULL,
      `file` varchar(255)   DEFAULT NULL,
      `description` text  ,
      `status` tinyint(4)  NULL DEFAULT '0',
      `is_approve` tinyint(1)  NULL DEFAULT '0',
      `is_suitable` tinyint(1) DEFAULT NULL,
      `goods_received` tinyint(1)  NULL DEFAULT '0',
      `created_by` int(10)   NULL,
      `updated_by` int(10)   NULL,
      `verified_by` varchar(255)   DEFAULT NULL,
      `start_date` date  NULL,
      `finish_date` date  NULL,
      `completed_date` date DEFAULT NULL,
      `created_at` timestamp NULL DEFAULT NULL,
      `updated_at` timestamp NULL DEFAULT NULL,
      `deleted_at` timestamp NULL DEFAULT NULL,
      `work_type` varchar(255)   DEFAULT NULL
    );""";

  static const tableWoProjectDetail = """
    CREATE TABLE `eng_project_details` (
      `id` char(36)    NULL,
      `code` varchar(255)    NULL,
      `project_id` varchar(255)    NULL,
      `difficulty_id` varchar(255)    NULL,
      `name` varchar(255)    NULL ,
      `start_at` time  NULL,
      `finish_at` time  NULL,
      `duration` int(11) DEFAULT NULL,
      `duration_realization` int(11) DEFAULT NULL,
      `score` double(8,2)  NULL,
      `point` double(8,2)  NULL DEFAULT '0.00',
      `note` varchar(255)   DEFAULT NULL,
      `executed_at` date  NULL,
      `dates` text  ,
      `is_active` tinyint(1)  NULL DEFAULT '1',
      `is_suitable` tinyint(1) DEFAULT '0',
      `is_admin_note` tinyint(1)  NULL DEFAULT '0',
      `admin_note` text  ,
      `created_by` int(10)   NULL,
      `updated_by` int(10)   NULL,
      `created_at` timestamp NULL DEFAULT NULL,
      `updated_at` timestamp NULL DEFAULT NULL,
      `deleted_at` timestamp NULL DEFAULT NULL,
      `work_type` varchar(255)   DEFAULT NULL
    );""";

  static const tableWoProjectDetailEmployee = """
    CREATE TABLE `eng_project_detail_employees` (
      `id` char(36)    NULL,
      `project_detail_code` varchar(255)    NULL,
      `employee_id` varchar(255)    NULL,
      `created_by` int(10)   NULL,
      `updated_by` int(10)   NULL,
      `created_at` timestamp NULL DEFAULT NULL,
      `updated_at` timestamp NULL DEFAULT NULL,
      `deleted_at` timestamp NULL DEFAULT NULL
    );""";

  static const tableWoProjectDetailRealization = """
    CREATE TABLE `eng_project_detail_realizations` (
      `id` char(36)    NULL,
      `project_detail_id` varchar(255)    NULL,
      `employee_id` varchar(255)    NULL ,
      `executed_at` date  NULL,
      `start_at` time  NULL,
      `finish_at` time  NULL,
      `duration` int(11)  NULL,
      `effectivity` double(8,2) DEFAULT NULL,
      `point_effectivity` double(8,2) DEFAULT '0.00',
      `point` double(8,2) DEFAULT '0.00',
      `progress` int(11) DEFAULT '0',
      `description` text  ,
      `is_active` tinyint(1)  NULL DEFAULT '0',
      `created_by` int(10)   NULL,
      `updated_by` int(10)   NULL,
      `created_at` timestamp NULL DEFAULT NULL,
      `updated_at` timestamp NULL DEFAULT NULL,
      `deleted_at` timestamp NULL DEFAULT NULL
    );""";
}
