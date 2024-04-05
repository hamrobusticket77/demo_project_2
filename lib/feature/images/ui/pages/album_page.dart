import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/images/cubit/get_album_cubit.dart';

import '../widgets/album_widget.dart';

class AlbumPage extends StatefulWidget {
  const AlbumPage({super.key});

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GetAlbumCubit(imagesRepository: RepositoryProvider.of(context))
            ..getAlbum(),
      child: const AlbumWidget(),
    );
  }
}
