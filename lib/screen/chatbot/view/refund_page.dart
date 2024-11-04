import 'package:flutter/material.dart';
import 'package:furniture_app/data/values/colors.dart';
import 'package:furniture_app/data/values/fonts.dart';
import 'package:furniture_app/data/values/strings.dart';
import 'package:furniture_app/data/paths/icon_path.dart';
import 'package:furniture_app/screen/chatbot/controller/chatbot_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RefundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Get.height * 0.024),
      margin: EdgeInsets.only(
        top: 14,
        bottom: 14,
        left: 10,
        right: Get.width * 0.1 + 10,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: buttonColor,
          ),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            refund,
            style: TextStyle(
                fontFamily: jose_fin_sans,
                fontWeight: FontWeight.w600,
                fontSize: Get.height * 0.025,
                color: Colors.black),
          ),
          SizedBox(height: Get.height * 0.006),
          Text(refund1,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 15, color: textGrey)),
          Container(
            margin: EdgeInsets.only(
                top: Get.height * 0.021, bottom: Get.height * 0.012),
            height: Get.height * 0.0002,
            color: textGrey1Color,
          ),
          InkWell(
            child: Text(
              view_post,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: Get.height * 0.02,
                  color: buttonColor),
            ),
            onTap: () {
              showModalBottomSheet<void>(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      padding: EdgeInsets.all(Get.height * 0.024),
                      color: backgroundColor,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                  left: Get.height * 0.15,
                                  right: Get.height * 0.15,
                                  bottom: Get.height * 0.024),
                              height: Get.height * 0.004,
                              color: textGrey1Color,
                            ),
                            Text(
                              refund,
                              style: TextStyle(
                                  fontFamily: jose_fin_sans,
                                  fontWeight: FontWeight.w600,
                                  fontSize: Get.height * 0.025,
                                  color: Colors.black),
                            ),
                            SizedBox(height: Get.height * 0.018),
                            Text(refund1,
                                style: TextStyle(
                                    fontSize: Get.height * 0.019,
                                    color: textGrey)),
                            SizedBox(height: Get.height * 0.006),
                            Text(refund2,
                                style: TextStyle(
                                    fontSize: Get.height * 0.019,
                                    color: textGrey)),
                            SizedBox(height: Get.height * 0.006),
                            Text(refund3,
                                style: TextStyle(
                                    fontSize: Get.height * 0.019,
                                    color: textGrey)),
                            SizedBox(height: Get.height * 0.006),
                            Text(refund4,
                                style: TextStyle(
                                    fontSize: Get.height * 0.019,
                                    color: textGrey)),
                            SizedBox(height: Get.height * 0.006),
                            Text(refund5,
                                style: TextStyle(
                                    fontSize: Get.height * 0.019,
                                    color: textGrey)),
                            SizedBox(height: Get.height * 0.012),
                            Text(refund6,
                                style: TextStyle(
                                    fontSize: Get.height * 0.019,
                                    color: textGrey)),
                            SizedBox(height: Get.height * 0.05),
                          ],
                        ),
                      ),
                    );
                  });
            },
          )
        ],
      ),
    );
  }
}
