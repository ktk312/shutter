import 'package:get/get.dart';
import 'package:shutter_ease/utills/helper/Network%20Manager/network_manager.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
  }
}
