import 'package:flutter/material.dart';
import 'package:furniture_app/data/models/Order.dart';
import 'package:furniture_app/data/repository/order_repository.dart';
import 'package:furniture_app/data/values/colors.dart';
import 'package:furniture_app/data/values/fonts.dart';
import 'package:furniture_app/data/values/strings.dart';
import 'package:furniture_app/screen/detail_order/view/detail_order_page.dart';
import 'package:furniture_app/screen/order/controller/order_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class OrderPage extends GetView<OrderController> {
  var formatter = DateFormat('dd/MM/yyyy');
  String? formatted;
  OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
        builder: (value) => Scaffold(
              backgroundColor: backgroundColor,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: backgroundColor,
                title: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(right: 50),
                  child: Text(
                    order,
                    style: TextStyle(fontFamily: 'JosefinSans', fontWeight: FontWeight.w800, fontSize: Get.width * 0.039, color: textBlackColor),
                  ),
                ),
                leading: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: textBlackColor,
                  ),
                ),
              ),
              body: buildBody(),
            ));
  }

  Widget buildBody() {
    return Container(
      height: Get.height,
      width: Get.width,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        buildMenu(),
        Container(
            height: Get.height - 150,
            width: Get.width,
            color: backgroundColor,
            child: controller.loadPage
                ? Center(
                    child: LoadingAnimationWidget.fourRotatingDots(
                    color: Colors.black,
                    size: 30,
                  ))
                : controller.orders.length > 0
                    ? SingleChildScrollView(
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: controller.orders.length,
                            itemBuilder: (context, index) {
                              return buildContent(controller.orders[index]);
                            }),
                      )
                    : Center(child: Text("There are no orders in this status"))),
      ]),
    );
  }

  Widget buildMenu() {
    return Container(
      width: Get.width,
      child: Obx(
        () => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(controller.tab.length, (index) => buildItemTab(index, controller.tab[index])),
        ),
      ),
    );
  }

  InkWell buildItemTab(int index, String content) {
    return InkWell(
      onTap: () {
        if (index != controller.tabCurrentIndex.value) controller.ChangedTab(index);
      },
      child: Column(
        children: [
          Text(
            content,
            style: TextStyle(fontFamily: jose_fin_sans, fontWeight: FontWeight.w600, fontSize: 16, color: index == controller.tabCurrentIndex.value ? Colors.black : Colors.grey),
          ),
          index == controller.tabCurrentIndex.value
              ? Container(
                  height: 4,
                  width: 40,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(50)),
                )
              : Container()
        ],
      ),
    );
  }

  Widget buildContent(MyOrder order) {
    //formatted = formatter.format((value.time ?? '20/10/2001'));
    return Container(
      width: Get.width,
      padding: const EdgeInsets.only(bottom: 20.0, top: 20, right: 16),
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: ColorShadow,
            blurRadius: 10,
            spreadRadius: 5,
            offset: Offset(0, 3), // Shadow position
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(left: Get.width * 0.04),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '#${order.id ?? ''}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: Get.width * 0.039,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  "${DateFormat('dd/MM/yyyy').format(order.time ?? DateTime.now())}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: Get.width * 0.039,
                    color: textGrey3Color,
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          SizedBox(height: Get.height * 0.01),
          Padding(
            padding: EdgeInsets.only(left: Get.width * 0.04),
            child: Row(
              children: [
                Text(
                  order_quantity,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: Get.width * 0.039,
                    color: textGrey3Color,
                  ),
                ),
                Expanded(
                  child: Text(
                    '${controller.getQuantity(order)} products',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: Get.width * 0.039,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: Get.width * 0.04),
            child: Row(
              children: [
                Text(
                  order_price,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: Get.width * 0.039,
                    color: textGrey3Color,
                  ),
                ),
                Expanded(
                  child: Text(
                    '\$${order.priceTotal.toStringAsFixed(2)}',
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: Get.width * 0.039,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Row(
            children: [
              InkWell(
                child: Container(
                  width: 100,
                  height: 36,
                  decoration: const BoxDecoration(color: buttonColor, borderRadius: BorderRadius.only(topRight: Radius.circular(5), bottomRight: Radius.circular(5))),
                  child: Center(
                    child: Text(
                      order_detail,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: Get.width * 0.039,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  Get.to(() => const DetailOrderPage(), arguments: {
                    'order': order
                  });
                },
              ),
              const Spacer(),
              order.status == 'Processing' ? const Icon(Icons.access_time_rounded) : Container(),
              const SizedBox(width: 5),
              Text(
                OrderRepository.statusOrderToString(order),
                textAlign: TextAlign.right,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: Get.width * 0.039, color: controller.getColorStatusCourse(order.status.toString())),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
