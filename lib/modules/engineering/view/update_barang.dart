import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sentra_mobile/config/app_theme.dart';
import 'package:sentra_mobile/modules/engineering/controller/update_barang_controller.dart';

class UpdateBarang extends GetView<UpdateBarangController> {
  UpdateBarang({Key? key}) : super(key: key);
  final controller = Get.put(UpdateBarangController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        backgroundColor: Color(0xFF0084f3),
        title: Text(
          "Repair Work Order",
          style: AppTheme.titleLight,
        ),
        elevation: 1,
        leading: IconButton(
          onPressed: () => Get.back(result: "return"),
          icon: Icon(
            Icons.arrow_back,
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
            : GetBuilder<UpdateBarangController>(
                builder: (controller) => Container(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: controller.dt.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(2),
                                  height:
                                      (controller.dt[index].requestVerifyNote ==
                                                  "" ||
                                              controller.dt[index]
                                                      .requestVerifyNote ==
                                                  null)
                                          ? 115
                                          : 135,
                                  decoration: BoxDecoration(
                                    color: Colors.amber[700],
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(9),
                                  decoration: BoxDecoration(
                                    color: (double.parse(controller
                                                    .dt[index].requestVerifyBy
                                                    .toString()) -
                                                double.parse(
                                                    "${controller.dt[index].requestVerifyById ?? 0}") ==
                                            0)
                                        ? Colors.grey[400]
                                        : Colors.white,
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
                                      Container(
                                        width: Get.width * 0.6,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${controller.dt[index].goodsRequesterId}",
                                              style: AppTheme.title,
                                            ),
                                            SizedBox(height: 5),
                                            Text(
                                                "Planing : ${controller.dt[index].goodsTakerId} Pcs ",
                                                style: TextStyle(
                                                    color: Colors.blue[800],
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            SizedBox(height: 5),
                                            Text(
                                                "Diterima : ${controller.dt[index].requestVerifyBy ?? 0} Pcs",
                                                style: TextStyle(
                                                    color: Colors.blue[800],
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            SizedBox(height: 5),
                                            Text(
                                                "Dipakai : ${controller.dt[index].requestVerifyById ?? 0} Pcs",
                                                style: TextStyle(
                                                    color: Colors.red[800],
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            (controller.dt[index]
                                                            .requestVerifyNote ==
                                                        "" ||
                                                    controller.dt[index]
                                                            .requestVerifyNote ==
                                                        null)
                                                ? Container()
                                                : Column(
                                                    children: [
                                                      SizedBox(height: 5),
                                                      Text(
                                                          "${controller.dt[index].requestVerifyNote ?? 0} ",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .red[800],
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                    ],
                                                  ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      (double.parse(controller
                                                      .dt[index].requestVerifyBy
                                                      .toString()) -
                                                  double.parse(
                                                      "${controller.dt[index].requestVerifyById ?? 0}") ==
                                              0)
                                          ? Icon(
                                              Icons.check,
                                              size: 35,
                                            )
                                          : InkWell(
                                              onTap: () =>
                                                  _editPenggunaanBarang(
                                                      context, index),
                                              child: Icon(Icons.edit)),
                                      PopupMenuButton<String>(
                                        icon: Icon(Icons.more_horiz),
                                        onSelected: (value) {
                                          controller.itemLup(
                                              controller.dt[index], value);
                                        },
                                        itemBuilder: (BuildContext context) {
                                          return {'Item lup?'}
                                              .map((String choice) {
                                            return PopupMenuItem<String>(
                                              value: choice,
                                              child: Text(choice),
                                            );
                                          }).toList();
                                        },
                                      ),
                                    ],
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

  void _editPenggunaanBarang(BuildContext context, int ind) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: Get.height * 0.7,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("Edit Barang", style: AppTheme.title),
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
                  Text("${controller.dt[ind].goodsRequesterId}",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 20)),
                  SizedBox(height: 5),
                  Text("Planing  ( ${controller.dt[ind].goodsTakerId} Pcs )",
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 13)),
                  SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                    ],
                    controller: controller.updtBrgEc.value[ind],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Color(0xFFe7edeb),
                      hintText: "0",
                    ),
                    onChanged: (content) {
                      //controller.updateBarang(controller.dt[index], content);
                    },
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(width: 15),
                      ElevatedButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.all(20)),
                          minimumSize: MaterialStateProperty.all(
                            Size(Get.width * 0.5, 40),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                          ),
                        ),
                        child: Text('Update Barang'),
                        onPressed: () {
                          controller.updtBrgEc.value[ind].text =
                              int.parse(controller.updtBrgEc.value[ind].text)
                                  .toString();
                          controller.updateBarang(controller.dt[ind],
                              controller.updtBrgEc.value[ind].text);
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
