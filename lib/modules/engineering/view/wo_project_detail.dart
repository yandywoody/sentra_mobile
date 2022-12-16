import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sentra_mobile/config/app_theme.dart';
import 'package:sentra_mobile/modules/engineering/controller/wo_project_detail_controller.dart';
import 'package:sentra_mobile/modules/engineering/controller/wo_service_detail_controller.dart';
import 'package:sentra_mobile/routes/app_routes.dart';

class WoProjectDetail extends GetView<WoProjectDetailController> {
  WoProjectDetail({Key? key}) : super(key: key);
  final controller = Get.put(WoProjectDetailController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        bottomSheet: Container(
          color: Colors.transparent,
          width: Get.width,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () => (controller.isStart.value)
                      ? PopupMenuButton(
                          onSelected: (String choice) {
                            _choiceAction(choice, context);
                          },
                          itemBuilder: (BuildContext context) {
                            return [
                              const PopupMenuItem(
                                value: 'pause',
                                child: ListTile(
                                  leading: Icon(CupertinoIcons.pause),
                                  title: Text("Pause", style: AppTheme.title),
                                ),
                              ),
                              const PopupMenuItem(
                                value: 'handover',
                                child: ListTile(
                                  leading: Icon(CupertinoIcons.hand_thumbsup),
                                  title:
                                      Text("Hand Over", style: AppTheme.title),
                                ),
                              ),
                              const PopupMenuItem(
                                value: 'unfinish',
                                child: ListTile(
                                  leading: Icon(CupertinoIcons.info),
                                  iconColor: Colors.red,
                                  title: Text("Unfinish Wo",
                                      style: AppTheme.title),
                                ),
                              ),
                            ];
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              color: Colors.grey[200],
                              child: const Icon(
                                Icons.more_horiz,
                                color: AppTheme.themeColor,
                              ),
                            ),
                          ),
                        )
                      : PopupMenuButton(
                          onSelected: (String choice) {
                            _choiceAction(choice, context);
                          },
                          itemBuilder: (BuildContext context) {
                            return [
                              const PopupMenuItem(
                                value: 'handover',
                                child: ListTile(
                                  leading: Icon(CupertinoIcons.hand_thumbsup),
                                  title:
                                      Text("Hand Over", style: AppTheme.title),
                                ),
                              ),
                              const PopupMenuItem(
                                value: 'requestitem',
                                child: ListTile(
                                  leading: Icon(CupertinoIcons.cube_box),
                                  title: Text("Request Item",
                                      style: AppTheme.title),
                                ),
                              ),
                            ];
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              color: Colors.grey[200],
                              child: const Icon(
                                Icons.more_horiz,
                                color: AppTheme.themeColor,
                              ),
                            ),
                          ),
                        ),
                ),
                const SizedBox(width: 10),
                Obx(
                  () => (!controller.isStart.value && !controller.isPause.value)
                      ? (controller.timeStop.value == "")
                          ? ElevatedButton(
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.all(20)),
                                minimumSize: MaterialStateProperty.all(
                                  Size(Get.width * 0.7, 40),
                                ),
                                backgroundColor: MaterialStateProperty.all(
                                  AppTheme.warningColor,
                                ),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                ),
                              ),
                              child: const Text('MULAI WORK ORDER'),
                              onPressed: () => controller.startTimer(),
                            )
                          : Row(
                              children: [
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      AppTheme.dangerColor,
                                    ),
                                    padding: MaterialStateProperty.all(
                                        const EdgeInsets.all(20)),
                                    minimumSize: MaterialStateProperty.all(
                                      Size(Get.width * 0.1, 40),
                                    ),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      const Text("Submit Wo",
                                          style: AppTheme.titleLight),
                                      const SizedBox(width: 5),
                                      const Icon(
                                        Icons.stop,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                  onPressed: () => controller.submitDone(),
                                ),
                                const SizedBox(width: 5),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      const Color(0xFFf7ab3b),
                                    ),
                                    padding: MaterialStateProperty.all(
                                        const EdgeInsets.all(20)),
                                    minimumSize: MaterialStateProperty.all(
                                      Size(Get.width * 0.1, 40),
                                    ),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                      ),
                                    ),
                                  ),
                                  child: const Icon(
                                    CupertinoIcons.cube_box_fill,
                                    color: Colors.white,
                                  ),
                                  onPressed: () => Get.toNamed(
                                      AppRoute.getUpdateBarangRoute(),
                                      arguments: controller.data),
                                ),
                                const SizedBox(width: 5),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        (controller.images != null)
                                            ? AppTheme.themeColor
                                            : const Color(0xFFf7ab3b)),
                                    padding: MaterialStateProperty.all(
                                        const EdgeInsets.all(20)),
                                    minimumSize: MaterialStateProperty.all(
                                      Size(Get.width * 0.1, 40),
                                    ),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                      ),
                                    ),
                                  ),
                                  child: const Icon(Icons.photo_camera_sharp),
                                  onPressed: () => controller.pickImage(),
                                ),
                              ],
                            )
                      : Row(
                          children: [
                            (controller.isPause.value)
                                ? ElevatedButton(
                                    style: ButtonStyle(
                                      padding: MaterialStateProperty.all(
                                          const EdgeInsets.all(20)),
                                      minimumSize: MaterialStateProperty.all(
                                        Size(Get.width * 0.2, 40),
                                      ),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                        AppTheme.succesColor,
                                      ),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                        ),
                                      ),
                                    ),
                                    child: const Text('RESUME'),
                                    onPressed: () => controller.resumeWo(),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Container(
                                      padding: const EdgeInsets.all(17),
                                      color: Colors.grey[200],
                                      child: Text(
                                        controller.hours.value +
                                            ":" +
                                            controller.minutes.value +
                                            ":" +
                                            controller.seconds.value,
                                        style: AppTheme.bigTitle,
                                      ),
                                    ),
                                  ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  const Color(0xFFf7ab3b),
                                ),
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.all(20)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                ),
                              ),
                              child: const Text('STOP'),
                              onPressed: () =>
                                  controller.stopTimer(controller.data, "done"),
                            )
                          ],
                        ),
                ),
              ],
            ),
          ),
        ),
        body: Obx(
          () => Container(
            color: Colors.grey[100],
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: <Widget>[
                SliverAppBar(
                  leading: (controller.isStart.value)
                      ? Container()
                      : IconButton(
                          onPressed: () => Get.back(result: ""),
                          icon: const Icon(
                            Icons.arrow_back,
                            color: AppTheme.bgColorLight,
                          ),
                        ),
                  bottom: PreferredSize(
                    preferredSize: const Size(0, 20),
                    child: Container(),
                  ),
                  pinned: false,
                  expandedHeight: Get.height * 0.20,
                  flexibleSpace: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          height: 150,
                          decoration: const BoxDecoration(
                            color: AppTheme.primaryColor,
                          ),
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Work Order',
                                    style: AppTheme.bigTitleLight,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "${controller.data.code ?? '-'}",
                                    style: AppTheme.bigSubTitleLight,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(40),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    <Widget>[
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 32, right: 32, top: 18),
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Kegiatan",
                                      style: AppTheme.text14opc20,
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "${controller.data.name ?? 0}",
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 16),
                                    const Text(
                                      "Detail",
                                      style: AppTheme.text14opc20,
                                    ),
                                    const SizedBox(height: 16),
                                    InkWell(
                                      onTap: () => Get.toNamed(
                                          AppRoute.getWoEmployeeRoute(),
                                          arguments: controller.data),
                                      child: Container(
                                        width: Get.width,
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: AppTheme.primaryColor,
                                          boxShadow: [
                                            BoxShadow(
                                              spreadRadius: 1,
                                              blurRadius: 10,
                                              color:
                                                  Colors.black.withOpacity(0.1),
                                              offset: const Offset(0, 10),
                                            ),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text("Score",
                                                      style:
                                                          AppTheme.lightText14),
                                                  Text(
                                                      "${controller.dtActivity.value.difficulty ?? 0}",
                                                      style: AppTheme
                                                          .yellowText14),
                                                ],
                                              ),
                                              const Divider(
                                                  thickness: 0.2,
                                                  color: Colors.white),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text("Mulai",
                                                      style:
                                                          AppTheme.lightText14),
                                                  Text(
                                                      "${controller.data.startAt ?? 0}",
                                                      style: AppTheme
                                                          .yellowText14),
                                                ],
                                              ),
                                              const Divider(
                                                  thickness: 0.2,
                                                  color: Colors.white),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text("Selesai",
                                                      style:
                                                          AppTheme.lightText14),
                                                  Text(
                                                      "${controller.data.finishAt ?? 0}",
                                                      style: AppTheme
                                                          .yellowText14),
                                                ],
                                              ),
                                              const Divider(
                                                  thickness: 0.2,
                                                  color: Colors.white),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text("Duration",
                                                      style:
                                                          AppTheme.lightText14),
                                                  Text(
                                                      "${controller.data.duration ?? 0} Min",
                                                      style: AppTheme
                                                          .yellowText14),
                                                ],
                                              ),
                                              const Divider(
                                                  thickness: 0.2,
                                                  color: Colors.white),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text("Tanggal",
                                                      style:
                                                          AppTheme.lightText14),
                                                  Text(
                                                      "${controller.data.executedAt ?? 0}",
                                                      style: AppTheme
                                                          .yellowText14),
                                                ],
                                              ),
                                              // Obx(
                                              //   () {
                                              //     return (controller
                                              //                 .statusWo.value ==
                                              //             "On Progress")
                                              //         ? Column(
                                              //             children: [
                                              //               const Divider(
                                              //                   thickness: 0.2,
                                              //                   color: Colors
                                              //                       .white),
                                              //               Row(
                                              //                 mainAxisAlignment:
                                              //                     MainAxisAlignment
                                              //                         .spaceBetween,
                                              //                 children: [
                                              //                   const Text(
                                              //                       "Status",
                                              //                       style: AppTheme
                                              //                           .lightText14),
                                              //                   Text(
                                              //                       "${controller.statusWo.value}",
                                              //                       style:
                                              //                           TextStyle(
                                              //                         color: Colors
                                              //                                 .red[
                                              //                             800],
                                              //                         fontSize:
                                              //                             15.0,
                                              //                         fontWeight:
                                              //                             FontWeight
                                              //                                 .w700,
                                              //                       )),
                                              //                 ],
                                              //               ),
                                              //             ],
                                              //           )
                                              //         : Container();
                                              //   },
                                              // ),
                                              const Divider(
                                                  thickness: 0.2,
                                                  color: Colors.white),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text("Karyawan",
                                                      style:
                                                          AppTheme.lightText14),
                                                  const Icon(
                                                    Icons.remove_red_eye,
                                                    color: Colors.white,
                                                  ),
                                                  SizedBox(width: 1),
                                                  Text(
                                                      "${controller.dtEmp.length}",
                                                      style: AppTheme
                                                          .yellowText14),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    (controller.dtGoodRequest.length > 0)
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(height: 16),
                                              const Text(
                                                "Barang yang diperlukan",
                                                style: AppTheme.text14opc20,
                                              ),
                                              const SizedBox(height: 16),
                                              InkWell(
                                                onTap: () async {
                                                  var result = await Get.toNamed(
                                                      AppRoute
                                                          .getItemCheckRoute(),
                                                      arguments:
                                                          controller.data);

                                                  controller.loadData();
                                                },
                                                child: Container(
                                                  width: Get.width,
                                                  height: 65,
                                                  padding:
                                                      const EdgeInsets.all(12),
                                                  decoration: BoxDecoration(
                                                    color: (!controller
                                                            .isGoodReceived
                                                            .value)
                                                        ? AppTheme.warningColor
                                                        : AppTheme.primaryColor,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        spreadRadius: 1,
                                                        blurRadius: 10,
                                                        color: Colors.black
                                                            .withOpacity(0.1),
                                                        offset:
                                                            const Offset(0, 10),
                                                      ),
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          const Icon(
                                                            CupertinoIcons
                                                                .cube_box_fill,
                                                            color: Colors.white,
                                                          ),
                                                          const SizedBox(
                                                              width: 5),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              const Text(
                                                                  "Penggunaan Barang untuk Wo ini",
                                                                  style: AppTheme
                                                                      .titleLight),
                                                              const SizedBox(
                                                                  height: 3),
                                                              const Text(
                                                                  "Klik untuk lihat detail",
                                                                  style: AppTheme
                                                                      .subTitleLight),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        children: [
                                                          Text(
                                                              "${controller.dtGoodRequest.length}",
                                                              style:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 20.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              )),
                                                          const Text("Barang",
                                                              style: AppTheme
                                                                  .titleLight),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Container(),
                                    Obx(
                                      () => (controller.isPause.value)
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(height: 16),
                                                const Text(
                                                  "Pause Point",
                                                  style: AppTheme.text14opc20,
                                                ),
                                                const SizedBox(height: 16),
                                                Container(
                                                  width: Get.width,
                                                  height: 65,
                                                  padding:
                                                      const EdgeInsets.all(12),
                                                  decoration: BoxDecoration(
                                                    color: AppTheme.succesColor,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        spreadRadius: 1,
                                                        blurRadius: 10,
                                                        color: Colors.black
                                                            .withOpacity(0.1),
                                                        offset:
                                                            const Offset(0, 10),
                                                      ),
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Text(
                                                              "${controller.dtOnProgress.value[0].startAt}",
                                                              style: AppTheme
                                                                  .yellowText14),
                                                          const SizedBox(
                                                              height: 5),
                                                          const Text("Mulai",
                                                              style: AppTheme
                                                                  .lightText14),
                                                        ],
                                                      ),
                                                      const SizedBox(width: 15),
                                                      Column(
                                                        children: [
                                                          Text(
                                                              "${controller.dtOnProgress.value[0].pauseAt}",
                                                              style: AppTheme
                                                                  .yellowText14),
                                                          const SizedBox(
                                                              height: 5),
                                                          const Text(
                                                              "Jam Pause",
                                                              style: AppTheme
                                                                  .lightText14),
                                                        ],
                                                      ),
                                                      const SizedBox(width: 15),
                                                      Column(
                                                        children: [
                                                          Text(
                                                              "${controller.dtOnProgress.value[0].durationPause} min",
                                                              style: AppTheme
                                                                  .yellowText14),
                                                          const SizedBox(
                                                              height: 5),
                                                          const Text(
                                                              "On Progress",
                                                              style: AppTheme
                                                                  .lightText14),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Container(),
                                    ),
                                    Obx(
                                      () => (controller.timeStart.value != "" &&
                                              !controller.isPause.value)
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(height: 16),
                                                const Text(
                                                  "Realisasi",
                                                  style: AppTheme.text14opc20,
                                                ),
                                                const SizedBox(height: 16),
                                                Container(
                                                  width: Get.width,
                                                  height: 65,
                                                  padding:
                                                      const EdgeInsets.all(12),
                                                  decoration: BoxDecoration(
                                                    color:
                                                        AppTheme.primaryColor,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        spreadRadius: 1,
                                                        blurRadius: 10,
                                                        color: Colors.black
                                                            .withOpacity(0.1),
                                                        offset:
                                                            const Offset(0, 10),
                                                      ),
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Text(
                                                              "${controller.timeStart.value}",
                                                              style: AppTheme
                                                                  .yellowText14),
                                                          const SizedBox(
                                                              height: 5),
                                                          const Text("Mulai",
                                                              style: AppTheme
                                                                  .lightText14),
                                                        ],
                                                      ),
                                                      const SizedBox(width: 15),
                                                      Column(
                                                        children: [
                                                          Text(
                                                              controller
                                                                  .timeStop
                                                                  .value,
                                                              style: AppTheme
                                                                  .yellowText14),
                                                          const SizedBox(
                                                              height: 5),
                                                          const Text("Akhir",
                                                              style: AppTheme
                                                                  .lightText14),
                                                        ],
                                                      ),
                                                      const SizedBox(width: 15),
                                                      Column(
                                                        children: [
                                                          Text(
                                                              "${controller.timeDuration.value} min",
                                                              style: AppTheme
                                                                  .yellowText14),
                                                          const SizedBox(
                                                              height: 5),
                                                          const Text(
                                                              "Duration Real",
                                                              style: AppTheme
                                                                  .lightText14),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Container(),
                                    ),
                                    Obx(
                                      () => (controller.timeStop.value != "")
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(height: 16),
                                                const Text(
                                                  "Photo ",
                                                  style: AppTheme.text14opc20,
                                                ),
                                                const SizedBox(height: 16),
                                                Container(
                                                  width: Get.width,
                                                  height: 150,
                                                  padding:
                                                      const EdgeInsets.all(12),
                                                  decoration: BoxDecoration(
                                                    color:
                                                        AppTheme.bgColorLight,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        spreadRadius: 1,
                                                        blurRadius: 10,
                                                        color: Colors.black
                                                            .withOpacity(0.1),
                                                        offset:
                                                            const Offset(0, 10),
                                                      ),
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  child: Container(
                                                    width: Get.width * 0.8,
                                                    height: 150,
                                                    color: Colors.white,
                                                    child: GetBuilder<
                                                        WoServiceDetailController>(
                                                      builder: (_) {
                                                        return controller
                                                                    .images !=
                                                                null
                                                            ? Row(
                                                                children: [
                                                                  Expanded(
                                                                    child: ListView
                                                                        .builder(
                                                                      shrinkWrap:
                                                                          true,
                                                                      scrollDirection:
                                                                          Axis.horizontal,
                                                                      itemCount: controller
                                                                          .images
                                                                          .length,
                                                                      itemBuilder:
                                                                          (BuildContext context, int index) =>
                                                                              GestureDetector(
                                                                        onTap: () => _viewFullImage(
                                                                            controller.images[index],
                                                                            context),
                                                                        child:
                                                                            Card(
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Image.file(
                                                                              File(controller.images[index].path),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                            : Container();
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Container(),
                                    ),
                                    const SizedBox(height: 100),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _choiceAction(String choice, BuildContext context) async {
    if (choice == "handover") {
      controller.data.workType = "Repair";
      if (controller.isStart.value) {
        Get.defaultDialog(
          title: "Warning",
          middleText:
              "Wo yang sedang berjalan akan dihentikan, apakah anda yakin?",
          textConfirm: "Handover",
          textCancel: "Batal",
          barrierDismissible: false,
          onConfirm: () {
            _handOverStop(context);
            //Get.back();
          },
        );
      } else {
        Get.toNamed(AppRoute.getHandoverRoute(), arguments: controller.data);
      }
    } else if (choice == "unfinish") {
      _unFinishEdit(context);
    } else if (choice == "pause") {
      controller.pauseWo();
    } else if (choice == "requestitem") {
      var result = await Get.toNamed(AppRoute.getAddItemRoute(),
          arguments: controller.data);

      controller.loadData();
    } else {
      Get.toNamed(AppRoute.getTakeoverRoute());
    }
  }

  _viewFullImage(File? img, BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext bc) {
        return Container(
          height: Get.height * 0.8,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text("Photo Detail", style: AppTheme.title),
                    const Spacer(),
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(
                        Icons.cancel,
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  child: Center(
                    child: Hero(tag: "image", child: Image.file(img!)),
                  ),
                  onTap: () {
                    Get.back();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _unFinishEdit(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext bc) {
        return Container(
          height: Get.height * 0.5,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text("Alasan un-finish", style: AppTheme.bigTitle),
                    const Spacer(),
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(
                        Icons.cancel,
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 15),
                Container(
                  width: Get.width,
                  child: TextField(
                    minLines: 6,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: controller.descEc,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        hintText: "Tulis Alasan kamu disini .."),
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(20)),
                        minimumSize: MaterialStateProperty.all(
                          Size(Get.width * 0.3, 40),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                      ),
                      child: const Text('Simpan'),
                      onPressed: () {
                        controller.isFinish.value = 0;
                        controller.stopTimer(controller.data, "unfinish");
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _handOverStop(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext bc) {
        return Container(
          height: Get.height * 0.5,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text("Alasan handover Wo", style: AppTheme.bigTitle),
                    const Spacer(),
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(
                        Icons.cancel,
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 15),
                Container(
                  width: Get.width,
                  child: TextField(
                    minLines: 6,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: controller.descEc,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        hintText: "Tulis Alasan kamu disini .."),
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(20)),
                        minimumSize: MaterialStateProperty.all(
                          Size(Get.width * 0.3, 40),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                      ),
                      child: const Text('Simpan'),
                      onPressed: () {
                        controller.isFinish.value = 0;
                        controller.stopTimer(controller.data, "handover");
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
