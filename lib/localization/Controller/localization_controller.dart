import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shutter_ease/localization/Languages/localization_en.dart';
import 'package:shutter_ease/localization/Languages/localization_it.dart';

class LocalizationController extends GetxController {
  final String _defaultLang = 'it';
  RxString _languageCode = 'it'.obs;

  String get languageCode => _languageCode.value;

  @override
  void onInit() {
    super.onInit();
    _loadLanguage(); // Load language preference on initialization
  }

  Future<void> _loadLanguage() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _languageCode.value = prefs.getString('language_code') ?? _defaultLang;
      update(); // Notify listeners to update UI
      print('Language loaded: ${_languageCode.value}'); // Debugging line
    } catch (e) {
      print('Error loading language: $e'); // Error handling
    }
  }

  Future<void> changeLanguage(String langCode) async {
    _languageCode.value = langCode; // Update the observable value
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', langCode);
    update(); // Notify listeners to update UI
  }

  Map<String, String> get localizedValues {
    switch (_languageCode.value) {
      case 'it':
        return LocalizationIt.values;
      case 'en':
      default:
        return LocalizationEn.values;
    }
  }
}
