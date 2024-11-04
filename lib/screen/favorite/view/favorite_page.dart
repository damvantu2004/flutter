import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furniture_app/data/models/product.dart';
import 'package:furniture_app/data/paths/icon_path.dart';
import 'package:furniture_app/data/values/colors.dart';
import 'package:furniture_app/data/values/fonts.dart';
import 'package:furniture_app/data/values/strings.dart';
import 'package:furniture_app/screen/favorite/controller/favorite_controller.dart';
import 'package:furniture_app/screen/product_detail/view/product_detail_page.dart';
import 'package:get/get.dart';

import '../../add_cart_option/controller/add_cart_option_controller.dart';

class FavoritePage extends GetView<FavoriteController> {
  FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavoriteController>(
        builder: (value) => Scaffold(
              backgroundColor: backgroundColor,
              appBar: appBarCustom(),
              body: _buildBody(context),
            ));
  }

  Widget _buildBody(context) {
    return Container(
      height: Get.height,
      width: Get.width,
      margin: const EdgeInsets.only(bottom: 76, left: 16, right: 16),
      child: SingleChildScrollView(
        child: Column(
          children: List.generate(
            controller.products.length,
                (index) => buildItem(context, index, controller.products[index]),
          ),
        ),
      ),
    );
  }

  Column buildItem(context, int index, Product product) {
    return Column(
      children: [
        Container(
          height: 100,
          width: Get.width - 16 * 2,
          margin: const EdgeInsets.only(bottom: 12, top: 12),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  Get.to(ProductDetailPage(),
                      arguments: {'product': product, 'favorite': true});
                },
                child: Row(
                  children: [
                    Container(
                      height: 100,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                          image: NetworkImage(
                            product?.imagePath != null && product!.imagePath!.isNotEmpty && product.imagePath![0].isNotEmpty
                                ? product.imagePath![0]
                                : "https://scontent.fhan19-1.fna.fbcdn.net/v/t45.5328-4/441968936_786522690294388_192808687243888620_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=247b10&_nc_eui2=AeG4tWZLQYT_l6fYUDYed2DcnHrI7dWEC5Scesjt1YQLlDf8cXURswacYh4ECIGHBh9Jk78gNpWdR2qK4Q3NqgVg&_nc_ohc=bhjvb1j567MQ7kNvgHd-xD8&_nc_ht=scontent.fhan19-1.fna&oh=00_AYDVNkNCRKL8YXArbJ_AOZq4_auow0L8fw8kIyroXIQ6XQ&oe=66D3E223", // URL for a random image
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    Container(
                      height: 100,
                      width: Get.width - 16 * 2 - 150 - 30,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name.toString(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: gelasio,
                              fontSize: 16,
                              color: textGrey3Color,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '\$ ${product.price}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: textGrey3Color,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 100,
                width: 30,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: () {
                          controller.deleteItemWithIndex(index);
                        },
                        child: SvgPicture.asset(icon_delete)),
                    InkWell(
                      onTap: () {
                        // controller.addItemWithIndex(index);
                        addToCart(context, index);
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10)),
                        child: SvgPicture.asset(
                          icon_bag,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 1,
          width: Get.width - 16 * 2,
          color: const Color.fromRGBO(253, 233, 195, 1),
        )
      ],
    );
  }

  Future addToCart(BuildContext context, int index) {
    final product = controller.products[index];
    // Safely check if imagePath is not empty before accessing the first element
    final imagePath = (product.imagePath != null && product.imagePath!.isNotEmpty)
        ? product.imagePath![0]
        : "";

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
        idProduct: product.id.toString(),
        imagePath: imagePath,
        price: product.price ?? 0, // Ensure price is not null
        colors: product.imageColorTheme ?? [],
        sizes: [
          '${product.width}cm x ${product.height}cm x ${product.length}cm'
        ],
        height: product.height ?? 0,
        lenght: product.length ?? 0,
        width: product.width ?? 0,
      ),
    );
  }

  AppBar appBarCustom() {
    return AppBar(
        elevation: 0,
        backgroundColor: backgroundColor,
        leading: SizedBox(
            height: 10,
            width: 10,
            child: SvgPicture.asset(icon_search, fit: BoxFit.scaleDown)),
        actions: [
          Stack(
            children: [
              SizedBox(
                height: Get.height * 0.065,
                width: Get.height * 0.065,
                child: SvgPicture.asset(icon_cart, fit: BoxFit.scaleDown),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                    top: Get.height * 0.01, left: Get.height * 0.0349),
                width: Get.height * 0.025,
                height: Get.height * 0.025,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                    border: Border.all(color: Colors.white, width: 1)),
                child: Text(
                  controller.carts.length.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: Get.height * 0.0148,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
        title: Align(
          child: Text(
            favories,
            style: TextStyle(
                fontFamily: gelasio,
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: textBlackColor.withOpacity(0.8)),
          ),
        ));
  }
}
