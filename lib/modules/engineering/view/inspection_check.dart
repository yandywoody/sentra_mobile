import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sentra_mobile/config/app_theme.dart';
import 'package:sentra_mobile/modules/engineering/controller/inspection_check_controller.dart';
import 'package:sentra_mobile/modules/engineering/model/image_content_model.dart';

class InspectionCheck extends GetView<InspectionCheckController> {
  InspectionCheck({Key? key}) : super(key: key);
  final controller = Get.put(InspectionCheckController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        color: Colors.white,
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
                onPressed: () => Get.back(),
              ),
              SizedBox(width: 10),
              (controller.data.isActive == 0)
                  ? SizedBox()
                  : ElevatedButton(
                      style: ButtonStyle(
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(9)),
                        minimumSize: MaterialStateProperty.all(
                          Size(Get.width * 0.1, 0),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                          AppTheme.warningColor,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.thumb_up,
                            color: AppTheme.bgColorLight,
                          ),
                          SizedBox(width: 7),
                          Text(
                            'All Good',
                            style: AppTheme.lightText14,
                          ),
                        ],
                      ),
                      onPressed: () => controller.allGood(),
                    )
            ],
          ),
        ),
      ),
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
          "Cek Inspeksi",
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
        () => (controller.dt.length == 0)
            ? Center(
                heightFactor: 1,
                child: Lottie.asset(
                  'assets/animations/no-data-animation.json',
                ),
              )
            : GetBuilder<InspectionCheckController>(
                builder: (controller) => Container(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: controller.dt.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(5),
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: (controller.dt[index].condition ==
                                            null)
                                        ? Color(0xFFf7ab3b)
                                        : (controller.dt[index].condition == 1)
                                            ? AppTheme.succesColor
                                            : (controller.dt[index].condition ==
                                                    2)
                                                ? AppTheme.infoColor
                                                : AppTheme.dangerColor,
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                                InkWell(
                                  onLongPress: () {
                                    controller
                                        .selectChecked(controller.dt[index]);
                                  },
                                  onTap: () => _editCheck(context, index),
                                  child: Ink(
                                    width: Get.width * 0.8,
                                    padding: EdgeInsets.all(9),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: 0.1,
                                        ),
                                      ],
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(15),
                                          bottomRight: Radius.circular(15)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            SizedBox(width: 12),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: Get.width * 0.5,
                                                  child: Text(
                                                    "${controller.dt[index].name ?? 0}",
                                                    style: AppTheme.title,
                                                  ),
                                                ),
                                                SizedBox(height: 9),
                                                Text(
                                                  "${controller.dt[index].category ?? 0}",
                                                  style: AppTheme.title,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Obx(
                                          () => FutureBuilder<String>(
                                              future: controller.getImageList(
                                                  controller.dt[index].id),
                                              builder: (BuildContext context,
                                                  AsyncSnapshot<String>
                                                      snapshot) {
                                                return (snapshot == "0")
                                                    ? Container()
                                                    : Row(
                                                        children: [
                                                          Icon(Icons.photo),
                                                          SizedBox(width: 5),
                                                          Text(
                                                              "${snapshot.data}"),
                                                        ],
                                                      );
                                              }),
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

  void _editCheck(BuildContext context, int index) {
    controller.getImage(controller.dt[index].id);
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: AppTheme.bgColorLight,
      context: context,
      builder: (BuildContext bc) {
        return Obx(
          () => Container(
            height: Get.height * 0.95,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("Check Status", style: AppTheme.title),
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
                  Text("${controller.dt[index].name}",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
                  SizedBox(height: 35),
                  Text("Status :",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 250,
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(width: 4, color: Colors.blue),
                        ),
                      ),
                      hint: Text('Status'),
                      value: (controller.dt[index].condition == null)
                          ? 1
                          : controller.dt[index].condition,
                      onChanged: (controller.data.isActive == 0)
                          ? null
                          : (newValue) => controller.changeStatus(
                              int.parse(newValue.toString()),
                              controller.dt[index]),
                      items: [
                        DropdownMenuItem(
                          child: new Text("Good"),
                          value: 1,
                        ),
                        DropdownMenuItem(
                          child: new Text("Good After Repair"),
                          value: 2,
                        ),
                        DropdownMenuItem(
                          child: new Text("Bad"),
                          value: 3,
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text("Deskripsi :",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                  SizedBox(height: 5),
                  Container(
                    width: Get.width,
                    child: TextField(
                      minLines: 6,
                      keyboardType: TextInputType.multiline,
                      readOnly: (controller.data.isActive == 0) ? true : false,
                      maxLines: null,
                      controller: controller.descEc.value[index],
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        hintText: "Deskripsi",
                        fillColor: Colors.grey[200],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Detail Foto : ${controller.img.length}",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14)),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            AppTheme.warningColor,
                          ),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(9)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        child: Text(
                          "+ Tambah Photo",
                          style: AppTheme.titleLight,
                        ),
                        onPressed: () {
                          controller.pickImage(controller.dt[index].id);
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Column(
                    children: [
                      Container(
                        width: Get.width,
                        height: 150,
                        color: AppTheme.bgColorLight,
                        child: GetBuilder<InspectionCheckController>(
                          builder: (_) {
                            return controller.img != null
                                ? Row(
                                    children: [
                                      Expanded(
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: controller.img.length,
                                          itemBuilder: (BuildContext context,
                                                  int index) =>
                                              GestureDetector(
                                            onTap: () => _viewFullImage(
                                                controller.img[index], context),
                                            child: Card(
                                              child: Center(
                                                child: Image.file(
                                                  File(controller
                                                      .img.value[index].path!),
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
                    ],
                  ),
                  SizedBox(height: 10),
                  (controller.data.isActive == 0)
                      ? Container()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  Colors.blueAccent,
                                ),
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.all(17)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                ),
                              ),
                              child: Text(
                                "Simpan",
                                style: AppTheme.titleLight,
                              ),
                              onPressed: () {
                                controller.simpanData(controller.dt[index],
                                    controller.descEc.value[index].text);
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
