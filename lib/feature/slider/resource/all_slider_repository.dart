import '../model/slider_model.dart';

class AllSliderRepository {
  final Map<String, SliderModel> _slider = {};
  Map<String, SliderModel> get getSlider => _slider;

  addAll(Map<String, SliderModel> other) {
    _slider.addAll(other);
  }

}
