import 'package:krishi_hub/feature/images/model/image_album_model.dart';

class AllImagesRepository {
  final Map<int, ImageAlbumModel> _images = {};
  Map<int, ImageAlbumModel> get getImages => _images;

  addAll(Map<int, ImageAlbumModel> other) {
    _images.addAll(other);
  }
}
