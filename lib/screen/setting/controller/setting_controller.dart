import 'package:get/get.dart';
import '../../../data/models/user_profile.dart';
import '../../../data/repository/user_repository.dart';

class SettingController extends GetxController {
  late UserProfile users;
  bool load = false;

  @override
  void onInit() {
    super.onInit();
    users = Get.arguments;
  }

  bool isSwitched = true;

  void onSwitchedType(bool value) {
    if (value == true) {
      isSwitched = true;
    } else if (value == false) {
      isSwitched = false;
    }
    update();
  }

  Future<void> loadPage() async {
    load = true;
    users = await UserRepository().getUserProfile();
    update();
  }
}
