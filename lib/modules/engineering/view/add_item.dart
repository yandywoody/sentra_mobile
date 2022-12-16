import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:searchfield/searchfield.dart';
import 'package:sentra_mobile/config/app_theme.dart';
import 'package:sentra_mobile/modules/engineering/controller/add_item_controller.dart';
import 'package:sentra_mobile/modules/engineering/controller/wo_manual_controller.dart';
import 'package:sentra_mobile/modules/engineering/model/activity_model.dart';
import 'package:sentra_mobile/modules/engineering/model/items_model.dart';
import 'package:sentra_mobile/modules/engineering/model/machine_model.dart';
import 'package:sentra_mobile/modules/engineering/model/wo_all_model.dart';
import 'package:sentra_mobile/routes/app_routes.dart';

class AddItem extends GetView<AddItemController> {
  AddItem({Key? key}) : super(key: key);
  final ctrl = Get.put(AddItemController());

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
          "Tambah Item",
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
          padding: const EdgeInsets.fromLTRB(32, 25, 32, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Work Order", style: AppTheme.text14opc20),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => Expanded(
                      child: Text(
                        "${controller.lblActivity.value}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              Text("Kode Request", style: AppTheme.text14opc20),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 1,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(19),
                ),
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                            width: Get.width * 0.6,
                            child: TextFormField(
                              readOnly: true,
                              controller: controller.itemEc,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Color(0xFFe7edeb),
                                hintText: "Pilih Kode Request",
                              ),
                              onTap: () => _chooseGoodsRequest(context),
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
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
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
                            _chooseGoodsRequest(context);
                          },
                        ),
                      ],
                    ),
                    Obx(
                      () {
                        return (controller.dtGoodsItemRequest.length == 0)
                            ? Container()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20),
                                  Text("Detail Item :", style: AppTheme.title),
                                  SizedBox(height: 5),
                                  Container(
                                    height: Get.height * 0.3,
                                    child: ListView.builder(
                                      physics: BouncingScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount:
                                          controller.dtGoodsItemRequest.length,
                                      itemBuilder:
                                          (BuildContext context, int i) {
                                        return (controller.dtGoodsItemRequest[i]
                                                    .reqItemName ==
                                                null)
                                            ? Container()
                                            : Column(
                                                children: [
                                                  SizedBox(height: 10),
                                                  Container(
                                                    padding: EdgeInsets.all(9),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey,
                                                          blurRadius: 0.3,
                                                        ),
                                                      ],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              19),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15),
                                                              child: Container(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            12),
                                                                child: Icon(
                                                                  CupertinoIcons
                                                                      .cube_box,
                                                                  size: 25,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                color: Colors
                                                                    .amber[700],
                                                              ),
                                                            ),
                                                            SizedBox(width: 13),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Container(
                                                                  width:
                                                                      Get.width *
                                                                          0.5,
                                                                  child: Text(
                                                                      "${controller.dtGoodsItemRequest[i].reqItemName}",
                                                                      style: AppTheme
                                                                          .title),
                                                                ),
                                                                Container(
                                                                  width:
                                                                      Get.width *
                                                                          0.5,
                                                                  child: Text(
                                                                      "${controller.dtGoodsItemRequest[i].reqQuantity} Pcs",
                                                                      style: AppTheme
                                                                          .title),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              );
                                      },
                                    ),
                                  ),
                                ],
                              );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.grey[500]),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(15)),
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
                    onPressed: () => Get.back(result: ""),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    style: ButtonStyle(
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(15)),
                      minimumSize: MaterialStateProperty.all(
                        Size(Get.width * 0.1, 30),
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
                    child: Text('TAMBAH ITEM'),
                    onPressed: () => ctrl.additem(),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _chooseGoodsRequest(BuildContext context) {
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
                        Text("Pilih Code Permintaan Item",
                            style: AppTheme.title),
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
                    // Container(
                    //   margin: EdgeInsets.only(left: 18, right: 18, top: 18),
                    //   child: TextField(
                    //     controller: controller.sActivityEc,
                    //     onChanged: controller.searchDataActivity,
                    //     decoration: InputDecoration(
                    //       prefixIcon: Icon(Icons.search),
                    //       hintText: "Search",
                    //       border: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(13),
                    //         borderSide: BorderSide(color: Colors.blue),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(height: 20),
                    Obx(
                      () => Container(
                        height: Get.height * 0.7,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: controller.dtGoodsRequest.length,
                          itemBuilder: (BuildContext context, int i) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Column(
                                children: [
                                  SizedBox(height: 10),
                                  InkWell(
                                    onTap: () {
                                      controller.itemEc.text = controller
                                          .dtGoodsRequest[i].code
                                          .toString();
                                      controller
                                          .setGr(controller.dtGoodsRequest[i]);
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
                                                        "${controller.dtGoodsRequest[i].code}",
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
