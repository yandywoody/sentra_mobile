import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sentra_mobile/config/app_theme.dart';
import 'package:sentra_mobile/modules/engineering/controller/wo_history_controller.dart';
import 'package:sentra_mobile/routes/app_routes.dart';

class WoHistory extends GetView<WoHistoryController> {
  WoHistory({Key? key}) : super(key: key);
  final controller = Get.put(WoHistoryController());

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
          "Riwayat Work Order",
          style: AppTheme.titleLight,
        ),
        elevation: 1,
      ),
      body: Obx(
        () => (controller.dtWoAll.length == 0)
            ? Center(
                heightFactor: 1,
                child: Lottie.asset(
                  'assets/animations/no-data-animation.json',
                ),
              )
            : RefreshIndicator(
                onRefresh: () async {
                  controller.onLoading();
                },
                child: Container(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: controller.dtWoAll.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    if (controller.dtWoAll[index].workType ==
                                        "Inspeksi") {
                                      Get.toNamed(
                                          AppRoute
                                              .getWoHistoryInspectionDetailRoute(),
                                          arguments: controller.dtWoAll[index]);
                                    } else {
                                      print(controller.dtWoAll[index].id);
                                      Get.toNamed(
                                          AppRoute.getWoHistoryDetailRoute(),
                                          arguments: controller.dtWoAll[index]);
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(9),
                                    width: Get.width * 0.83,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 0.1,
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(5),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    decoration: BoxDecoration(
                                                      color: (controller
                                                                  .dtWoAll[
                                                                      index]
                                                                  .workType ==
                                                              "Service")
                                                          ? AppTheme.infoColor
                                                          : (controller
                                                                      .dtWoAll[
                                                                          index]
                                                                      .workType ==
                                                                  "Repair")
                                                              ? AppTheme
                                                                  .warningColor
                                                              : (controller
                                                                          .dtWoAll[
                                                                              index]
                                                                          .workType ==
                                                                      "Project")
                                                                  ? AppTheme
                                                                      .succesColor
                                                                  : AppTheme
                                                                      .infoColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Image(
                                                          height: 28,
                                                          image: AssetImage((controller
                                                                      .dtWoAll[
                                                                          index]
                                                                      .workType ==
                                                                  "Repair")
                                                              ? "assets/images/white repair.png"
                                                              : (controller
                                                                          .dtWoAll[
                                                                              index]
                                                                          .workType ==
                                                                      "Service")
                                                                  ? "assets/images/white maintenance.png"
                                                                  : (controller
                                                                              .dtWoAll[index]
                                                                              .workType ==
                                                                          "Project")
                                                                      ? "assets/images/white project.png"
                                                                      : "assets/images/white inspection.png"),
                                                        ),
                                                        Text(
                                                          (controller
                                                                      .dtWoAll[
                                                                          index]
                                                                      .workType ==
                                                                  "Repair")
                                                              ? "Repair"
                                                              : (controller
                                                                          .dtWoAll[
                                                                              index]
                                                                          .workType ==
                                                                      "Service")
                                                                  ? "Service"
                                                                  : (controller
                                                                              .dtWoAll[index]
                                                                              .workType ==
                                                                          "Project")
                                                                      ? "Project"
                                                                      : "Inspeksi",
                                                          style: AppTheme
                                                              .lightText7,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${controller.dtWoAll[index].machineCode ?? '-'}",
                                                  style: AppTheme.text14,
                                                ),
                                                const SizedBox(height: 9),
                                                Container(
                                                  width: Get.width * 0.37,
                                                  child: Obx(
                                                    () => Text(
                                                      (controller.dtWoAll[index]
                                                                  .activityCode ==
                                                              "")
                                                          ? "${controller.dtWoAll[index].code ?? '-'}"
                                                          : "${controller.dtWoAll[index].activityCode ?? '-'}",
                                                      style: AppTheme.text10,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 9),
                                              ],
                                            ),
                                            Container(
                                              height: 50,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    "${controller.dtWoAll[index].startAt ?? 0} - ${controller.dtWoAll[index].finishAt ?? 0}",
                                                    style: AppTheme.text10opc50,
                                                  ),
                                                  const SizedBox(height: 4),
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      color: (controller
                                                                  .dtWoAll[
                                                                      index]
                                                                  .workType ==
                                                              "Service")
                                                          ? AppTheme.infoColor
                                                          : (controller
                                                                      .dtWoAll[
                                                                          index]
                                                                      .workType ==
                                                                  "Repair")
                                                              ? AppTheme
                                                                  .warningColor
                                                              : (controller
                                                                          .dtWoAll[
                                                                              index]
                                                                          .workType ==
                                                                      "Project")
                                                                  ? AppTheme
                                                                      .succesColor
                                                                  : AppTheme
                                                                      .infoColor,
                                                      child: Text(
                                                        "${controller.dtWoAll[index].duration ?? 0} Min",
                                                        style: AppTheme
                                                            .lightText10,
                                                      ),
                                                    ),
                                                  ),
                                                  // SizedBox(
                                                  //     height: 4),
                                                  // ClipRRect(
                                                  //   borderRadius:
                                                  //       BorderRadius
                                                  //           .circular(
                                                  //               8),
                                                  //   child:
                                                  //       Container(
                                                  //     padding:
                                                  //         EdgeInsets
                                                  //             .all(
                                                  //                 5),
                                                  //     color: (controller
                                                  //                 .dtWo[
                                                  //                     index]
                                                  //                 .workType ==
                                                  //             "Repair")
                                                  //         ? Colors.amber[
                                                  //             700]
                                                  //         : (controller.dtWo[index].workType ==
                                                  //                 "Service")
                                                  //             ? Colors.blue[
                                                  //                 700]
                                                  //             : Colors
                                                  //                 .greenAccent[700],
                                                  //     child: Text(
                                                  //       "${controller.dtWo[index].workType ?? 0}",
                                                  //       style: AppTheme
                                                  //           .lightText7,
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
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
      ),
    );
  }
}
