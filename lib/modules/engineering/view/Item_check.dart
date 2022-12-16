import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sentra_mobile/config/app_theme.dart';
import 'package:sentra_mobile/modules/engineering/controller/item_check_controller.dart';
import 'package:sentra_mobile/routes/app_routes.dart';

class ItemCheck extends GetView<ItemCheckController> {
  ItemCheck({Key? key}) : super(key: key);
  final controller = Get.put(ItemCheckController());

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
          "Pengecekan Barang",
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
        () => DefaultTabController(
          length: 2,
          child: Column(
            children: [
              Container(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: controller.dt.length,
                  itemBuilder: (BuildContext context, int i) {
                    return Column(
                      children: [
                        (controller.dt.length == 0)
                            ? Center(
                                heightFactor: 1,
                                child: Lottie.asset(
                                  'assets/animations/no-data-animation.json',
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 0.1,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                margin: new EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 6.0),
                                child: GetBuilder<ItemCheckController>(
                                  builder: (controller) => InkWell(
                                    onTap: () => (controller.dtWo != null)
                                        ? (double.parse(controller
                                                        .dt[i].goodsTakerId
                                                        .toString()) -
                                                    double.parse(controller
                                                        .totItemDiterma.value
                                                        .toString()) >
                                                0)
                                            ? _terimaBarang(
                                                context, controller.dt[i], i)
                                            : null
                                        : _konfData(
                                            context, controller.dt[i], i),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: (double.parse(
                                                        "${controller.dt[i].goodsTakerId ?? 0}") -
                                                    double.parse(
                                                        "${controller.totItemDiterma.value}") >
                                                0)
                                            ? Colors.white
                                            : Colors.blue,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: ListTile(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 10.0),
                                        title: Text(
                                          "${controller.dt[i].goodsRequesterId ?? 0}",
                                          style: TextStyle(
                                              color: (double.parse(
                                                              "${controller.dt[i].goodsTakerId ?? 0}") -
                                                          double.parse(
                                                              "${controller.totItemDiterma.value}") >
                                                      0)
                                                  ? Colors.black
                                                  : Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        leading: (double.parse(
                                                        "${controller.dt[i].goodsTakerId ?? 0}") -
                                                    double.parse(
                                                        "${controller.totItemDiterma.value}") >
                                                0)
                                            ? Icon(CupertinoIcons.cube_box)
                                            : Icon(
                                                CupertinoIcons.check_mark,
                                                size: 35,
                                                color: Colors.white,
                                              ),
                                        subtitle: Row(
                                          children: <Widget>[
                                            GetBuilder<ItemCheckController>(
                                              builder: (controller) => Text(
                                                "Planing : ${controller.dt[i].goodsTakerId ?? 0} Pcs \nTerima : ${controller.dt[i].requestVerifyBy ?? 0} Pcs",
                                                style: TextStyle(
                                                  color: (double.parse(
                                                                  "${controller.dt[i].goodsTakerId ?? 0}") -
                                                              double.parse(
                                                                  "${controller.totItemDiterma.value}") >
                                                          0)
                                                      ? Colors.black
                                                      : Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ],
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

  _konfData(BuildContext context, var dtItem, var index) {
    controller.getAllWo(dtItem);

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
          height: Get.height * 0.98,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(11),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("Konfirmasi Data", style: AppTheme.title),
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
                  Text(
                    "${dtItem.goodsRequesterId}",
                    style: AppTheme.bigTitle,
                  ),
                  Text(
                    "Total Planing : ${dtItem.goodsTakerId} Pcs",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.blue[700],
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "WO Terkait",
                        style: AppTheme.title,
                      ),
                      // (double.parse(dtItem.goodsTakerId.toString()) -
                      //             double.parse(
                      //                 '${dtItem.requestVerifyBy ?? 0}') <=
                      //         0)
                      //     ? Container()
                      //     : ElevatedButton(
                      //         style: ElevatedButton.styleFrom(
                      //             primary: Colors.amber[700]),
                      //         child: Text('Terima Semua'),
                      //         onPressed: () =>
                      //             controller.terimaBarangAll(dtItem),
                      //       ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Total Diterima : ${controller.totItemDiterma.value} Pcs",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.blue[700],
                    ),
                  ),
                  SizedBox(height: 5),
                  Obx(
                    () => Container(
                      height: Get.height * 0.5,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: controller.dtDetail.length,
                          itemBuilder: (BuildContext context, int i) {
                            return Column(
                              children: [
                                (controller.dtDetail.length == 0)
                                    ? Center(
                                        heightFactor: 1,
                                        child: Lottie.asset(
                                          'assets/animations/no-data-animation.json',
                                        ),
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                          color: (controller
                                                      .dtDetail[i].isReceived ==
                                                  1)
                                              ? Colors.grey[300]
                                              : Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 0.1,
                                            ),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        margin: new EdgeInsets.symmetric(
                                            horizontal: 1.0, vertical: 3.0),
                                        child: GetBuilder<ItemCheckController>(
                                          builder: (controller) => Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: InkWell(
                                              onTap: () => controller.woDetail(
                                                  controller.dtDetail[i]
                                                      .relationableId,
                                                  controller.dtDetail[i]
                                                      .relationableType
                                                      .toString()
                                                      .split('\\')[3]),
                                              child: ListTile(
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 15.0,
                                                        vertical: 5.0),
                                                title: Text(
                                                  "${controller.dtDetail[i].note ?? 0}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                leading: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            5, 5, 5, 5),
                                                    color: (controller
                                                                .dtDetail[i]
                                                                .isReceived ==
                                                            1)
                                                        ? Colors.grey[300]
                                                        : Colors.white,
                                                    child: Column(
                                                      children: [
                                                        Icon(
                                                          CupertinoIcons
                                                              .cube_box,
                                                          color: Colors.black,
                                                        ),
                                                        SizedBox(height: 5),
                                                        Text(
                                                          "${controller.dtDetail[i].goodsTakerId ?? 0} Pcs",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                subtitle: Row(
                                                  children: <Widget>[
                                                    SizedBox(height: 10),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "${controller.dtDetail[i].relationableType.toString().split('\\')[3]}",
                                                        ),
                                                        SizedBox(width: 3),
                                                        Text(
                                                          "Diterima : ${controller.dtDetail[i].requestVerifyBy ?? 0}",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Colors
                                                                  .amber[700]),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                trailing: (controller
                                                            .dtDetail[i]
                                                            .isReceived ==
                                                        1)
                                                    ? Icon(
                                                        Icons.check,
                                                        size: 35,
                                                        color: Colors.grey[700],
                                                      )
                                                    : InkWell(
                                                        onTap: () {
                                                          _terimaBarang(
                                                              context,
                                                              controller
                                                                  .dtDetail[i],
                                                              i);
                                                        },
                                                        child:
                                                            Icon(Icons.edit)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                              ],
                            );
                          }),
                    ),
                  ),
                  SizedBox(height: 100),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _terimaBarang(BuildContext context, var dtWoItem, int indx) {
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
          height: Get.height * 0.7,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(11),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("Konfirmasi Data", style: AppTheme.title),
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
                  Text("Jumlah Barang yang diterima", style: AppTheme.title),
                  SizedBox(height: 10),
                  Container(
                    width: Get.width,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                      ],
                      controller: controller.jmlEcx,
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
                  ),
                  SizedBox(height: 10),
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
                        child: Text('Simpan'),
                        onPressed: () {
                          controller.jmlEcx.text =
                              int.parse(controller.jmlEcx.text).toString();
                          controller.terimaBarang(
                              dtWoItem, controller.jmlEcx.text);
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
}
