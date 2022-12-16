import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:searchfield/searchfield.dart';
import 'package:sentra_mobile/config/app_theme.dart';
import 'package:sentra_mobile/modules/engineering/controller/wo_manual_controller.dart';
import 'package:sentra_mobile/modules/engineering/model/activity_model.dart';
import 'package:sentra_mobile/modules/engineering/model/machine_model.dart';
import 'package:sentra_mobile/routes/app_routes.dart';

class WoManual extends GetView<WoManualController> {
  WoManual({Key? key}) : super(key: key);
  final ctrl = Get.put(WoManualController());

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
          "Manual Work Order",
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
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          height: Get.height,
          width: Get.width,
          padding: const EdgeInsets.fromLTRB(32, 16, 32, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Tipe Wo", style: AppTheme.bigSubTitle),
              SizedBox(height: 10),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Color(0xFFe7edeb),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Obx(
                    () => DropdownButton(
                      hint: Text("Pilih Tipe Work Order"),
                      value: ctrl.frmWorkType.value,
                      onChanged: (String? newValue) {
                        ctrl.setWorkType(newValue!);
                      },
                      icon: Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Icon(Icons.arrow_circle_down_sharp),
                      ),
                      underline: Container(),
                      items: ctrl.dtWorkType.map((selectedType) {
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
              Text("Aktifitas", style: AppTheme.bigSubTitle),
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
                      width: Get.width * 0.63,
                      child: TextFormField(
                        controller: controller.activityEc,
                        readOnly: true,
                        onTap: () => _chooseActivity(context),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Color(0xFFe7edeb),
                          hintText: "Pilih Aktifitas",
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(11)),
                      minimumSize: MaterialStateProperty.all(
                        Size(Get.width * 0.1, 20),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                        AppTheme.warningColor,
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Jam Mulai", style: AppTheme.bigSubTitle),
                      SizedBox(height: 10),
                      Container(
                        width: Get.width * 0.4,
                        child: TextField(
                          controller: ctrl.strtEc,
                          readOnly: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Color(0xFFe7edeb),
                            hintText: "00:00",
                            prefixIcon: const Icon(
                              Icons.access_time,
                              color: Color(0xFF27324c),
                            ),
                          ),
                          onTap: () async {
                            TimeOfDay? newTimeStart = await showTimePicker(
                              context: context,
                              initialTime: ctrl.timeStart,
                            );
                            if (newTimeStart == null) return;
                            ctrl.setStartAt(newTimeStart);
                          },
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Jam Selesai", style: AppTheme.bigSubTitle),
                      SizedBox(height: 10),
                      Container(
                        width: Get.width * 0.4,
                        child: TextField(
                          controller: ctrl.endEc,
                          readOnly: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Color(0xFFe7edeb),
                            hintText: "00:00",
                            prefixIcon: const Icon(
                              Icons.access_time,
                              color: Color(0xFF27324c),
                            ),
                          ),
                          onTap: () async {
                            TimeOfDay? newTimeEnd = await showTimePicker(
                              context: context,
                              initialTime: ctrl.timeStart,
                            );
                            if (newTimeEnd == null) return;
                            ctrl.setEndAt(newTimeEnd);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text("Mesin", style: AppTheme.bigSubTitle),
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
                      width: Get.width * 0.63,
                      child: TextFormField(
                        controller: controller.machineEc,
                        readOnly: true,
                        onTap: () => _chooseMachine(context),
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
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(11)),
                      minimumSize: MaterialStateProperty.all(
                        Size(Get.width * 0.1, 40),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                        AppTheme.warningColor,
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
              Text("Deskripsi", style: AppTheme.bigSubTitle),
              SizedBox(height: 10),
              Container(
                width: Get.width,
                child: TextField(
                  minLines: 6,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: ctrl.descEc,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.grey[500]),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(20)),
                      minimumSize: MaterialStateProperty.all(
                        Size(Get.width * 0.3, 40),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                    child: Text('BATAL'),
                    onPressed: () => Get.back(),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    style: ButtonStyle(
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(20)),
                      minimumSize: MaterialStateProperty.all(
                        Size(Get.width * 0.3, 40),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                        AppTheme.warningColor,
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                    child: Text('BUAT WO'),
                    onPressed: () => ctrl.createWo(),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
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
                        Text("Pilih Aktifitas", style: AppTheme.title),
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
                                      controller.activityEc.text = controller
                                          .dtActivity[i].name
                                          .toString();
                                      controller.setActivity(
                                          controller.dtActivity[i]);
                                      Get.back();
                                      //_filterData(context);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(9),
                                      decoration: BoxDecoration(
                                        color: AppTheme.bgColorLight,
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
                                                  color: AppTheme.warningColor,
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
                                                        style: AppTheme.text14),
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
                          physics: BouncingScrollPhysics(),
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
                                      controller.machineEc.text = controller
                                          .dtMachine[i].code
                                          .toString();
                                      controller.setMachine(
                                          controller.machineEc.text);
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
                                                  color: AppTheme.warningColor,
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
}
