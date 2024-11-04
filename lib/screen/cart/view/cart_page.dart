import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:furniture_app/data/models/product.dart';
import 'package:furniture_app/data/values/colors.dart';
import 'package:furniture_app/data/values/fonts.dart';
import 'package:furniture_app/data/values/strings.dart';
import 'package:furniture_app/screen/cart/controller/cart_controller.dart';
import 'package:furniture_app/screen/checkout/view/checkout_page.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../data/models/cart.dart';

class CartPage extends GetView<CartController> {
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
        builder: (value) => Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: backgroundColor,
                title: Padding(
                  padding: EdgeInsets.only(left: Get.width / 4),
                  child: Text(
                    cart,
                    style: TextStyle(
                      fontFamily: 'JosefinSans',
                      fontWeight: FontWeight.w800,
                      fontSize: Get.width * 0.039,
                      color: textBlackColor,
                    ),
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
                child: _buildBody(),
              ),
            ));
  }

  Widget _buildBody() {
    if (controller.carts.isEmpty) {
      return Center(
        child: Text(
          'Your cart is empty',
          style: TextStyle(fontSize: 20, color: Colors.grey),
        ),
      );
    }
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 10),
          child: Row(
            children: [
              Checkbox(
                value: controller.all,
                activeColor: buttonColor,
                onChanged: (value) {
                  controller.updateCheckPointAll();
                },
                side: BorderSide(color: Colors.black),
              ),
              const Text(
                'Select All',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: controller.carts.length,
            itemBuilder: (context, index) {
              if (controller.products.isNotEmpty &&
                  index < controller.products.length) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 7),
                  child: Column(
                    children: [
                      buildContent(index),
                      const Divider(),
                    ],
                  ),
                );
              } else {
                return const SizedBox(); // Return an empty widget if the list is empty or index is out of range
              }
            },
          ),
        ),
        SizedBox(height: Get.height * 0.01),
        totalPrice(),
        buttonCheckOut(),
      ],
    );
  }

  Widget buildContent(int index) {
    return Slidable(
      // actionPane: const SlidableDrawerActionPane(),
      // actionExtentRatio: 0.25,
      // secondaryActions: <Widget>[
      //   IconSlideAction(
      //     caption: 'Delete',
      //     color: Colors.red,
      //     icon: Icons.delete,
      //     onTap: () => controller.onRemove(index),
      //   ),
      // ],
      child: SizedBox(
        width: Get.width,
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          InkWell(
            onTap: () {
              controller.updateCheckPoint(index);
            },
            child: Container(
              height: 80,
              width: 10,
              margin: EdgeInsets.all(10),
              child: Checkbox(
                activeColor: buttonColor,
                hoverColor: Colors.blueAccent,
                value: controller.check[index],
                onChanged: (value) {
                  controller.updateCheckPoint(index);
                },
                side: BorderSide(color: Colors.black),
              ),
            ),
          ),
          Container(
            height: 100,
            width: 130,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: NetworkImage(
                  (controller.products[index].imagePath != null &&
                      controller.products[index].imagePath!.isNotEmpty &&
                      controller.products[index].imagePath![0].isNotEmpty)
                      ? controller.products[index].imagePath![0]
                      : "https://scontent.fhan19-1.fna.fbcdn.net/v/t45.5328-4/441968936_786522690294388_192808687243888620_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=247b10&_nc_eui2=AeG4tWZLQYT_l6fYUDYed2DcnHrI7dWEC5Scesjt1YQLlDf8cXURswacYh4ECIGHBh9Jk78gNpWdR2qK4Q3NqgVg&_nc_ohc=bhjvb1j567MQ7kNvgHd-xD8&_nc_ht=scontent.fhan19-1.fna&oh=00_AYDVNkNCRKL8YXArbJ_AOZq4_auow0L8fw8kIyroXIQ6XQ&oe=66D3E223", // URL for a random image
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Container(
            height: 100,
            width: Get.width - 200,
            padding: const EdgeInsets.only(left: 5),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                height: 40,
                child: Text(
                  controller.products[index].name.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black.withOpacity(0.8),
                    fontFamily: nunito_sans,
                  ),
                ),
              ),
              Text(
                '\$ ${controller.products[index].price}',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: Get.width * 0.05,
                  fontFamily: nunito_sans,
                ),
              ),
              const Spacer(),
              customNumber(index),
            ]),
          ),
        ]),
      ),
    );
  }

  SizedBox customNumber(int index) {
    return SizedBox(
      width: Get.width - 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () {
              controller.subtractNumber(index);
            },
            child: Container(
              height: 20,
              width: 20,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(
                      224, 224, 224, controller.number[index] == 1 ? 0.1 : 0.5),
                  borderRadius: BorderRadius.circular(5)),
              child: Text('-',
                  style: TextStyle(
                    fontFamily: nunito_sans,
                    fontSize: Get.width * 0.05,
                    color: textBlackColor
                        .withOpacity(controller.number[index] == 1 ? 0 : 1),
                    fontWeight: FontWeight.w500,
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              controller.number[index].toString(),
              style: TextStyle(
                fontFamily: nunito_sans,
                fontSize: Get.width * 0.05,
                color: textBlackColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              controller.plusNumber(index);
            },
            child: Container(
              height: 20,
              width: 20,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(224, 224, 224, 1),
                  borderRadius: BorderRadius.circular(5)),
              child: Text('+',
                  style: TextStyle(
                    fontFamily: nunito_sans,
                    fontSize: Get.width * 0.05,
                    color: textBlackColor,
                    fontWeight: FontWeight.w500,
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Container totalPrice() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(children: [
        Text(
          total,
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: Get.width * 0.05,
              fontFamily: nunito_sans,
              color: textGrey3Color),
        ),
        const Spacer(),
        Text(
          //'\$ ${}',
          '\$${controller.total}',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: Get.width * 0.05,
            fontFamily: nunito_sans,
          ),
        ),
      ]),
    );
  }

  Widget buttonCheckOut() {
    return InkWell(
      onTap: () {
        if (controller.loadCheckout == false) {
          controller.clickButtonCheckOut();
        }
      },
      child: Container(
          margin:
              const EdgeInsets.only(bottom: 10, left: 20, right: 20, top: 10),
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
          child: (controller.loadCheckout)
              ? Center(
                  child: LoadingAnimationWidget.inkDrop(
                    color: Colors.white,
                    size: 20,
                  ),
                )
              : Text(check_out,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: Get.width * 0.051,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ))),
    );
  }
}
