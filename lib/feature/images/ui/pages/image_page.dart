import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/images/cubit/get_image_cubit.dart';
import 'package:krishi_hub/feature/images/resources/images_repository.dart';
import 'package:krishi_hub/feature/images/ui/widgets/image_widget.dart';

class ImagePage extends StatelessWidget {
  final int id;
  const ImagePage({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetImagesCubit(
          imagesRepository: RepositoryProvider.of<ImagesRepository>(context))
        ..getImage(id),
      child: const ImageWidget(),
    );
  }
}
