import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sentra_mobile/config/app_theme.dart';
import 'package:sentra_mobile/modules/general/controller/kpi_controller.dart';

class Kpi extends GetView<KpiController> {
  Kpi({Key? key}) : super(key: key);
  final controller = Get.put(KpiController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fitWidth,
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.1), BlendMode.dstATop),
              image: AssetImage("assets/images/banner-1.png"),
            ),
          ),
        ),
        title: Text("KPI"),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back,
            color: AppTheme.bgColorLight,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(16, 25, 16, 0),
          child: Stack(
            children: [
              Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Center(
                          child: Container(
                            width: 130,
                            height: 150,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 4,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.1),
                                  offset: Offset(0, 19),
                                ),
                              ],
                              shape: BoxShape.circle,
                            ),
                            child: Lottie.asset(
                                'assets/animations/avatar-animation.json'),
                          ),
                        ),
                        Positioned(
                          top: 100,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                color: Colors.grey[400],
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  "${controller.loginEmployee.name}",
                                  style: AppTheme.text14,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 45),
                    Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: (controller.dtKpiChoose.score! > 70)
                            ? Colors.blue[700]
                            : (controller.dtKpiChoose.score! > 50)
                                ? Colors.amber[700]
                                : Colors.red[700],
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1),
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      height: 120,
                      padding: EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text("${controller.dtKpiChoose.score}",
                                  style: AppTheme.bigTitleLight),
                              SizedBox(height: 5),
                              Text("Score Akhir",
                                  style: AppTheme.subTitleLight),
                              SizedBox(height: 10),
                              Text("${controller.dtKpiChoose.period}",
                                  style: AppTheme.subTitleLight),
                            ],
                          ),
                          Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text("${controller.dtKpiChoose.value}",
                                    style: TextStyle(
                                        fontSize: 50,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 45),
                    Text(
                      "# Persentase",
                      style: AppTheme.title,
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    SizedBox(height: 15),
                    for (var i = 0; i < controller.dtKpi.length; i++)
                      if (controller.dtKpi.value[i].type == "percentage")
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${controller.dtKpi.value[i].name}",
                                  style: AppTheme.titleGrey,
                                ),
                                Text(
                                  "${controller.dtKpi.value[i].score} (${controller.dtKpi.value[i].value})",
                                  style: AppTheme.titleGrey,
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                          ],
                        ),
                    SizedBox(height: 35),
                    Text(
                      "Nilai Penambah",
                      style: AppTheme.title,
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    for (var i = 0; i < controller.dtKpi.length; i++)
                      if (controller.dtKpi.value[i].type == "extra point")
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${controller.dtKpi.value[i].name}",
                                  style: AppTheme.titleGrey,
                                ),
                                Text(
                                  "${controller.dtKpi.value[i].score} (${controller.dtKpi.value[i].value})",
                                  style: AppTheme.titleGrey,
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                          ],
                        ),
                    SizedBox(height: 35),
                    Text(
                      "Nilai Pengurang",
                      style: AppTheme.title,
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    SizedBox(height: 15),
                    for (var i = 0; i < controller.dtKpi.length; i++)
                      if (controller.dtKpi.value[i].type == "deduction")
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${controller.dtKpi.value[i].name}",
                                  style: AppTheme.titleGrey,
                                ),
                                Text(
                                  "${controller.dtKpi.value[i].score} (${controller.dtKpi.value[i].value})",
                                  style: AppTheme.titleGrey,
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                          ],
                        ),
                    SizedBox(height: 77),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
