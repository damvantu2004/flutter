import 'package:flutter/material.dart';
import 'package:furniture_app/data/models/product.dart';
import 'package:furniture_app/data/repository/order_repository.dart';
import 'package:furniture_app/data/values/colors.dart';
import 'package:furniture_app/data/values/strings.dart';
import 'package:furniture_app/screen/detail_order/controller/detail_order_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DetailOrderPage extends GetView<DetailOrderController> {
  const DetailOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailOrderController>(
        builder: (value) => Scaffold(
              backgroundColor: backgroundColor,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: backgroundColor,
                title: Padding(
                  padding: EdgeInsets.only(left: Get.width / 6),
                  child: Text(
                    detail_order,
                    style: TextStyle(
                        fontFamily: 'JosefinSans',
                        fontWeight: FontWeight.w800,
                        fontSize: Get.width * 0.039,
                        color: textBlackColor),
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
              body: Container(
                color: backgroundColor,
                child: controller.order != null ? buildBody() : Container(),
              ),
            ));
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: Get.height * 0.015,
            color: textGrey4Color,
          ),
          buildStatus(),
          Container(
            height: Get.height * 0.015,
            color: textGrey4Color,
          ),
          SingleChildScrollView(
            child: buildContent(),
          ),
        ],
      ),
    );
  }

  Container buildStatus() {
    return Container(
      width: Get.width,
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(children: [
        Expanded(
          child: Text(
            "#${controller.order!.id}",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: Get.width * 0.039,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            controller.status,
            maxLines: 1,
            textAlign: TextAlign.end,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: Get.width * 0.039,
              color: controller.getColorStatusCourse(controller.status),
            ),
          ),
        ),
      ]),
    );
  }

  Widget buttonGuarantee() {
    return InkWell(

      child: Container(
          margin:
              const EdgeInsets.only(bottom: 10, left: 20, right: 20, top: 20),
          padding: const EdgeInsets.symmetric(vertical: 15),
          width: Get.width,
          decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: ColorShadow,
                  blurRadius: 10,
                  spreadRadius: 4,
                )
              ]),
          child: Text(detail_order_button,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: Get.width * 0.051,
                  fontWeight: FontWeight.w600,
                  color: Colors.white))),
    );
  }

  Widget buildContent() {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          _product(),
          _date(),
          _payment(),
          customeText("Total price",
              '\$${controller.order!.priceTotal.toStringAsFixed(2)}'),
        ],
      ),
    );
  }

  Widget _date() {
    return Column(
      children: [
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Date',
                style: TextStyle(
                    fontSize: Get.height * 0.021, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 5),
              Column(
                children: List.generate(
                  OrderRepository().statusOrderToInt(controller.order!),
                  (index) => textDate(index),
                ),
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }

  Row textDate(int index) {
    return Row(
      children: [
        Text(controller.order!.status[index].status),
        const Spacer(),
        Text(
          "${DateFormat('H:m dd-MM-yyyy').format(controller.order!.status[index].date ?? DateTime.now())}",
          style: TextStyle(
              fontSize: Get.height * 0.019, fontWeight: FontWeight.w700),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ],
    );
  }

  Widget _payment() {
    return Column(
      children: [
        Container(
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    payment,
                    style: TextStyle(
                        fontSize: Get.height * 0.021,
                        fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  Text(
                    controller.order!.paymentInCash == false
                        ? 'Payment in cash'
                        : 'Card payment',
                    style: TextStyle(
                        fontSize: Get.height * 0.019,
                        fontWeight: FontWeight.w700,
                        color: Colors.orange),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }

  Widget _product() {
    if (controller.products.length == 0) return Container();
    return Column(
      children: [
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order Detail',
                style: TextStyle(
                    fontSize: Get.height * 0.021, fontWeight: FontWeight.w500),
              ),
              Container(
                height: Get.height * 0.229,
                width: Get.width,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: controller.products.length,
                    itemBuilder: (BuildContext context, int itemIndex) {
                      return textProduct(
                          itemIndex, controller.products[itemIndex]);
                    }),
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }

  Container textProduct(int index, Product product) {
    return Container(
      margin: EdgeInsets.all(Get.height * 0.003),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: buttonColor)),
      padding: EdgeInsets.all(Get.height * 0.017),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ID: ${product.id}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: Get.height * 0.019, fontWeight: FontWeight.w500),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _pictureContent(product.imagePath!.first.toString()),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name.toString(),
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    SizedBox(
                      height: Get.height * 0.009,
                    ),
                    Text(
                      'Price: ' + '\$${product.price}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Text(
                      'Amount: ${controller.order!.carts[index].amount}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Text(
                      'Size: ${product.weight}x${product.width}x${product.length}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Color: ',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Row(
                          children: List.generate(
                            product.imageColorTheme?.length ?? 0,
                            (index) => Container(
                              height: 18,
                              width: 18,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: product.imageColorTheme![index],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container _pictureContent(String imagePath) {
    return Container(
      margin: EdgeInsets.all(Get.height * 0.009),
      height: Get.height * 0.122,
      width: Get.height * 0.122,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Get.height * 0.017),
        image: DecorationImage(
          image: NetworkImage(imagePath),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget customeText(String? title, String? value) {
    return SizedBox(
      height: 40,
      child: Column(
        children: [
          Row(children: [
            Text(
              title!,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: Get.width * 0.039,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: SizedBox(
                width: Get.width / 2,
                child: Text(
                  value ?? '',
                  textAlign: TextAlign.right,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: Get.width * 0.039,
                  ),
                ),
              ),
            ),
          ]),
          const Divider(),
        ],
      ),
    );
  }
}
