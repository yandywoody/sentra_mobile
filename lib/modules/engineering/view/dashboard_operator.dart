import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:sentra_mobile/config/app_theme.dart';
import 'package:sentra_mobile/modules/engineering/controller/dashboard_operator_controller.dart';
import 'package:sentra_mobile/routes/app_routes.dart';

class DashboardOperator extends GetView<DashboardOperatorController> {
  DashboardOperator({Key? key}) : super(key: key);
  final controller = Get.put(DashboardOperatorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => (controller.isLoading.value)
            ? const CircularProgressIndicator()
            : NotificationListener(
                onNotification: (t) {
                  if (t is ScrollEndNotification) {
                    controller.isScroll.value = !controller.isScroll.value;
                  }

                  return true;
                },
                child: RefreshIndicator(
                  onRefresh: () async {
                    controller.reSyncData();
                  },
                  child: CustomScrollView(
                    physics: BouncingScrollPhysics(),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                            style: AppTheme
                                                                .lightText16),
                                                        const Spacer(),
                                                        Text(
                                                            "${controller.totalProgres.value} / ${controller.totalWo.value}",
                                                            style: AppTheme
                                                                .lightText10),
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
                                                                    Radius
                                                                        .circular(
                                                                            10)),
                                                            child:
                                                                LinearProgressIndicator(
                                                              backgroundColor:
                                                                  Colors.white,
                                                              value: controller
                                                                  .valueProgres
                                                                  .value,
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
                                                        "Update Terakhir: " +
                                                            DateFormat.yMMMd()
                                                                .format(DateTime
                                                                    .parse(controller
                                                                        .lastSync
                                                                        .value)) +
                                                            " " +
                                                            DateFormat.Hm().format(
                                                                DateTime.parse(
                                                                    controller
                                                                        .lastSync
                                                                        .value)),
                                                        style: AppTheme
                                                            .lightSubText10),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          const SizedBox(height: 15),
                                          Container(
                                            height: 62,
                                            width: 62,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFD9D9D9),
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: Colors.white),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        controller.onResultpage(
                                            AppRoute.getWoRepairRoute(), "");
                                      },
                                      child: Badge(
                                        showBadge:
                                            controller.dtRepair.length == 0
                                                ? false
                                                : true,
                                        position: BadgePosition.topEnd(
                                            top: 0, end: 3),
                                        animationDuration:
                                            const Duration(milliseconds: 700),
                                        animationType: BadgeAnimationType.slide,
                                        badgeContent: Text(
                                          controller.dtRepair.length.toString(),
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        child: Container(
                                          height: 90,
                                          padding: const EdgeInsets.all(5),
                                          child: Column(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color: AppTheme.warningColor,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: const Image(
                                                  height: 28,
                                                  image: AssetImage(
                                                      "assets/images/white repair.png"),
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              const Text(
                                                "Repair",
                                                style: AppTheme.lightSubText10,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        controller.onResultpage(
                                            AppRoute.getWoServiceRoute(), "");
                                      },
                                      child: Badge(
                                        showBadge:
                                            controller.dtServis.length == 0
                                                ? false
                                                : true,
                                        position: BadgePosition.topEnd(
                                            top: 0, end: 3),
                                        animationDuration:
                                            const Duration(milliseconds: 700),
                                        animationType: BadgeAnimationType.slide,
                                        badgeContent: Text(
                                          controller.dtServis.length.toString(),
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        child: Container(
                                          height: 90,
                                          padding: const EdgeInsets.all(5),
                                          child: Column(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color: AppTheme.infoColor,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: const Image(
                                                  height: 28,
                                                  image: AssetImage(
                                                      "assets/images/white maintenance.png"),
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              const Text(
                                                "Service",
                                                style: AppTheme.lightSubText10,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Badge(
                                      showBadge:
                                          controller.dtProject.length == 0
                                              ? false
                                              : true,
                                      position:
                                          BadgePosition.topEnd(top: 0, end: 3),
                                      animationDuration:
                                          const Duration(milliseconds: 700),
                                      animationType: BadgeAnimationType.slide,
                                      badgeContent: Text(
                                        controller.dtProject.length.toString(),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          controller.onResultpage(
                                              AppRoute.getWoProjectRoute(), "");
                                        },
                                        child: Container(
                                          height: 90,
                                          padding: const EdgeInsets.all(5),
                                          child: Column(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color: AppTheme.succesColor,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: const Image(
                                                  height: 28,
                                                  image: AssetImage(
                                                      "assets/images/white project.png"),
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              const Text(
                                                "Project",
                                                style: AppTheme.lightSubText10,
                                              ),
                                            ],
                                          ),
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
                                    top: Radius.circular(50),
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
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(32, 0, 32, 0),
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        if (controller
                                                .dtGoodRequestCheck.value >
                                            0) {
                                          controller.onResultpage(
                                              AppRoute.getItemCheckRoute(), "");
                                        }
                                      },
                                      child: Container(
                                        width: Get.width * 0.9,
                                        decoration: BoxDecoration(
                                          color: AppTheme.primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                            fit: BoxFit.fitWidth,
                                            colorFilter: ColorFilter.mode(
                                                Colors.white.withOpacity(0.1),
                                                BlendMode.dstATop),
                                            image: const AssetImage(
                                                "assets/images/banner-1.png"),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              spreadRadius: 2,
                                              blurRadius: 10,
                                              color:
                                                  Colors.black.withOpacity(0.1),
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        height: 63,
                                        padding: const EdgeInsets.all(12),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text("Perencanaan Barang",
                                                    style:
                                                        AppTheme.lightText16),
                                                const SizedBox(height: 5),
                                                Obx(
                                                  () => Text(
                                                      "${controller.dtGoodRequestReceived.value.toStringAsFixed(0)} / ${controller.dtGoodRequestCheck.value.toStringAsFixed(0)} Item Diterima",
                                                      style: AppTheme
                                                          .lightSubText10),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: const Icon(
                                                CupertinoIcons.cube_box_fill,
                                                color: Colors.white,
                                                size: 30,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                              const Padding(
                                padding: EdgeInsets.fromLTRB(32, 0, 32, 0),
                                child: Text(
                                  "Wo Hari Ini",
                                  style: AppTheme.text14opc20,
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(32, 0, 32, 0),
                                height: Get.height * 0.76,
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
                                    itemCount: (controller.dtWoAll.length > 7)
                                        ? 7
                                        : controller.dtWoAll.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Column(
                                        children: [
                                          const SizedBox(height: 10),
                                          Row(
                                            children: [
                                              InkWell(
                                                onTap: () => controller
                                                    .woDetail(controller
                                                        .dtWoAll[index]),
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(9),
                                                  width: Get.width * 0.83,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        color: Colors.grey,
                                                        blurRadius: 0.1,
                                                      ),
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5),
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(10),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: (controller.dtWoAll[index].workType ==
                                                                            "Service")
                                                                        ? AppTheme
                                                                            .infoColor
                                                                        : (controller.dtWoAll[index].workType ==
                                                                                "Repair")
                                                                            ? AppTheme.warningColor
                                                                            : AppTheme.succesColor,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                  ),
                                                                  child: Image(
                                                                    height: 28,
                                                                    image: AssetImage((controller.dtWoAll[index].workType ==
                                                                            "Repair")
                                                                        ? "assets/images/white repair.png"
                                                                        : (controller.dtWoAll[index].workType ==
                                                                                "Service")
                                                                            ? "assets/images/white maintenance.png"
                                                                            : "assets/images/white project.png"),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 12),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                "${controller.dtWoAll[index].machineCode ?? ''}",
                                                                style: AppTheme
                                                                    .text14,
                                                              ),
                                                              const SizedBox(
                                                                  height: 9),
                                                              Container(
                                                                width:
                                                                    Get.width *
                                                                        0.37,
                                                                child: Text(
                                                                  "${controller.dtWoAll[index].activityCode ?? '-'}",
                                                                  style: AppTheme
                                                                      .text10,
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                  height: 9),
                                                            ],
                                                          ),
                                                          Container(
                                                            height: 50,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Text(
                                                                  "${controller.dtWoAll[index].startAt ?? 0} - ${controller.dtWoAll[index].finishAt ?? 0}",
                                                                  style: AppTheme
                                                                      .text10opc50,
                                                                ),
                                                                const SizedBox(
                                                                    height: 4),
                                                                ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                  child:
                                                                      Container(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(5),
                                                                    color: (controller.dtWoAll[index].workType ==
                                                                            "Service")
                                                                        ? AppTheme
                                                                            .infoColor
                                                                        : (controller.dtWoAll[index].workType ==
                                                                                "Repair")
                                                                            ? AppTheme.warningColor
                                                                            : AppTheme.succesColor,
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
                                                                //                 .dtWoAll[
                                                                //                     index]
                                                                //                 .workType ==
                                                                //             "Repair")
                                                                //         ? Colors.amber[
                                                                //             700]
                                                                //         : (controller.dtWoAll[index].workType ==
                                                                //                 "Service")
                                                                //             ? Colors.blue[
                                                                //                 700]
                                                                //             : Colors
                                                                //                 .greenAccent[700],
                                                                //     child: Text(
                                                                //       "${controller.dtWoAll[index].workType ?? 0}",
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
            padding: const EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text("Menu Lainnya", style: AppTheme.titleLight),
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
                Container(
                  height: 100,
                  child: Scrollbar(
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            controller.onResultpage(
                                AppRoute.getWoAllRoute(), "");
                          },
                          child: Container(
                            height: 90,
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.blue[700],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(
                                    Icons.info,
                                    size: 30,
                                    color: AppTheme.bgColorLight,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  "Semua Wo",
                                  style: AppTheme.titleLight,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 7),
                        GestureDetector(
                          onTap: () {
                            controller.onResultpage(
                                AppRoute.getWoManualRoute(), "");
                          },
                          child: Container(
                            height: 90,
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.blue[700],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    size: 30,
                                    color: AppTheme.bgColorLight,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  "Manual Wo",
                                  style: AppTheme.titleLight,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            controller.onResultpage(
                                AppRoute.getTakeoverRoute(), "");
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
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            controller.onResultpage(
                                AppRoute.getWoHistoryRoute(), "");
                          },
                          child: Container(
                            height: 90,
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.teal,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(
                                    CupertinoIcons.time,
                                    size: 30,
                                    color: AppTheme.bgColorLight,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  "History Wo",
                                  style: AppTheme.titleLight,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
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
                        const SizedBox(width: 7),
                        GestureDetector(
                          onTap: () {
                            controller.submitData();
                          },
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
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
