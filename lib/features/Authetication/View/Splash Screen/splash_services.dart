import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shutter_ease/features/Authetication/View/Signin/signin_screen.dart';
import 'package:shutter_ease/features/Dashboard/View/Home%20Screen/home_screen.dart';

class SplashServices {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  void checkUserStatus(BuildContext context) async {
    if (firebaseAuth.currentUser != null) {
      Timer(const Duration(seconds: 3), () async {
        Get.to(() => const HomeScreen());
      });
    } else {
      Timer(const Duration(seconds: 3), () {
        Get.to(
          () => const SigninScreen(),
          duration: const Duration(seconds: 2),
          transition: Transition.fade,
        );
      });
    }
  }
}
