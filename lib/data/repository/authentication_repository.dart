import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shutter_ease/features/Authetication/Model/user_model.dart';
import 'package:shutter_ease/features/Authetication/View/Signin/signin_screen.dart';
import 'package:shutter_ease/utills/Errors/Exceptions/firebase_auth_exceptions.dart';
import 'package:shutter_ease/utills/Errors/Exceptions/firebase_exceptions.dart';
import 'package:shutter_ease/utills/Errors/Exceptions/platform_exceptions.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  // Create user account and store in Realtime Database
  Future createUserAccount(String name, String email, String password,
      String confirmPassword) async {
    try {
      // Create user account with Firebase Authentication
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String uid = userCredential.user!.uid;

      // Create admin model with required data
      final time = DateTime.now().millisecondsSinceEpoch.toString();
      final userData = UserModel(
        id: uid,
        name: name,
        email: email,
        password: password,
        createdAt: time,
        lastActive: time,
        status: 'active',
        pushToken: '',
        profilePic: '',
        gender: '',
        phoneNumber: '',
        dateOfBirth: '',
      );

      // Store admin data in Realtime Database
      await FirebaseDatabase.instance.ref('users/$uid').set(userData.toMap());
    } on FirebaseAuthException catch (e) {
      throw EFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw EFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw EPlatformException(e.code).message;
    } catch (e) {
      throw 'An unexpected error occurred: ${e.toString()}';
    }
  }

  // Login
  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Return null to indicate successful login
      return null;
    } on FirebaseAuthException catch (e) {
      // Handle FirebaseAuthException
      throw EFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      // Handle general Firebase exceptions
      throw EFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      // Handle platform-specific exceptions
      throw EPlatformException(e.code).message;
    } catch (e) {
      // Catch any other unexpected errors
      throw 'An unexpected error occurred: ${e.toString()}';
    }
  }

  // Reset Password Request
  Future resetPassword({
    required String email,
  }) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email)
          .then((value) {
        return 'An email has been sent to reset the password';
      });
    } on FirebaseAuthException catch (e) {
      throw EFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw EFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw EPlatformException(e.code).message;
    } catch (e) {
      throw 'An unexpected error occurred: ${e.toString()}';
    }
  }

  // SignOut Warning Popup
  void signOutWarningPopup() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(10),
      title: 'Sign out',
      middleText: 'Are you sure you want to sign out of your account?',
      confirm: ElevatedButton(
        onPressed: () async {
          await logout();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          side: const BorderSide(color: Colors.red),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Signout',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      cancel: OutlinedButton(
        child: const Text('Cancel'),
        onPressed: () {
          Get.back();
        },
      ),
    );
  }

  // Logout Function
  Future logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.to(() => const SigninScreen());
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message ?? 'An error occurred during sign out');
    } on FirebaseException catch (e) {
      Get.snackbar('Error', e.message ?? 'Firebase error occurred');
    } on PlatformException catch (e) {
      Get.snackbar('Error', e.message ?? 'Platform error occurred');
    } catch (e) {
      Get.snackbar('Error', 'An unexpected error occurred: ${e.toString()}');
    }
  }
}
