import 'package:furniture_app/screen/cart/controller/cart_controller.dart';
import 'package:furniture_app/screen/edit_profile/controller/edit_profile_controller.dart';
import 'package:furniture_app/screen/password/change_password/change-password_controller.dart';
import 'package:furniture_app/screen/setting/controller/setting_controller.dart';
import 'package:get/get.dart';
import 'screen/auth/login/controller/login_controller.dart';
import 'screen/auth/signup/controller/signup_controller.dart';
import 'screen/chatbot/controller/chatbot_controller.dart';
import 'screen/checkout/controller/checkout_controller.dart';
// import 'screen/congrats/controller/congrats_controller.dart';
import 'screen/favorite/controller/favorite_controller.dart';
import 'screen/product_detail/controller/product_detail_controller.dart';
import 'screen/search_product/controller/search_controller.dart';
import 'screen/splash/controller/splash_controller.dart';
import 'screen/order/controller/order_controller.dart';
import 'screen/profile/controller/profile_controller.dart';
import 'screen/home/controller.dart/home_controller.dart';
import 'screen/bottom_bar/controller/bottom_bar_controller.dart';
import 'screen/detail_order/controller/detail_order_controller.dart';

class MyBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut<OrderController>(() => OrderController(), fenix: true);
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);
    Get.lazyPut<BottomBarController>(() => BottomBarController(), fenix: true);
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<FavoriteController>(() => FavoriteController(), fenix: true);
    Get.lazyPut<ProductDetailController>(() => ProductDetailController(),
        fenix: true);
    Get.lazyPut<SplashController>(() => SplashController(), fenix: true);
    Get.lazyPut<DetailOrderController>(() => DetailOrderController(),
        fenix: true);


    Get.lazyPut<LoginController>(() => LoginController(), fenix: true);
    Get.lazyPut<SignUpController>(() => SignUpController(), fenix: true);
    Get.lazyPut<CheckoutController>(() => CheckoutController(), fenix: true);


    Get.lazyPut<CartController>(() => CartController(), fenix: true);

    Get.lazyPut<OrderController>(() => OrderController(), fenix: true);
    Get.lazyPut<ChatBotController>(() => ChatBotController(), fenix: true);
    Get.lazyPut<SearchPageController>(() => SearchPageController(),
        fenix: true);

    // Get.lazyPut<CongratsController>(() => CongratsController(), fenix: true);
    Get.lazyPut<EditProfileController>(() => EditProfileController(),
        fenix: true);
    Get.lazyPut<SettingController>(() => SettingController(), fenix: true);






    Get.lazyPut<ChangePasswordController>(() => ChangePasswordController(),
        fenix: true);

  }
}
