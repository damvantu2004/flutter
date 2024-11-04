import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furniture_app/data/models/product.dart';
import 'package:furniture_app/data/paths/icon_path.dart';
import 'package:furniture_app/data/values/colors.dart';
import 'package:furniture_app/data/values/fonts.dart';
import 'package:furniture_app/data/values/strings.dart';
import 'package:furniture_app/screen/cart/view/cart_page.dart';
import 'package:furniture_app/screen/chatbot/view/chatbot_page.dart';
import 'package:furniture_app/screen/home/controller.dart/home_controller.dart';
import 'package:furniture_app/screen/search_product/view/search_page.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HomePage extends GetView<HomeController> {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (value) => Scaffold(
        backgroundColor: backgroundColor,
        appBar: appBarCustom(),
        body: controller.loadDatacategory
            ? Center(
                child: LoadingAnimationWidget.fourRotatingDots(
                color: Colors.black,
                size: 30,
              ))
            : buildBody(context),
        floatingActionButton: Wrap(
          direction: Axis.vertical,
          children: [
            const SizedBox(height: 10),
            FloatingActionButton(
              onPressed: () {
                Get.to(ChatBotPage());
              },
              tooltip: 'Increment',
              child: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(
                  avatar_chatbot,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildBody(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Column(
        children: [
          menuCustom(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

          ),
          Expanded(  // Added Expanded here to prevent overflow
            child: controller.loadDataProduct
                ? Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: Colors.black,
                size: 30,
              ),
            )
                : buildProducts(),
          ),
        ],
      ),
    );
  }

  Widget buildProducts() {
    return Container(
      height: Get.height - 280,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: controller.products.length == 0
          ? const Text(
              "The product has not been updated",
              style: TextStyle(fontSize: 18, color: textGrey2Color),
            )
          : MasonryGridView.count(
              itemCount: controller.products.length,
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              itemBuilder: (context, index) {
                return productItem(controller.products[index]);
              },
            ),
    );
  }

  Widget productItem(Product product) {
    double height = (Get.width - 60) / 2 * 0.7;
    if (height > 200) height = 200;
    return InkWell(
      onTap: () {
        controller.clickProduct(product);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (product.imagePath != null && product.imagePath!.isNotEmpty)
            Container(
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: NetworkImage(product.imagePath![0]),
                  fit: BoxFit.cover,
                ),
              ),
            )
          else
            Container(
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey, // Placeholder color for products without images
              ),
              child: Center(
                child: Icon(Icons.image_not_supported, color: Colors.white),
              ),
            ),
          const SizedBox(height: 10),
          Text(
            product.name.toString(),
            style: TextStyle(fontFamily: jose_fin_sans, color: textGrey2Color),
          ),
          const SizedBox(height: 10),
          Text(
            "\$ ${product.price}",
            style: TextStyle(fontFamily: jose_fin_sans, color: textBlackColor),
          ),
        ],
      ),
    );
  }

  Widget menuCustom() {
    List<Widget> items = [];
    for (int i = 0; i < controller.menu.length; i++) {
      items.add(menuItem(
          i,
          i == controller.currentIndex,
          controller.menu[i].name.toString(),
          controller.menu[i].imagePath.toString()));
      items.add(const SizedBox(
        width: 25,
      ));
    }
    return Container(
      width: Get.width,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: items,
        ),
      ),
    );
  }

  Widget menuItem(int index, bool onSelected, content, iconPath) {
    return InkWell(
      onTap: () {
        if (onSelected == false) {
          controller.onSeletedMenu(index);
        }
      },
      child: Column(
        children: [
          Container(
            height: 44,
            width: 44,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: onSelected
                    ? const Color.fromRGBO(250, 202, 123, 1)
                    : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10)),
            child: Image.asset(iconPath),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 70,
            child: Text(content,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: jose_fin_sans,
                    color: onSelected ? textBlackColor : textGrey1Color)),
          )
        ],
      ),
    );
  }



  Widget sortCustom() {
    return InkWell(
      onTap: () {
        controller.sortProduct();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: Get.height * 0.024),
        child: Row(
          children: [
            Transform.scale(
                scale: controller.sortIncreate ? 1 : -1,
                child: Icon(Icons.sort_outlined,
                    color: controller.sort
                        ? (controller.sortIncreate ? Colors.green : Colors.red)
                        : Colors.black)),
            const SizedBox(width: 10),
            Text(
              'Sort',
              style: TextStyle(
                  color: controller.sort
                      ? (controller.sortIncreate ? Colors.green : Colors.red)
                      : Colors.black),
            ),
          ],
        ),
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
        child: IconButton(
          icon: SvgPicture.asset(icon_search, fit: BoxFit.scaleDown),
          onPressed: () {
            Get.to(const SearchPage());
          },
        ),
      ),
      actions: [
        InkWell(
          onTap: () {
            Get.to(CartPage());
          },
          child: Stack(
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
        ),
      ],
      title: SizedBox(
        width: Get.width,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            home_title,
            style: TextStyle(
                fontFamily: gelasio,
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: textGreyColor),
          ),
          Text(
            home_sub_title.toUpperCase(),
            style: TextStyle(
                fontFamily: gelasio,
                fontWeight: FontWeight.w800,
                fontSize: 16,
                color: textBlackColor),
          )
        ]),
      ),
    );
  }


}
