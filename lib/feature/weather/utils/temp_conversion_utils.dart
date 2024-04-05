import 'package:krishi_hub/common/utils/text_utils.dart';

class TempConversionUtils {
  static covertFahrenheitToCelsius(double value) {
    double temp = (value - 32.0) * 5 / 9;

    return temp.round().toString().toNepali();
  }

  static convertKelvinToCelsius(double value) {
    return (value - 273.15).round().toString().toNepali();
  }
}
