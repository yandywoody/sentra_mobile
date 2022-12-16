import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sentra_mobile/config/app_theme.dart';
import 'package:sentra_mobile/modules/engineering/controller/wo_history_detail_controller.dart';
import 'package:sentra_mobile/modules/engineering/model/image_content_model.dart';
import 'package:sentra_mobile/routes/app_routes.dart';

class WoHistoryDetail extends GetView<WoHistoryDetailController> {
  WoHistoryDetail({Key? key}) : super(key: key);
  final controller = Get.put(WoHistoryDetailController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return Navigator.canPop(context);
      },
      child: Scaffold(
        bottomSheet: Container(
          color: Colors.transparent,
          width: Get.width,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(const EdgeInsets.all(9)),
                    minimumSize: MaterialStateProperty.all(
                      Size(Get.width * 0.1, 0),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(
                      Colors.grey[200],
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_back_ios,
                        color: AppTheme.primaryColor,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'kembali keberanda',
                        style: AppTheme.text14,
                      ),
                    ],
                  ),
                  onPressed: () => Get.offAllNamed(AppRoute.getHomeRoute()),
                )
              ],
            ),
          ),
        ),
        body: Obx(
          () => Container(
            color: Colors.grey[100],
            child: CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: <Widget>[
                SliverAppBar(
                  leading: IconButton(
                    onPressed: () => Get.offAllNamed(AppRoute.getHomeRoute()),
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: AppTheme.bgColorLight,
                    ),
                  ),
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
                                    'History WO',
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
                            borderRadius: const BorderRadius.vertical(
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
                                      "Kegiatan",
                                      style: AppTheme.text14opc20,
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "${controller.data.activityCode ?? 0}",
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
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            const SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text("Mesin",
                                                    style:
                                                        AppTheme.lightText14),
                                                Text(
                                                    "${controller.data.machineCode ?? 0}",
                                                    style:
                                                        AppTheme.yellowText14),
                                              ],
                                            ),
                                            const Divider(
                                                thickness: 0.5,
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
                                                    "${controller.woPlan.value.startAt}",
                                                    style:
                                                        AppTheme.yellowText14),
                                              ],
                                            ),
                                            const Divider(
                                                thickness: 0.5,
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
                                                    "${controller.woPlan.value.finishAt ?? 0}",
                                                    style:
                                                        AppTheme.yellowText14),
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
                                                    "${controller.woPlan.value.duration ?? 0} Min",
                                                    style:
                                                        AppTheme.yellowText14),
                                              ],
                                            ),
                                            // const Divider(
                                            //     thickness: 0.2,
                                            //     color: Colors.white),
                                            // Row(
                                            //   mainAxisAlignment:
                                            //       MainAxisAlignment
                                            //           .spaceBetween,
                                            //   children: [
                                            //     const Text("Tanggal",
                                            //         style:
                                            //             AppTheme.lightText14),
                                            //     Text(
                                            //         "${controller.data.executedAt ?? 0}",
                                            //         style:
                                            //             AppTheme.yellowText14),
                                            //   ],
                                            // ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    const Text(
                                      "Realisasi",
                                      style: AppTheme.text14opc20,
                                    ),
                                    const SizedBox(height: 10),
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
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            offset: Offset(0, 10),
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              Text("${controller.data.startAt}",
                                                  style: AppTheme.yellowText14),
                                              SizedBox(height: 5),
                                              Text("Mulai",
                                                  style: AppTheme.lightText14),
                                            ],
                                          ),
                                          SizedBox(width: 15),
                                          Column(
                                            children: [
                                              Text(
                                                  "${controller.data.finishAt}",
                                                  style: AppTheme.yellowText14),
                                              SizedBox(height: 5),
                                              Text("Akhir",
                                                  style: AppTheme.lightText14),
                                            ],
                                          ),
                                          SizedBox(width: 15),
                                          Column(
                                            children: [
                                              Text(
                                                  "${controller.data.duration} min",
                                                  style: AppTheme.yellowText14),
                                              SizedBox(height: 5),
                                              Text("Duration Real",
                                                  style: AppTheme.lightText14),
                                            ],
                                          ),
                                        ],
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
                                              const SizedBox(height: 10),
                                              Container(
                                                width: Get.width,
                                                height: 65,
                                                padding: EdgeInsets.all(12),
                                                decoration: BoxDecoration(
                                                  color: (!controller
                                                          .isGoodReceived.value)
                                                      ? Color(0xFFf7ab3b)
                                                      : Colors.blue[800],
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
                                                    InkWell(
                                                      onTap: () => Get.toNamed(
                                                          AppRoute
                                                              .getUpdateBarangRoute(),
                                                          arguments:
                                                              controller.data),
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            CupertinoIcons
                                                                .cube_box_fill,
                                                            color: Colors.white,
                                                          ),
                                                          SizedBox(width: 10),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                  "Penggunaan Barang untuk Wo ini",
                                                                  style: AppTheme
                                                                      .titleLight),
                                                              SizedBox(
                                                                  height: 3),
                                                              Text(
                                                                  "Klik untuk lihat detail",
                                                                  style: AppTheme
                                                                      .subTitleLight),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Column(
                                                      children: [
                                                        Text(
                                                            "${controller.dtGoodRequest.length}",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 20.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            )),
                                                        Text("Barang",
                                                            style: AppTheme
                                                                .titleLight),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        : Container(),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 16),
                                        const Text(
                                          "Status",
                                          style: AppTheme.text14opc20,
                                        ),
                                        const SizedBox(height: 10),
                                        Container(
                                          width: Get.width,
                                          height: 65,
                                          padding: EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color:
                                                (controller.data.isFinish == 1)
                                                    ? AppTheme.primaryColor
                                                    : Colors.red[800],
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
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    CupertinoIcons
                                                        .check_mark_circled,
                                                    color: Colors.white,
                                                    size: 30,
                                                  ),
                                                  SizedBox(width: 10),
                                                  Text("Selesai dengan status ",
                                                      style:
                                                          AppTheme.titleLight),
                                                  Text(
                                                      "${controller.data.isFinish == 1 ? 'Finish' : 'Un Finish'}",
                                                      style: AppTheme
                                                          .yellowText14),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 16),
                                        const Text(
                                          "Photo Realisasi",
                                          style: AppTheme.text14opc20,
                                        ),
                                        const SizedBox(height: 10),
                                        Container(
                                          width: Get.width,
                                          height: 230,
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
                                          child: Column(
                                            children: [
                                              Container(
                                                width: Get.width * 0.8,
                                                height: 150,
                                                color: AppTheme.primaryColor,
                                                child: GetBuilder<
                                                    WoHistoryDetailController>(
                                                  builder: (_) {
                                                    return controller
                                                                .imgContent !=
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
                                                                          .imgContent
                                                                          .length,
                                                                  itemBuilder: (BuildContext
                                                                              context,
                                                                          int index) =>
                                                                      GestureDetector(
                                                                    onTap: () => _viewFullImage(
                                                                        controller
                                                                            .imgContent[index],
                                                                        context),
                                                                    child: Card(
                                                                      child:
                                                                          Center(
                                                                        child: Image
                                                                            .file(
                                                                          File(controller
                                                                              .imgContent
                                                                              .value[index]
                                                                              .path!),
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
                                              Divider(thickness: 2),
                                              SizedBox(height: 10),
                                              (controller.imgContent.length >=
                                                      5)
                                                  ? Container()
                                                  : InkWell(
                                                      onTap: () {
                                                        controller.pickImage();
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons.add_circle,
                                                            color: AppTheme
                                                                .warningColor,
                                                          ),
                                                          SizedBox(width: 2),
                                                          Text(
                                                            "Tambah photo ",
                                                            style: AppTheme
                                                                .lightText14,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    (controller.data.description == null ||
                                            controller.data.description == '')
                                        ? Container()
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(height: 16),
                                              const Text(
                                                "Deskripsi",
                                                style: AppTheme.text14opc20,
                                              ),
                                              const SizedBox(height: 10),
                                              Container(
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
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            "${controller.data.description ?? ''}",
                                                            style: AppTheme
                                                                .lightText14,
                                                            textAlign: TextAlign
                                                                .justify,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                    SizedBox(height: 30),
                                    // InkWell(
                                    //   onTap: () => Get.offAllNamed(
                                    //       AppRoute.getHomeRoute()),
                                    //   child: Text(
                                    //     "Kembali ke beranda ..",
                                    //     style: TextStyle(
                                    //       fontStyle: FontStyle.italic,
                                    //       color: Colors.blue[700],
                                    //       fontSize: 15.0,
                                    //       fontWeight: FontWeight.w500,
                                    //     ),
                                    //   ),
                                    // ),
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
        ),
      ),
    );
  }

  void _choiceAction(String choice) {
    if (choice == "handover") {
      controller.data.workType = "Repair";
      Get.toNamed(AppRoute.getHandoverRoute(), arguments: controller.data);
    } else {
      Get.toNamed(AppRoute.getTakeoverRoute());
    }
  }

  _viewFullImage(ImageContentModel img, BuildContext context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      backgroundColor: AppTheme.primaryColor,
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
                    Text("Photo Detail", style: AppTheme.lightText14),
                    Spacer(),
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: Icon(
                        Icons.cancel,
                        color: AppTheme.bgColorLight,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10),
                GestureDetector(
                  child: Center(
                    child: Hero(
                        tag: "image",
                        child: Image.file(File(img.path.toString()))),
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
