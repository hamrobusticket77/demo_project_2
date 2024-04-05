import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/video/cubit/get_video_cubit.dart';

import '../widget/video_widget.dart';

class VideoPlayer extends StatelessWidget {
  const VideoPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GetVideoCubit(videoRepository: RepositoryProvider.of(context))
            ..getVideos(),
      child: const VideoListWidget(),
    );
  }
}
