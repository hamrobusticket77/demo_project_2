import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/feature/home/ui/widget/video_home_card.dart';
import 'package:krishi_hub/feature/video/cubit/get_video_cubit.dart';
import 'package:krishi_hub/feature/video/resource/all_video_repository.dart';
import '../../../../common/common_error_widget.dart';
import '../../../../common/constant/locale_keys.dart';
import '../../../../common/cubit/data_state.dart';
import '../../../../common/navigation/navigation_service.dart';
import '../../../../common/widget/shimmer/shimmer_widget.dart';
import '../../../video/ui/widget/video_player_widget.dart';

class VideoWidget extends StatefulWidget {
  const VideoWidget({
    super.key,
  });

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

// String getYouTubeThumbnail(String videoId) {
//   return 'https://img.youtube.com/vi/$videoId/0.jpg';
// }

class _VideoWidgetState extends State<VideoWidget> {
  @override
  Widget build(BuildContext context) {
    final allVideo =
        RepositoryProvider.of<AllVideoRepository>(context).getVideos;

    return SliverToBoxAdapter(
      child: BlocBuilder<GetVideoCubit, CommonState>(
        buildWhen: (context, state) {
          if (state is CommonDummyLoading) {
            return false;
          }
          return true;
        },
        builder: (context, state) {
          if (state is CommonLoading) {
            return SizedBox(
              child: ListViewPlaceHolder(
                itemHeight: 100.hp,
                numberofItem: 1,
              ),
            );
          } else if (state is CommonError) {
            return CommonErrorWidget(
              hideImage: true,
              message: state.message,
            );
          } else if (state is CommonNoData) {
            return Center(child: Text((LocaleKeys.noDataFound.tr())));
          } else if (state is CommonDataFetchSuccess<String>) {
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.symmetric(vertical: 5.hp, horizontal: 8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                crossAxisSpacing: 0,
                mainAxisSpacing: 8.hp,
              ),
              itemCount: state.data.length > 3 ? 3 : state.data.length,
              itemBuilder: (context, index) {
                final data = allVideo[state.data[index]];
                if (data != null) {
                  return SizedBox(
                    width: 320.wp,
                    child: VideoCards(
                      margin: EdgeInsets.only(right: 15.wp),
                      onPressed: () {
                        NavigationService.push(
                            target: VideoPlayerWidget(
                          videoModel: data,
                        ));
                      },
                      date: data.title,
                      title: data.title,
                      imageUrl: (data.videoUrl.isNotEmpty) ? data.videoUrl : "",
                      //imageUrl: data.videoUrl,
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
