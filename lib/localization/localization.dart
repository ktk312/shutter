import 'package:get/get.dart';
import 'package:shutter_ease/localization/Languages/localization_en.dart';
import 'package:shutter_ease/localization/Languages/localization_it.dart';

class Localization extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': LocalizationEn.values,
        'it': LocalizationIt.values,
      };
}
