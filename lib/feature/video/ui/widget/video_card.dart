import 'package:flutter/material.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/widget/date_formater_utils.dart';
import 'package:krishi_hub/feature/video/ui/widget/video_player_widget.dart';

import '../../../../common/app/theme.dart';
import '../../../../common/common_card_wapper.dart';
import '../../../../common/common_svg_widget.dart';
import '../../../../common/constant/constant_assets.dart';
import '../../../../common/image/custom_network_image.dart';
import '../../../../common/navigation/navigation_service.dart';
import '../../model/video_model.dart';

class VideoCard extends StatefulWidget {
  final VideoModel videoModel;
  const VideoCard({
    super.key,
    required this.videoModel,
  });

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  @override
  void initState() {
    super.initState();
  }

  String getYouTubeThumbnail(String videoId) {
    return 'https://img.youtube.com/vi/$videoId/0.jpg';
  }

  @override
  void dispose() {
    // controller?.close();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant VideoCard oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return CommonCardWrapper(
      onTap: () {
        NavigationService.push(
            target: VideoPlayerWidget(
          videoModel: widget.videoModel,
        ));
      },
      hasShadow: false,
      backgroundColor: CustomTheme.lighterGrey,
      margin: EdgeInsets.symmetric(vertical: 10.hp),
      // padding: const EdgeInsets.all(0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CustomNetWorkImage(
                  imageUrl: getYouTubeThumbnail(widget.videoModel.videoUrl),
                  width: 150.wp,
                  height: 120.hp,
                  boxFit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                  child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black26,
                ),
              )),
              const Positioned.fill(
                  child: Align(
                alignment: Alignment.center,
                child: CommonSvgWidget(
                  svgName: Assets.youtube,
                ),
              ))
            ],
          ),
          SizedBox(
            width: 10.hp,
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.videoModel.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style:
                    textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 5.hp,
              ),
              Text(
                DateFormatterUtils.convertAdIntoBs(widget.videoModel.createdAt),
                style:
                    textTheme.bodyLarge!.copyWith(color: CustomTheme.darkGrey),
              ),
              SizedBox(
                height: 10.hp,
              ),
              Text(
                widget.videoModel.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
