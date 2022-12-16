import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:searchfield/searchfield.dart';
import 'package:sentra_mobile/config/app_theme.dart';
import 'package:sentra_mobile/modules/engineering/controller/wo_all_controller.dart';
import 'package:sentra_mobile/modules/engineering/model/machine_model.dart';
import 'package:sentra_mobile/routes/app_routes.dart';

class WoAll extends GetView<WoAllController> {
  WoAll({Key? key}) : super(key: key);
  final controller = Get.put(WoAllController());

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
          "All Work Order",
          style: AppTheme.titleLight,
        ),
        elevation: 1,
        leading: IconButton(
          onPressed: () => Get.back(result: ""),
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppTheme.bgColorLight,
          ),
        ),
      ),
      body: Obx(
        () => (controller.dtWoAll.length == 0)
            ? Column(
                children: [
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            "Total Wo : ${controller.dtWoAll.length}",
                            style: AppTheme.title,
                          ),
                        ),
                        SizedBox(width: 20),
                        InkWell(
                          onTap: () => _filterData(context),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(9),
                            child: Container(
                              padding: EdgeInsets.all(7),
                              color: Colors.blue[700],
                              child: Row(
                                children: [
                                  Icon(Icons.filter_alt, color: Colors.white),
                                  Container(
                                    child: Text(
                                      "Filter",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    heightFactor: 1,
                    child: Lottie.asset(
                      'assets/animations/no-data-animation.json',
                    ),
                  ),
                ],
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              "Total Wo : ${controller.dtWoAll.length}",
                              style: AppTheme.title,
                            ),
                          ),
                          SizedBox(width: 20),
                          InkWell(
                            onTap: () => _filterData(context),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(9),
                              child: Container(
                                padding: EdgeInsets.all(7),
                                color: AppTheme.warningColor,
                                child: Row(
                                  children: [
                                    Icon(Icons.filter_alt, color: Colors.white),
                                    Container(
                                      child: Text(
                                        "Filter",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      height: Get.height * 0.8,
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
                                      onTap: () => controller
                                          .woDetail(controller.dtWoAll[index]),
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: (controller
                                                                      .dtWoAll[
                                                                          index]
                                                                      .workType ==
                                                                  "Service")
                                                              ? AppTheme
                                                                  .infoColor
                                                              : (controller
                                                                          .dtWoAll[
                                                                              index]
                                                                          .workType ==
                                                                      "Repair")
                                                                  ? AppTheme
                                                                      .warningColor
                                                                  : AppTheme
                                                                      .succesColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: Image(
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
                                                                  : "assets/images/white project.png"),
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
                                                      child: Text(
                                                        "${controller.dtWoAll[index].activityCode ?? '-'}",
                                                        style: AppTheme.text10,
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
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
                                                        style: AppTheme
                                                            .text10opc50,
                                                      ),
                                                      const SizedBox(height: 4),
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5),
                                                          color: (controller
                                                                      .dtWoAll[
                                                                          index]
                                                                      .workType ==
                                                                  "Service")
                                                              ? AppTheme
                                                                  .infoColor
                                                              : (controller
                                                                          .dtWoAll[
                                                                              index]
                                                                          .workType ==
                                                                      "Repair")
                                                                  ? AppTheme
                                                                      .warningColor
                                                                  : AppTheme
                                                                      .succesColor,
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
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  _filterData(BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext bc) {
        return Container(
          height: Get.height * 0.85,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(21),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.filter_alt, color: AppTheme.warningColor),
                      Text(" - Filter Data", style: AppTheme.title),
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
                  SizedBox(height: 20),
                  Text("Work Type", style: AppTheme.title),
                  SizedBox(height: 10),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: Color(0xFFe7edeb),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Obx(
                        () => DropdownButton(
                          hint: Text("Pilih Tipe Work Order"),
                          value: controller.frmWorkType.value,
                          onChanged: (String? newValue) {
                            controller.setWorkType(newValue!);
                          },
                          icon: Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Icon(Icons.arrow_circle_down_sharp),
                          ),
                          underline: Container(),
                          items: controller.dtWorkType.map((selectedType) {
                            return DropdownMenuItem(
                              child: new Text(
                                selectedType,
                              ),
                              value: selectedType,
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text("Activity Wo", style: AppTheme.title),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: Color(0xFFe7edeb),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Container(
                          width: Get.width * 0.7,
                          child: TextFormField(
                            controller: controller.acvtEc,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Color(0xFFe7edeb),
                              hintText: "Pilih Activity WO",
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(12)),
                          minimumSize: MaterialStateProperty.all(
                            Size(Get.width * 0.1, 40),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                            AppTheme.warningColor,
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        child: Icon(
                          Icons.search,
                          size: 33,
                        ),
                        onPressed: () {
                          _chooseActivity(context);
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text("Mesin", style: AppTheme.title),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: Color(0xFFe7edeb),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Container(
                          width: Get.width * 0.7,
                          child: TextFormField(
                            controller: controller.mchnEc,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Color(0xFFe7edeb),
                              hintText: "Pilih Mesin",
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(12)),
                          minimumSize: MaterialStateProperty.all(
                            Size(Get.width * 0.1, 40),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                            AppTheme.warningColor,
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        child: Icon(
                          Icons.search,
                          size: 33,
                        ),
                        onPressed: () {
                          _chooseMachine(context);
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text("Operator", style: AppTheme.title),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: Color(0xFFe7edeb),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Container(
                          width: Get.width * 0.7,
                          child: TextFormField(
                            controller: controller.optEc,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Color(0xFFe7edeb),
                              hintText: "Pilih Operator",
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(12)),
                          minimumSize: MaterialStateProperty.all(
                            Size(Get.width * 0.1, 40),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                            AppTheme.warningColor,
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        child: Icon(
                          CupertinoIcons.person,
                          size: 33,
                        ),
                        onPressed: () {
                          _chooseOpt(context);
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(width: 15),
                      ElevatedButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(13)),
                          minimumSize: MaterialStateProperty.all(
                            Size(Get.width * 0.2, 40),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                            AppTheme.warningColor,
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.search,
                              size: 23,
                            ),
                            Text('Search'),
                          ],
                        ),
                        onPressed: () {
                          controller.filterData();
                          Get.back();
                        },
                      ),
                      SizedBox(width: 5),
                      ElevatedButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(13)),
                          minimumSize: MaterialStateProperty.all(
                            Size(Get.width * 0.2, 40),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                            Colors.grey[500],
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.cancel,
                              size: 23,
                            ),
                            Text(' Reset'),
                          ],
                        ),
                        onPressed: () {
                          controller.frmWorkType.value = "All";
                          controller.acvtEc.text = "";
                          controller.mchnEc.text = "";
                          controller.optEc.text = "";
                          controller.fetchWo();
                          Get.back();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _chooseMachine(BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext bc) {
        return SingleChildScrollView(
          child: Container(
            height: Get.height * 0.95,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(11),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Pilih Mesin", style: AppTheme.title),
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
                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.only(left: 18, right: 18, top: 18),
                      child: TextField(
                        controller: controller.sMachineEc,
                        onChanged: controller.searchDataMachine,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          hintText: "Search",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Obx(
                      () => Container(
                        height: Get.height * 0.7,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: controller.dtMachine.length,
                          itemBuilder: (BuildContext context, int i) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Column(
                                children: [
                                  SizedBox(height: 10),
                                  InkWell(
                                    onTap: () {
                                      controller.mchnEc.text = controller
                                          .dtMachine[i].code
                                          .toString();
                                      Get.back();
                                      //_filterData(context);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(9),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 0.1,
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(19),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: Container(
                                                  padding: EdgeInsets.all(18),
                                                  child: Icon(
                                                    Icons.roller_shades,
                                                    size: 15,
                                                    color: Colors.white,
                                                  ),
                                                  color: Colors.amber[700],
                                                ),
                                              ),
                                              SizedBox(width: 13),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: Get.width * 0.5,
                                                    child: Text(
                                                        "${controller.dtMachine[i].code}",
                                                        style: AppTheme.title),
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
          ),
        );
      },
    );
  }

  _chooseActivity(BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext bc) {
        return SingleChildScrollView(
          child: Container(
            height: Get.height * 0.95,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(11),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Pilih Activity", style: AppTheme.title),
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
                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.only(left: 18, right: 18, top: 18),
                      child: TextField(
                        controller: controller.sActivityEc,
                        onChanged: controller.searchDataActivity,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          hintText: "Search",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Obx(
                      () => Container(
                        height: Get.height * 0.7,
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: controller.dtActivity.length,
                          itemBuilder: (BuildContext context, int i) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Column(
                                children: [
                                  SizedBox(height: 10),
                                  InkWell(
                                    onTap: () {
                                      controller.acvtEc.text = controller
                                          .dtActivity[i].name
                                          .toString();
                                      Get.back();
                                      //_filterData(context);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(9),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 0.1,
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(19),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: Container(
                                                  padding: EdgeInsets.all(18),
                                                  child: Icon(
                                                    Icons.roller_shades,
                                                    size: 15,
                                                    color: Colors.white,
                                                  ),
                                                  color: Colors.amber[700],
                                                ),
                                              ),
                                              SizedBox(width: 13),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: Get.width * 0.5,
                                                    child: Text(
                                                        "${controller.dtActivity[i].name}",
                                                        style: AppTheme.title),
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
          ),
        );
      },
    );
  }

  _chooseOpt(BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext bc) {
        return SingleChildScrollView(
          child: Container(
            height: Get.height * 0.95,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(11),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Pilih Operator", style: AppTheme.title),
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
                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.only(left: 18, right: 18, top: 18),
                      child: TextField(
                        controller: controller.sOptEc,
                        onChanged: controller.searchDataOpt,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          hintText: "Search",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(13),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Obx(
                      () => Container(
                        height: Get.height * 0.7,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: controller.dtOpt.length,
                          itemBuilder: (BuildContext context, int i) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Column(
                                children: [
                                  SizedBox(height: 10),
                                  InkWell(
                                    onTap: () {
                                      controller.optEc.text =
                                          controller.dtOpt[i].name.toString();
                                      Get.back();
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(9),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 0.1,
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(19),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: Container(
                                                  padding: EdgeInsets.all(18),
                                                  child: Icon(
                                                    Icons.person,
                                                    size: 15,
                                                    color: Colors.white,
                                                  ),
                                                  color: Colors.amber[700],
                                                ),
                                              ),
                                              SizedBox(width: 13),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: Get.width * 0.5,
                                                    child: Text(
                                                        "${controller.dtOpt[i].name}",
                                                        style: AppTheme.title),
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
          ),
        );
      },
    );
  }
}
