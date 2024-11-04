import 'package:flutter/material.dart';
import 'package:furniture_app/data/models/product.dart';
import 'package:furniture_app/data/values/colors.dart';
import 'package:furniture_app/data/values/fonts.dart';
import 'package:furniture_app/screen/product_detail/controller/product_detail_controller.dart';
import 'package:get/get.dart';

import '../../add_cart_option/controller/add_cart_option_controller.dart';

class ProductDetailPage extends GetView<ProductDetailController> {
  @override
  Widget build(BuildContext? context) {
    if (controller.product != null) {
      return GetBuilder<ProductDetailController>(
          builder: (value) => Scaffold(
                backgroundColor: backgroundColor,
                body: SafeArea(child: buildBody(context, controller.product)),
              ));
    }
    return Container();
  }

  Container buildBody(context, Product product) {
    return Container(
      height: Get.height,
      width: Get.width,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  imageCustom(),
                  nameProductCustom(),
                  numberProductCustom(),
                  reviewProductCustom(product),
                ],
              ),
            ),
          ),
          buttonCustom(context)
        ],
      ),
    );
  }

  Row buttonCustom(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
            onTap: () {
              controller.clickFavorites();
            },
            child: Container(
              height: 60,
              width: 60,
              margin: const EdgeInsets.only(bottom: 16, left: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.withOpacity(0.1)),
              child: Icon(
                controller.favorite == 1
                    ? Icons.turned_in
                    : Icons.turned_in_not,
                color: Colors.green,
                size: 30,
              ),
            )),
        InkWell(
          onTap: () {
            // controller.clickCart();
            addToCart(context);
          },
          child: Container(
              height: 60,
              width: Get.width - 60 - 16 * 3 - 80,
              margin: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                        blurRadius: 4,
                        spreadRadius: 4,
                        offset: Offset(0, 5),
                        color: Color.fromRGBO(172, 171, 171, 0.2))
                  ],
                  borderRadius: BorderRadius.circular(10),
                  color: controller.statusCart
                      ? buttonColor
                      : buttonColor.withOpacity(0.5)),
              alignment: Alignment.center,
              child: Text(
                controller.statusCart ? "Add to cart" : "loading...",
                style: TextStyle(
                  fontFamily: jose_fin_sans,
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              )),
        ),
        Container(
            height: 60,
            width: 60,
            margin: const EdgeInsets.only(bottom: 16, right: 16),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.withOpacity(0.1)),
         ),
      ],
    );
  }

  Container reviewProductCustom(Product product) {
    return Container(
      padding: const EdgeInsets.only(left: 16, top: 8, right: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              const SizedBox(width: 5),
              Text(
                controller.product.numberStart.toString(),
                style: TextStyle(
                  fontFamily: jose_fin_sans,
                  fontSize: 24,
                  color: textGrey2Color,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 5),

            ],
          ),
          Text(
            controller.product.description.toString(),
            style: const TextStyle(
              // fontFamily: jose_fin_sans,
              fontSize: 18,
              color: textGrey2Color,
              fontWeight: FontWeight.w200,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Specifications:',
            style: const TextStyle(
              // fontFamily: jose_fin_sans,
              fontSize: 15,
              color: textGrey2Color,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            controller.product.caption.toString(),
            style: const TextStyle(
              // fontFamily: jose_fin_sans,
              fontSize: 18,
              color: textGrey2Color,
              fontWeight: FontWeight.w200,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Dimensions:',
            style: const TextStyle(
              // fontFamily: jose_fin_sans,
              fontSize: 15,
              color: textGrey2Color,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            controller.product.width.toString() +
                'cm' +
                ' x ' +
                controller.product.height.toString() +
                'cm' +
                ' x ' +
                controller.product.length.toString() +
                'cm',
            style: const TextStyle(
              // fontFamily: jose_fin_sans,
              fontSize: 18,
              color: textGrey2Color,
              fontWeight: FontWeight.w200,
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  Container nameProductCustom() {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.only(top: 8, left: 16),
      child: Text(
        controller.product.name.toString(),
        style: TextStyle(
          fontFamily: gelasio,
          fontSize: 24,
          color: textGrey2Color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Container numberProductCustom() {
    return Container(
      width: Get.width,
      padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
      child: Row(
        children: [
          Container(
            width: Get.width - 120 - 32,
            child: Text(
              "\$ ${controller.product.price}",
              style: const TextStyle(
                fontSize: 30,
                color: textGrey2Color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Spacer(),
          (controller.product.linkAR != null)
              ? const Icon(
                  Icons.view_in_ar_outlined,
                  size: 40,
                  color: textGreenColor,
                )
              : Container()
        ],
      ),
    );
  }

  Container imageCustom() {
    double height = Get.width * 0.8;
    return Container(
      height: height,
      width: Get.width,
      child: Stack(children: [
        Container(
          height: height,
          width: Get.width,
          child: PageView.builder(
              itemCount: (controller.product.imagePath ?? []).length,
              controller: controller.pageViewController,
              onPageChanged: (value) {
                controller.onChangedImagePage(value);
              },
              itemBuilder: (BuildContext context, int itemIndex) {
                return Container(
                  height: height,
                  width: Get.width - 50,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(50)),
                      image: DecorationImage(
                          image: NetworkImage(
                              controller.product.imagePath?[itemIndex] ?? ""),
                          fit: BoxFit.cover)),
                );
              }),
        ),
        InkWell(
          onTap: () {
            Get.back(result: controller.changed);
          },
          child: Container(
            margin: const EdgeInsets.only(top: 50, left: 30),
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: Colors.white),
            child: const Icon(Icons.arrow_back_ios_new_rounded),
          ),
        )
      ]),
    );
  }

  Container colorImageCustom() {
    return Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(left: 20),
        width: 64,
        decoration: BoxDecoration(boxShadow: [
          const BoxShadow(
              blurRadius: 4,
              spreadRadius: 8,
              color: Color.fromRGBO(172, 171, 171, 0.2))
        ], borderRadius: BorderRadius.circular(50), color: Colors.white),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            (controller.product.imageColorTheme ?? []).length,
            (index) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    controller.onChangedImageColor(index);
                  },
                  child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: index == controller.currentIndexImage
                              ? textGrey3Color
                              : Colors.white),
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: controller.product.imageColorTheme?[index] ??
                                Colors.black),
                      )),
                ),
                index < (controller.product.imageColorTheme ?? []).length - 1
                    ? const SizedBox(height: 15)
                    : const SizedBox(
                        height: 0,
                      )
              ],
            ),
          ),
        ));
  }

  Future addToCart(context) {
    // Check if the imagePath list is not null and not empty
    String imagePath = (controller.product.imagePath != null &&
            controller.product.imagePath!.isNotEmpty)
        ? controller.product.imagePath![0]
        : ""; // Use an empty string or a placeholder image if the list is empty

    return showModalBottomSheet(
        isScrollControlled: false,
        context: context,
        backgroundColor: backgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.only(
            topEnd: Radius.circular(30),
            topStart: Radius.circular(30),
          ),
        ),
        builder: (context) => AddCartOption(
              idProduct: controller.product.id.toString(),
              imagePath: imagePath,
              price: controller.product.price!,
              colors: controller.product.imageColorTheme ?? [],
              sizes: [
                '${controller.product.width}cm x ${controller.product.height}cm x ${controller.product.length}cm'
              ],
              height: controller.product.height,
              lenght: controller.product.length,
              width: controller.product.width,
            ));
  }
}
