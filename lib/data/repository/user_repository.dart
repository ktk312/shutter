import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shutter_ease/utills/Errors/Exceptions/firebase_auth_exceptions.dart';
import 'package:shutter_ease/utills/Errors/Exceptions/firebase_exceptions.dart';
import 'package:shutter_ease/utills/Errors/Exceptions/platform_exceptions.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  // Firebase instances
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  // Variable to dynamically store user data
  RxMap<String, dynamic> userData = <String, dynamic>{}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord(); 
  }

  Future<void> fetchUserRecord() async {
    try {
      final user = await fetchUserDetail();
      userData.assignAll(user);
    } catch (e) {
      userData.clear(); // Clear user data on error
    }
  }

  ///************ Fetch and Display - Dashboard ************///
  Future<Map<String, dynamic>> fetchUserDetail() async {
    try {
      // Get the current user UID from FirebaseAuth
      final String? uid = _firebaseAuth.currentUser?.uid;

      if (uid == null) {
        throw 'User not logged in';
      }

      // Fetch user details from Realtime Database based on UID
      final DatabaseReference userRef = _database.ref('users/$uid');
      final DatabaseEvent event = await userRef.once();

      if (event.snapshot.exists) {
        return Map<String, dynamic>.from(event.snapshot.value as Map);
      } else {
        return {}; // Return empty map if no data found
      }
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
}
