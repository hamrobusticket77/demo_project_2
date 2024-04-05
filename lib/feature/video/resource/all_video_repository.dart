
import '../model/video_model.dart';

class AllVideoRepository {
  final Map<String, VideoModel> _video = {};
  Map<String, VideoModel> get getVideos => _video;

  addAll(Map<String, VideoModel> other) {
    _video.addAll(other);
  }
}
