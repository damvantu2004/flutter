import 'package:flutter/material.dart';
import 'package:furniture_app/data/models/product.dart';
import 'package:furniture_app/data/values/colors.dart';
import 'package:furniture_app/data/values/fonts.dart';
import 'package:furniture_app/screen/chatbot/controller/chatbot_controller.dart';
import 'package:get/get.dart';

class ShowProductPage extends GetView<ChatBotController> {
  List<Product> products;
  ShowProductPage({required this.products});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(
          top: 14,
          bottom: 14,
          left: 10,
          right: MediaQuery.of(context).size.width * 0.1 + 10,
        ),
        width: 380,
        color: backgroundColor,
        height: 240,
        child: PageView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (BuildContext context, int itemIndex) {
              return buildItem(itemIndex, products[itemIndex], context);
            }));
  }

  Widget buildItem(int index, Product product, context) {
    return InkWell(
      onTap: () {
        controller.toDetailProduct(product);
      },
      child: Container(
        width: MediaQuery.of(context).size.width - (MediaQuery.of(context).size.width * 0.1 + 20),
        color: WHITE,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 170,
              width: 350,
              margin: const EdgeInsets.only(left: 20, right: 20, top: 5),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), image: DecorationImage(image: NetworkImage(product.imagePath?[0] ?? "https://firebasestorage.googleapis.com/v0/b/furnitureapp-27389.appspot.com/o/image_product%2Farmchair%2F4eETjjDxq6BqPei%2Freceived_2186990474834150.webp?alt=media&token=68e7817d-48a0-4d85-ad00-b0b6bfd16922"), fit: BoxFit.fill)),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 5),
              width: 500,
              child: Text(
                product.name.toString(),
                textAlign: TextAlign.left,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: gelasio,
                  fontSize: 16,
                  color: textBlackColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              child: Text(
                '\$ ${product.price}',
                style: const TextStyle(
                  fontSize: 16,
                  color: buttonColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
