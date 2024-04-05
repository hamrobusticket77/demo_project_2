import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/downloads/cubit/get_download_cubit.dart';
import 'package:krishi_hub/feature/downloads/ui/widget/download_widget.dart';

class DownloadPages extends StatelessWidget {
  const DownloadPages({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DownloadCubit(downloadRepository: RepositoryProvider.of(context))
            ..getDownloadPdf(),
      child: const DownloadWidget(),
    );
  }
}
