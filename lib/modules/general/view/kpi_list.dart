import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sentra_mobile/config/app_theme.dart';
import 'package:sentra_mobile/modules/general/controller/kpi_list_controller.dart';
import 'package:sentra_mobile/routes/app_routes.dart';

class KpiList extends GetView<KpiListController> {
  KpiList({Key? key}) : super(key: key);
  final controller = Get.put(KpiListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
        title: Text(
          "Key Performance Indicator",
          style: AppTheme.titleLight,
        ),
        elevation: 1,
      ),
      body: Obx(
        () => (controller.dtKpi.length == 0)
            ? Center(
                heightFactor: 1,
                child: Lottie.asset(
                  'assets/animations/no-data-animation.json',
                ),
              )
            : Container(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: controller.dtKpi.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 3, right: 3),
                      child: Column(
                        children: [
                          SizedBox(height: 2),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(2),
                                height: 75,
                                decoration: BoxDecoration(
                                  color: (controller.dtKpi[index].score! > 70)
                                      ? Colors.blue[700]
                                      : (controller.dtKpi[index].score! > 50)
                                          ? Colors.amber[700]
                                          : Colors.red[700],
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => controller
                                    .kpiDetail(controller.dtKpi[index]),
                                child: Column(
                                  children: [
                                    SizedBox(height: 5),
                                    Container(
                                      width: Get.width * 0.97,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(3),
                                        boxShadow: [
                                          BoxShadow(
                                            spreadRadius: 2,
                                            blurRadius: 10,
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      height: 80,
                                      padding: EdgeInsets.only(
                                          left: 20,
                                          top: 10,
                                          right: 20,
                                          bottom: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                  "${controller.dtKpi[index].score}",
                                                  style: AppTheme.bigTitle),
                                              SizedBox(height: 10),
                                              Text(
                                                  "${controller.dtKpi[index].period}",
                                                  style: AppTheme.subTitle),
                                            ],
                                          ),
                                          Stack(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color: Colors.transparent,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Text(
                                                    "${controller.dtKpi[index].value}",
                                                    style: TextStyle(
                                                      fontSize: 40,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: (controller
                                                                  .dtKpi[index]
                                                                  .score! >
                                                              70)
                                                          ? Colors.blue[700]
                                                          : (controller
                                                                      .dtKpi[
                                                                          index]
                                                                      .score! >
                                                                  50)
                                                              ? Colors
                                                                  .amber[700]
                                                              : Colors.red[700],
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
