import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sentra_mobile/config/app_theme.dart';
import 'package:sentra_mobile/modules/engineering/controller/wo_inspection_detail_controller.dart';
import 'package:sentra_mobile/routes/app_routes.dart';

class WoInspectionDetail extends GetView<WoInspectionDetailController> {
  WoInspectionDetail({Key? key}) : super(key: key);
  final controller = Get.put(WoInspectionDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        color: Colors.transparent,
        width: Get.width,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PopupMenuButton(
                onSelected: _choiceAction,
                itemBuilder: (BuildContext context) {
                  return const [
                    PopupMenuItem(
                      child: ListTile(
                        leading: Icon(CupertinoIcons.hand_thumbsup),
                        title: Text("Hand Over", style: AppTheme.title),
                      ),
                      value: 'handover',
                    ),
                    PopupMenuItem(
                      child: ListTile(
                        leading: Icon(CupertinoIcons.checkmark),
                        title: Text("Perubahan Check", style: AppTheme.title),
                      ),
                      value: 'perubahancheck',
                    ),
                  ];
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    color: Colors.grey[200],
                    child: Icon(
                      Icons.more_horiz,
                      color: AppTheme.themeColor,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Obx(
                () => (!controller.isStart.value)
                    ? (controller.timeStop.value == "")
                        ? ElevatedButton(
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.all(20)),
                              minimumSize: MaterialStateProperty.all(
                                Size(Get.width * 0.7, 40),
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                Color(0xFFf7ab3b),
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                              ),
                            ),
                            child: Text('MULAI WORK ORDER'),
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
                                      borderRadius: BorderRadius.circular(18.0),
                                    ),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Text("Submit Wo",
                                        style: AppTheme.titleLight),
                                    SizedBox(width: 5),
                                    Icon(
                                      Icons.stop,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                                onPressed: () => controller.submitDone(),
                              ),
                              SizedBox(width: 5),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    Color(0xFFf7ab3b),
                                  ),
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.all(20)),
                                  minimumSize: MaterialStateProperty.all(
                                    Size(Get.width * 0.1, 40),
                                  ),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ),
                                  ),
                                ),
                                child: Icon(
                                  CupertinoIcons.check_mark,
                                  color: Colors.white,
                                ),
                                onPressed: () => Get.toNamed(
                                    AppRoute.getInspectionCheckRoute(),
                                    arguments: controller.data),
                              ),
                              SizedBox(width: 5),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      (controller.images != null)
                                          ? AppTheme.themeColor
                                          : Color(0xFFf7ab3b)),
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.all(20)),
                                  minimumSize: MaterialStateProperty.all(
                                    Size(Get.width * 0.1, 40),
                                  ),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ),
                                  ),
                                ),
                                child: Icon(Icons.photo_camera_sharp),
                                onPressed: () => controller.pickImage(),
                              ),
                            ],
                          )
                    : Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              padding: EdgeInsets.all(10),
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
                          SizedBox(width: 5),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Color(0xFFf7ab3b),
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
                            child: Text('STOP'),
                            onPressed: () =>
                                controller.stopTimer(controller.data),
                          )
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        color: Colors.grey[100],
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: <Widget>[
            SliverAppBar(
              bottom: PreferredSize(
                child: Container(),
                preferredSize: Size(0, 20),
              ),
              pinned: false,
              expandedHeight: Get.height * 0.20,
              flexibleSpace: Stack(
                children: [
                  Positioned(
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor,
                      ),
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Work Order',
                                style: AppTheme.bigTitleLight,
                              ),
                              SizedBox(height: 10),
                              Text(
                                "${controller.data.code ?? '-'}",
                                style: AppTheme.bigSubTitleLight,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                  ),
                  Positioned(
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(40),
                        ),
                      ),
                    ),
                    bottom: 0,
                    left: 0,
                    right: 0,
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
                                  "Kode Inspeksi ",
                                  style: AppTheme.text14opc20,
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "${controller.data.code ?? 0}",
                                        style: TextStyle(
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
                                Container(
                                  width: Get.width,
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: AppTheme.primaryColor,
                                    boxShadow: [
                                      BoxShadow(
                                        spreadRadius: 1,
                                        blurRadius: 10,
                                        color: Colors.black.withOpacity(0.1),
                                        offset: Offset(0, 10),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Inspeksi seteleh ${controller.woType}",
                                              style: AppTheme.lightText14,
                                            ),
                                          ],
                                        ),
                                        const Divider(
                                            thickness: 0.5,
                                            color: Colors.white),
                                        SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Mesin",
                                                style: AppTheme.lightText14),
                                            Text(
                                                "${controller.data.machineCode ?? 0}",
                                                style: AppTheme.yellowText14),
                                          ],
                                        ),
                                        const Divider(
                                            thickness: 0.5,
                                            color: Colors.white),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Score",
                                                style: AppTheme.lightText14),
                                            Text(
                                                "${controller.data.score ?? 0}",
                                                style: AppTheme.yellowText14),
                                          ],
                                        ),
                                        const Divider(
                                            thickness: 0.5,
                                            color: Colors.white),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Duration",
                                                style: AppTheme.lightText14),
                                            Text(
                                                "${controller.data.duration ?? 0} Min",
                                                style: AppTheme.yellowText14),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Obx(
                                  () => (controller.timeStart.value != "")
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
                                              padding: EdgeInsets.all(12),
                                              decoration: BoxDecoration(
                                                color: AppTheme.primaryColor,
                                                boxShadow: [
                                                  BoxShadow(
                                                    spreadRadius: 1,
                                                    blurRadius: 10,
                                                    color: Colors.black
                                                        .withOpacity(0.1),
                                                    offset: Offset(0, 10),
                                                  ),
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(15),
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
                                                      SizedBox(height: 5),
                                                      Text("Mulai",
                                                          style: AppTheme
                                                              .lightText14),
                                                    ],
                                                  ),
                                                  SizedBox(width: 15),
                                                  Column(
                                                    children: [
                                                      Text(
                                                          "${controller.timeStop.value}",
                                                          style: AppTheme
                                                              .yellowText14),
                                                      SizedBox(height: 5),
                                                      Text("Akhir",
                                                          style: AppTheme
                                                              .lightText14),
                                                    ],
                                                  ),
                                                  SizedBox(width: 15),
                                                  Column(
                                                    children: [
                                                      Text(
                                                          "${controller.timeDuration.value} min",
                                                          style: AppTheme
                                                              .yellowText14),
                                                      SizedBox(height: 5),
                                                      Text("Duration Real",
                                                          style: AppTheme
                                                              .lightSubText10),
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
                                              "Photo realisasi",
                                              style: AppTheme.text14opc20,
                                            ),
                                            const SizedBox(height: 16),
                                            Container(
                                              width: Get.width,
                                              height: 150,
                                              padding: EdgeInsets.all(12),
                                              decoration: BoxDecoration(
                                                color: AppTheme.bgColorLight,
                                                boxShadow: [
                                                  BoxShadow(
                                                    spreadRadius: 1,
                                                    blurRadius: 10,
                                                    color: Colors.black
                                                        .withOpacity(0.1),
                                                    offset: Offset(0, 10),
                                                  ),
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: Container(
                                                width: Get.width * 0.8,
                                                height: 150,
                                                color: Colors.white,
                                                child: GetBuilder<
                                                    WoInspectionDetailController>(
                                                  builder: (_) {
                                                    return controller.images !=
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
                                                                  itemCount:
                                                                      controller
                                                                          .images
                                                                          .length,
                                                                  itemBuilder: (BuildContext
                                                                              context,
                                                                          int index) =>
                                                                      GestureDetector(
                                                                    onTap: () => _viewFullImage(
                                                                        controller
                                                                            .images[index],
                                                                        context),
                                                                    child: Card(
                                                                      child:
                                                                          Center(
                                                                        child: Image
                                                                            .file(
                                                                          File(controller
                                                                              .images[index]
                                                                              .path),
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
                                const SizedBox(height: 16),
                                const Text(
                                  "Deskripsi",
                                  style: AppTheme.text14opc20,
                                ),
                                const SizedBox(height: 16),
                                Container(
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: AppTheme.primaryColor,
                                    boxShadow: [
                                      BoxShadow(
                                        spreadRadius: 1,
                                        blurRadius: 10,
                                        color: Colors.black.withOpacity(0.1),
                                        offset: Offset(0, 10),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Html(
                                                data:
                                                    "${controller.data.description ?? ''}",
                                                style: {
                                                  "body": Style(
                                                      fontSize: FontSize(14),
                                                      color:
                                                          AppTheme.bgColorLight,
                                                      fontWeight:
                                                          FontWeight.normal)
                                                }),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                // (controller.timeStart.value != "")
                                //     ? Container()
                                //     : Column(
                                //         children: [
                                //           SizedBox(height: 50),
                                //           InkWell(
                                //             onTap: () => Get.toNamed(
                                //                 AppRoute.getHomeRoute()),
                                //             child: Text(
                                //               "Kembali ke beranda ..",
                                //               style: TextStyle(
                                //                 fontStyle: FontStyle.italic,
                                //                 color: Colors.blue[700],
                                //                 fontSize: 15.0,
                                //                 fontWeight: FontWeight.w500,
                                //               ),
                                //             ),
                                //           ),
                                //         ],
                                //       ),
                                SizedBox(height: 100),
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
    );
  }

  void _choiceAction(String choice) {
    controller.data.workType = "Inspection";
    if (choice == "handover") {
      Get.toNamed(AppRoute.getHandoverRoute(), arguments: controller.data);
    } else {
      Get.toNamed(AppRoute.getInspectionCheckRoute(),
          arguments: controller.data);
    }
  }

  _viewFullImage(File? img, BuildContext context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
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
                    Text("Photo Detail", style: AppTheme.title),
                    Spacer(),
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: Icon(
                        Icons.cancel,
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10),
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
}
