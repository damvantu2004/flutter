import 'package:flutter/material.dart';
import 'package:furniture_app/data/values/colors.dart';
import 'package:furniture_app/data/values/fonts.dart';
import 'package:furniture_app/data/values/strings.dart';
import 'package:furniture_app/screen/checkout/controller/checkout_controller.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CheckoutPage extends GetView<CheckoutController> {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckoutController>(
      builder: (value) => Scaffold(
        backgroundColor: backgroundColor,
        appBar: buildAppBar(),
        body: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: _buildBody()),
      ),
    );
  }

  AppBar buildAppBar() => AppBar(
        centerTitle: true,
        //automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
          titleCheckout,
          style: TextStyle(
            color: textHeaderColor,
            fontFamily: 'JosefinSans',
            //--------TODO CHANGE FONT TEXT FINAL -----------
            fontSize: Get.width * 0.05,
            fontWeight: FontWeight.w700,
          ),
        ),
        leading: InkWell(
          onTap: () => Get.back(),
          child: Padding(
            padding: EdgeInsets.only(left: Get.width * 0.05),
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: Get.width * 0.05,
            ),
          ),
        ),
        backgroundColor: backgroundColor,
      );

  Widget _buildBody() => SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.045),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildListProduct(),
              titleEdit(isAddress: true),
              titleEdit(isPayment: true),
              contentEditPayment(),
              textDiscount(),
              buildCheckout(),
              SizedBox(
                height: Get.height * 0.04,
              ),
              _buttonConfirm(),
            ],
          ),
        ),
      );

  Widget _buildListProduct() {
    if (controller.carts.isEmpty) {
      return Center(
        child: Text(
          "Your cart is empty",
          style: TextStyle(
            fontSize: 16,
            color: Colors.black.withOpacity(0.8),
            fontFamily: nunito_sans,
          ),
        ),
      );
    }

    List<Widget> c = [];
    for (int i = 0; i < controller.carts.length; i++) {
      c.addAll([buildItemProduct(i), const Divider()]);
    }
    return Column(children: c);
  }

  Widget textDiscount() {
    return InkWell(

      child: Container(
        height: 50,
        padding: const EdgeInsets.only(left: 10),
        margin: const EdgeInsets.only(top: 20, bottom: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: backgroundColor,
          boxShadow: const [
            BoxShadow(
              color: ColorShadow,
              blurRadius: 10,
              spreadRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  color: buttonColor, borderRadius: BorderRadius.circular(10)),
              margin: const EdgeInsets.only(right: 5),
              child: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white,
                size: 20,
              ),
            )
          ],
        ),
      ),
    );
  }



  Center _buttonConfirm() {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 6,
              offset: Offset(1, 3), // Shadow position
            ),
          ],
        ),
        child: Center(
          child: InkWell(
            onTap: () {
              controller.clickPaymentButton();
            },
            child: Container(
              width: Get.width * 0.5,
              height: Get.height * 0.05,
              padding: EdgeInsets.all(Get.height * 0.015),
              child: controller.paymentLoadButton
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "LOADING  ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'JosefinSans',
                          ),
                        ),
                        LoadingAnimationWidget.waveDots(
                          color: Colors.white,
                          size: 20,
                        )
                      ],
                    )
                  : const Text(
                      "PAYMENT",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'JosefinSans',
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildItemProduct(int index) {
    return SizedBox(
      width: Get.width,
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          height: 100,
          width: 130,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              // image: DecorationImage(
              //   image: NetworkImage(
              //     controller.products[index].imagePath?[0] ?? "".toString(),
              //   ),
              //   fit: BoxFit.cover,
              // ),
          ),
        ),
        Container(
          width: Get.width - 170,
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
                fontWeight: FontWeight.w600,
                fontSize: Get.width * 0.05,
                fontFamily: nunito_sans,
              ),
            ),
            Text(
              "Amount: ${controller.carts[index].amount}",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black.withOpacity(0.8),
                fontFamily: nunito_sans,
              ),
            ),
            Row(
              children: [
                Text(
                  "Color: ",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black.withOpacity(0.8),
                    fontFamily: nunito_sans,
                  ),
                ),
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: controller.carts[index].color,
                  ),
                ),
              ],
            ),
            Text(
              "${controller.carts[index].length} x ${controller.carts[index].width} x ${controller.carts[index].height}",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black.withOpacity(0.8),
                fontFamily: nunito_sans,
              ),
            ),
          ]),
        ),
      ]),
    );
  }

  Widget contentEditPayment() {
    return Container(
      padding: EdgeInsets.all(Get.width * 0.005),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(96, 96, 96, 0.2),
            spreadRadius: 4,
            blurRadius: 10, // Shadow position
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(
                left: Get.width * 0.02, right: Get.width * 0.05),
            child:SizedBox(
              width: Get.width * 0.2,
              height: Get.height * 0.08,
              child: Image.asset(
                visaIcon,
                fit: BoxFit.scaleDown,
              ),
            ),


          ),
          Text(
            "Payment in cash",
            style: TextStyle(
              fontFamily: 'JosefinSans',
              fontWeight: FontWeight.w600,
              fontSize: Get.height * 0.02,
            ),
          ),
        ],
      ),
    );
  }

  Widget contentEditDelivery(String image, String content) {
    return Container(
      padding: EdgeInsets.all(Get.width * 0.005),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(96, 96, 96, 0.2),
            spreadRadius: 4,
            blurRadius: 10, // Shadow position
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(
                left: Get.width * 0.02, right: Get.width * 0.05),
            child: SizedBox(
              width: Get.width * 0.2,
              height: Get.height * 0.08,
              child: Image.asset(
                image,
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
          Text(
            content,
            style: TextStyle(
              fontFamily: 'JosefinSans',
              fontWeight: FontWeight.w600,
              fontSize: Get.height * 0.02,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCheckout() {
    return Container(
      padding: EdgeInsets.all(Get.width * 0.03),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(96, 96, 96, 0.2),
            spreadRadius: 4,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                orderTitle,
                style: TextStyle(
                  fontFamily: 'JosefinSans',
                  fontWeight: FontWeight.w400,
                  fontSize: Get.height * 0.025,
                ),
              ),
              const Spacer(),
              Text(
                '\$ ${controller.priceOrder.toStringAsFixed(2)}',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: Get.height * 0.025,
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(
              top: Get.height * 0.015,
            ),
            child: Row(
              children: [
                Text(
                  deliveryTitle,
                  style: TextStyle(
                    fontFamily: 'JosefinSans',
                    fontWeight: FontWeight.w400,
                    fontSize: Get.height * 0.025,
                  ),
                ),
                const Spacer(),
                Text(
                  '\$ ${controller.priceDelivery.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: Get.height * 0.025,
                  ),
                ),
              ],
            ),
          ),
          if (controller.priceDiscount != 0)
            Container(
              margin: EdgeInsets.only(
                top: Get.height * 0.015,
              ),
              child: Row(
                children: [
                  Text(
                    "Discount",
                    style: TextStyle(
                      fontFamily: 'JosefinSans',
                      fontWeight: FontWeight.w400,
                      fontSize: Get.height * 0.025,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '\$ ${controller.priceDiscount.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: Get.height * 0.025,
                    ),
                  ),
                ],
              ),
            ),
          Container(
            margin: EdgeInsets.only(
              top: Get.height * 0.015,
            ),
            child: Row(
              children: [
                Text(
                  totalTitle,
                  style: TextStyle(
                    fontFamily: 'JosefinSans',
                    fontWeight: FontWeight.w400,
                    fontSize: Get.height * 0.025,
                  ),
                ),
                const Spacer(),
                Text(
                  '\$ ${controller.priceTotal.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: Get.height * 0.025,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget titleEdit({bool isPayment = false, bool isAddress = false}) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              isAddress ? shippingAddressTitle : payMentTitle,
              style: TextStyle(
                  fontFamily: 'JosefinSans',
                  fontSize: Get.height * 0.025,
                  fontWeight: FontWeight.w600),
            ),
            const Spacer(),

          ],
        ),
      ],
    );
  }
}
