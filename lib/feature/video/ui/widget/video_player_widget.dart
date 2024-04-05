import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/widget/app_bar/custom_app_bar.dart';
import 'package:krishi_hub/feature/video/model/video_model.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoPlayerWidget extends StatefulWidget {
  final VideoModel videoModel;
  const VideoPlayerWidget({super.key, required this.videoModel});

  @override
  State<VideoPlayerWidget> createState() => _YouTubeVideoPlayerWidgetState();
}

class _YouTubeVideoPlayerWidgetState extends State<VideoPlayerWidget> {
  YoutubePlayerController? controller;

  @override
  void initState() {
    controller = null;
    controller = YoutubePlayerController.fromVideoId(
      videoId: widget.videoModel.videoUrl,
      autoPlay: false,
      params: const YoutubePlayerParams(
        showControls: true,
        mute: false,
        showFullscreenButton: true,
        loop: false,
      ),
    );

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // if (controller != null) {
    //   controller!.close();
    // }
  }

  @override
  void didUpdateWidget(covariant VideoPlayerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: const CustomAppBar(
        title: "Video Player",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (controller != null)
              YoutubePlayerScaffold(
                autoFullScreen: false,
                backgroundColor: CustomTheme.lightGray,
                enableFullScreenOnVerticalDrag: true,
                fullscreenOrientations: const [DeviceOrientation.landscapeLeft],
                defaultOrientations: const [DeviceOrientation.portraitUp],
                controller: controller!,
                builder: (context, player) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 15.hp),
                    child: Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(5))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(child: player),
                          SizedBox(height: 5.hp),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.videoModel.title,
                                  style: textTheme.bodyLarge!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 20.hp,
                                ),
                                Text(
                                  widget.videoModel.description,

                                  // maxLines: 1,
                                  style: textTheme.bodyMedium!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              )
          ],
        ),
      ),
    );
  }
}
