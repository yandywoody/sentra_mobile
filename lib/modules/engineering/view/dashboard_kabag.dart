import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:sentra_mobile/config/app_theme.dart';
import 'package:sentra_mobile/modules/engineering/controller/dashboard_kabag_controller.dart';
import 'package:sentra_mobile/routes/app_routes.dart';

class DashboardKabag extends GetView<DashboardKabagController> {
  DashboardKabag({Key? key}) : super(key: key);
  final controller = Get.put(DashboardKabagController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener(
        onNotification: (t) {
          if (t is ScrollEndNotification) {
            controller.isScroll.value = !controller.isScroll.value;
          }

          return true;
        },
        child: Container(
          color: AppTheme.bgMenu,
          child: RefreshIndicator(
            onRefresh: () async {
              controller.reSyncData();
            },
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  bottom: PreferredSize(
                    child: Container(),
                    preferredSize: const Size(0, 20),
                  ),
                  pinned: false,
                  expandedHeight: Get.height * 0.37,
                  flexibleSpace: Stack(
                    children: [
                      Positioned(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: AppTheme.primaryColor,
                          ),
                        ),
                        top: 0,
                        left: 0,
                        right: 0,
                        bottom: 0,
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 32, top: 22, right: 32, bottom: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Image(
                                      height: 26,
                                      image: AssetImage(
                                          'assets/images/logo-smm__.png'),
                                    ),
                                    const SizedBox(height: 20),
                                    Obx(
                                      () => InkWell(
                                        onTap: () => Get.toNamed(
                                            AppRoute.getWoHistoryRoute()),
                                        child: SizedBox(
                                          width: Get.width * 0.41,
                                          height: 90,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(height: 7),
                                              Row(
                                                children: [
                                                  Text(
                                                      "Progress : ${(controller.valueProgres.value * 100).toStringAsFixed(0)}%",
                                                      style:
                                                          AppTheme.lightText16),
                                                  const Spacer(),
                                                  Text(
                                                      "${controller.totalProgres.value} / ${controller.totalWo.value}",
                                                      style:
                                                          AppTheme.lightText10),
                                                ],
                                              ),
                                              const SizedBox(height: 7),
                                              Stack(
                                                children: [
                                                  SizedBox(
                                                    height: 8,
                                                    width: 155,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  10)),
                                                      child:
                                                          LinearProgressIndicator(
                                                        backgroundColor:
                                                            Colors.white,
                                                        value: controller
                                                            .valueProgres.value,
                                                        valueColor:
                                                            const AlwaysStoppedAnimation(
                                                                AppTheme
                                                                    .succesColor),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                  "Last Update : " +
                                                      DateFormat.yMMMd().format(
                                                          DateTime.parse(
                                                              controller
                                                                  .lastSync
                                                                  .value)) +
                                                      " " +
                                                      DateFormat.Hm().format(
                                                          DateTime.parse(
                                                              controller
                                                                  .lastSync
                                                                  .value)),
                                                  style:
                                                      AppTheme.lightSubText10),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const SizedBox(height: 15),
                                    Container(
                                      height: 62,
                                      width: 62,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFD9D9D9),
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Colors.white),
                                      ),
                                      child: InkWell(
                                        onTap: () => Get.toNamed(
                                            AppRoute.getProfileRoute()),
                                        child: Lottie.asset(
                                            'assets/animations/avatar-animation.json'),
                                      ),
                                    ),
                                    const SizedBox(height: 5.0),
                                    Text(
                                      "${controller.loginEmployee.name ?? 0}",
                                      style: AppTheme.lightText10,
                                    ),
                                    const SizedBox(height: 5.0),
                                    Text(
                                      "${controller.loginEmployee.nik ?? 0} ${controller.isKadept}",
                                      style: AppTheme.lightSubText10,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Obx(
                                () => Badge(
                                  position:
                                      BadgePosition.topEnd(top: 0, end: 3),
                                  animationDuration:
                                      const Duration(milliseconds: 300),
                                  animationType: BadgeAnimationType.slide,
                                  badgeContent: Text(
                                    controller.dtInspeksi.length.toString(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  child: GestureDetector(
                                    onTap: () async {
                                      var result = await Get.toNamed(
                                          AppRoute.getWoInspectionRoute());
                                      controller.loadData();
                                    },
                                    child: Container(
                                      height: 90,
                                      padding: const EdgeInsets.all(5),
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: AppTheme.infoColor,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Image(
                                              height: 28,
                                              image: AssetImage(
                                                "assets/images/white inspection.png",
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          const Text(
                                            "Inspeksi",
                                            style: AppTheme.lightSubText10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  var result = await Get.toNamed(
                                      AppRoute.getWoAllRoute());
                                  controller.loadData();
                                },
                                child: Container(
                                  height: 90,
                                  padding: const EdgeInsets.all(5),
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: AppTheme.warningColor,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: const Icon(
                                          Icons.info,
                                          size: 30,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      const Text(
                                        "All Wo",
                                        style: AppTheme.lightSubText10,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  var result = await Get.toNamed(
                                      AppRoute.getWoManualRoute());
                                  controller.loadData();
                                },
                                child: Container(
                                  height: 90,
                                  padding: const EdgeInsets.all(5),
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: AppTheme.succesColor,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: const Icon(
                                          Icons.add,
                                          size: 30,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      const Text(
                                        "Manual",
                                        style: AppTheme.lightSubText10,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => _moreOption(context),
                                child: Container(
                                  height: 90,
                                  padding: const EdgeInsets.all(5),
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: AppTheme.bgMenu,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: const Image(
                                          height: 28,
                                          image: AssetImage(
                                              "assets/images/application.png"),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      const Text(
                                        "Lainnya",
                                        style: AppTheme.lightSubText10,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Positioned(
                        child: Container(
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                        ),
                        bottom: -1,
                        left: 0,
                        right: 0,
                      ),
                    ],
                  ),
                ),
                Obx(
                  () => SliverList(
                    delegate: SliverChildListDelegate(
                      <Widget>[
                        const Padding(
                          padding: EdgeInsets.fromLTRB(32, 0, 32, 0),
                          child: Text(
                            "Wo Hari Ini",
                            style: AppTheme.text14opc20,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
                          height: Get.height * 0.87,
                          child: NotificationListener(
                            onNotification: (t) {
                              if (t is ScrollEndNotification) {
                                controller.isScroll.value =
                                    !controller.isScroll.value;
                              }
                              return true;
                            },
                            child: ListView.builder(
                              controller: controller.scrollController,
                              physics: controller.isScroll.value
                                  ? const NeverScrollableScrollPhysics()
                                  : const BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: (controller.dtInspeksi.length > 5)
                                  ? 5
                                  : controller.dtInspeksi.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 10),
                                      InkWell(
                                        onTap: () => controller.woDetail(
                                            controller.dtInspeksi[index]),
                                        child: Container(
                                          padding: const EdgeInsets.all(9),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors.grey,
                                                blurRadius: 0.1,
                                              ),
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Row(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(5),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      decoration: BoxDecoration(
                                                        color:
                                                            AppTheme.infoColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Column(
                                                        children: [
                                                          Image(
                                                            height: 28,
                                                            image: AssetImage(
                                                              "assets/images/white inspection.png",
                                                            ),
                                                          ),
                                                          Text(
                                                            "Inspeksi",
                                                            style: AppTheme
                                                                .lightText10,
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
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    "${controller.dtInspeksi[index].machineCode ?? '-'}",
                                                    style: AppTheme.text14,
                                                  ),
                                                  const SizedBox(height: 15),
                                                  Text(
                                                    "${controller.dtInspeksi[index].code ?? 0}",
                                                    style: AppTheme.text10opc50,
                                                  ),
                                                  const SizedBox(height: 9),
                                                ],
                                              ),
                                              const SizedBox(width: 12),
                                              Spacer(),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      color: Colors.blue[700],
                                                      child: Text(
                                                        "${controller.dtInspeksi[index].duration ?? 0} Min",
                                                        style: AppTheme
                                                            .lightText10,
                                                      ),
                                                    ),
                                                  ),
                                                  // const SizedBox(height: 5),
                                                  // ClipRRect(
                                                  //   borderRadius:
                                                  //       BorderRadius.circular(10),
                                                  //   child: Container(
                                                  //     padding:
                                                  //         const EdgeInsets.all(5),
                                                  //     color: AppTheme.bgColorDark,
                                                  //     child: const Text(
                                                  //       "Inspeksi",
                                                  //       style:
                                                  //           AppTheme.lightText7,
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                  (controller.dtInspeksi[index]
                                                              .adminNote !=
                                                          "On Progress")
                                                      ? Container()
                                                      : Column(
                                                          children: [
                                                            const SizedBox(
                                                                width: 5),
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                              child: Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(5),
                                                                color: Colors
                                                                    .red[700],
                                                                child: Text(
                                                                  "${controller.dtInspeksi[index].adminNote ?? ''}",
                                                                  style: AppTheme
                                                                      .titleLight,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _moreOption(BuildContext context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: AppTheme.primaryColor,
      context: context,
      builder: (BuildContext bc) {
        return Container(
          height: Get.height * 0.3,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text("More Option", style: AppTheme.titleLight),
                    const Spacer(),
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: const Icon(
                        Icons.cancel,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => Get.toNamed(AppRoute.getTakeoverRoute()),
                      child: Container(
                        height: 90,
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppTheme.infoColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                CupertinoIcons.hand_raised,
                                size: 30,
                                color: AppTheme.bgColorLight,
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              "Takeover",
                              style: AppTheme.titleLight,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    GestureDetector(
                      onTap: () => controller.reSyncData(),
                      child: Container(
                        height: 90,
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppTheme.warningColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.update,
                                size: 30,
                                color: AppTheme.bgColorLight,
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              "Update",
                              style: AppTheme.titleLight,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    GestureDetector(
                      onTap: () => Get.toNamed(AppRoute.getSubmitDataRoute()),
                      child: Container(
                        height: 90,
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppTheme.dangerColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.sync,
                                size: 30,
                                color: AppTheme.bgColorLight,
                              ),
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              "Submition",
                              style: AppTheme.titleLight,
                            ),
                          ],
                        ),
                      ),
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
