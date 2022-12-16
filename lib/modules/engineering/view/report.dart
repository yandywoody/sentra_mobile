import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sentra_mobile/modules/engineering/controller/report_controller.dart';

class Report extends GetView<ReportController> {
  Report({Key? key}) : super(key: key);
  final controller = Get.put(ReportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(
            "Report",
            style: TextStyle(fontSize: 30.0),
          ),
        ),
      ),
    );
  }
}
