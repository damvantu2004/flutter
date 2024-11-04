import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:furniture_app/data/auth/auth_service.dart';

import '../../screen/bottom_bar/view/bottom_bar_page.dart';
import '../../screen/splash/view/splash_page.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    var _stream = AuthService.authChanges;

    return StreamBuilder<User?>(
      stream: _stream,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return const BottomBarPage();
        } else {
          return const SplashPage();
        }
      },
    );
  }
}
