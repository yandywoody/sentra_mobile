import 'package:sentra_mobile/config/sqflite_helper.dart';
import 'package:flutter/services.dart' show rootBundle;

class SyncRepository {
  final SQFliteHelper _sqFliteHelper = SQFliteHelper();

  Future<void> adduser() async {
    var dbClient = await _sqFliteHelper.db;
    dbClient.execute("DELETE FROM `user`;");
    String script = await rootBundle.loadString("assets/sql/core_user.sql");
    List<String> scripts = script.split(";");
    scripts.forEach((v) async {
      if (v.isNotEmpty || v != "") {
        if (v.length >= 5) {
          await dbClient.transaction((txn) async {
            dbClient.rawInsert(v.trim());
          });
        }
      }
    });
  }

  Future<void> addMchn() async {
    var dbClient = await _sqFliteHelper.db;
    dbClient.execute("DELETE FROM `eng_machines`;");
    String script = await rootBundle.loadString("assets/sql/eng_machines.sql");
    List<String> scripts = script.split(";");
    scripts.forEach((v) async {
      if (v.isNotEmpty || v != "") {
        if (v.length >= 5) {
          await dbClient.transaction((txn) async {
            dbClient.rawInsert(v.trim());
          });
        }
      }
    });
  }

  Future<void> addEmp() async {
    var dbClient = await _sqFliteHelper.db;
    dbClient.execute("DELETE FROM `hr_employees`;");
    String script = await rootBundle.loadString("assets/sql/hr_employees.sql");
    List<String> scripts = script.split(";");
    scripts.forEach((v) async {
      if (v.isNotEmpty || v != "") {
        if (v.length >= 5) {
          await dbClient.transaction((txn) async {
            dbClient.rawInsert(v.trim());
          });
        }
      }
    });
  }

  Future<void> addActivity() async {
    var dbClient = await _sqFliteHelper.db;
    dbClient.execute("DELETE FROM `eng_activities`;");
    String script =
        await rootBundle.loadString("assets/sql/eng_activities.sql");
    List<String> scripts = script.split(";");
    scripts.forEach((v) async {
      if (v.isNotEmpty || v != "") {
        if (v.length >= 5) {
          await dbClient.transaction((txn) async {
            dbClient.rawInsert(v.trim());
          });
        }
      }
    });
  }

  Future<void> addItems() async {
    var dbClient = await _sqFliteHelper.db;
    dbClient.execute("DELETE FROM `items`;");
    String script = await rootBundle.loadString("assets/sql/wh_items.sql");
    List<String> scripts = script.split(";");
    scripts.forEach((v) async {
      if (v.isNotEmpty || v != "") {
        if (v.length >= 5) {
          await dbClient.transaction((txn) async {
            dbClient.rawInsert(v.trim());
          });
        }
      }
    });
  }

  Future<void> addInspectionCheck() async {
    var dbClient = await _sqFliteHelper.db;
    dbClient.execute("DELETE FROM `eng_inspection_checks`;");
    String script =
        await rootBundle.loadString("assets/sql/eng_inspection_checks.sql");
    List<String> scripts = script.split(";");
    scripts.forEach((v) async {
      if (v.isNotEmpty || v != "") {
        if (v.length >= 5) {
          await dbClient.transaction((txn) async {
            dbClient.rawInsert(v.trim());
          });
        }
      }
    });
  }
}
