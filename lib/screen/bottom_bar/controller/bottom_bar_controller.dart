// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furniture_app/data/paths/icon_path.dart';
import 'package:furniture_app/screen/favorite/view/favorite_page.dart';
import 'package:furniture_app/screen/home/view/home_page.dart';
import 'package:furniture_app/screen/profile/view/profile_page.dart';
import 'package:get/get.dart';

class BottomBarController extends GetxController {
  List<String> icons_seleted_path = [];
  List<String> icons_path = [];
  Rx<int> indexCurren = 0.obs;
  @override
  void onInit() {
    super.onInit();
    icons_seleted_path = [
      icon_home_seleted,
      icon_favories_seleted,
      // icon_bell_seleted,
      icon_account_seleted
    ];
    icons_path = [icon_home, icon_favories, icon_bell, icon_account];
  }

  Widget getBody() {
    if (indexCurren.value == 0) return HomePage();
    if (indexCurren.value == 1) return FavoritePage();
    if (indexCurren.value == 3) return const ProfilePage();
    return Container();
  }

  void onChanged(int index) {
    if (index != indexCurren.value) {
      indexCurren.value = index;
      // update();
    }
  }

  Widget getIcon(int index) {
    return SizedBox(
        height: 25,
        width: 25,
        child: SvgPicture.asset(
          index == indexCurren.value
              ? icons_seleted_path[index]
              : icons_path[index],
          fit: BoxFit.contain,
        ));
  }
}
