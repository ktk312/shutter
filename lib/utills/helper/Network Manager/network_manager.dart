import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shutter_ease/utills/Errors/Error%20handler/error_handler.dart';

class NetworkManager extends GetxController {
  static NetworkManager get instance => Get.find();

  final Connectivity connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  final Rx<ConnectivityResult> connectionStatus = ConnectivityResult.none.obs;

  @override
  void onInit() {
    super.onInit();
    _connectivitySubscription = connectivity.onConnectivityChanged
        .listen((List<ConnectivityResult> results) {
      if (results.isNotEmpty) {
        updateConnectionStatus(results.first);
      }
    });
  }

  Future<void> updateConnectionStatus(ConnectivityResult result) async {
    connectionStatus.value = result;
    if (connectionStatus.value == ConnectivityResult.none) {
      ErrorHandler.showErrorSnackbar('No internet connection');
    }
  }

  Future<bool> isConnected() async {
    try {
      final result = await connectivity.checkConnectivity();
      // ignore: unrelated_type_equality_checks
      return result != ConnectivityResult.none;
    } on PlatformException catch (_) {
      return false;
    }
  }

  @override
  void onClose() {
    super.onClose();
    _connectivitySubscription.cancel();
  }
}
