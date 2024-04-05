import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/feature/images/cubit/get_album_cubit.dart';
import 'package:krishi_hub/feature/images/resources/all_images_repository.dart';
import 'package:krishi_hub/feature/images/ui/pages/image_page.dart';
import '../../../../common/common_error_widget.dart';
import '../../../../common/common_nodata_widget.dart';
import '../../../../common/constant/locale_keys.dart';
import '../../../../common/cubit/data_state.dart';
import '../../../../common/navigation/navigation_service.dart';
import '../../../../common/widget/app_bar/custom_app_bar.dart';
import '../../../../common/widget/shimmer/shimmer_widget.dart';
import 'images_card.dart';
import 'image_widget.dart';

class AlbumWidget extends StatefulWidget {
  const AlbumWidget({super.key});

  @override
  State<AlbumWidget> createState() => _AlbumWidgetState();
}

class _AlbumWidgetState extends State<AlbumWidget> {
  bool _isLoadMoreActive = false;
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final allImages =
        RepositoryProvider.of<AllImagesRepository>(context).getImages;
    return BlocListener<GetAlbumCubit, CommonState>(
      listener: (context, state) {
        if (state is CommonDataFetchSuccess) {
          setState(() {
            _isLoadMoreActive = false;
          });
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: LocaleKeys.image.tr(),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<GetAlbumCubit, CommonState>(
                buildWhen: (context, state) {
                  if (state is CommonDummyLoading) {
                    return false;
                  }
                  return true;
                },
                builder: (context, state) {
                  if (state is CommonLoading) {
                    return ListViewPlaceHolder(
                      itemHeight: 100.hp,
                    );
                  } else if (state is CommonError) {
                    return CommonErrorWidget(
                      message: state.message,
                    );
                  } else if (state is CommonNoData) {
                    return const Center(child: CommonNoDataWidget());
                  } else if (state is CommonDataFetchSuccess<int>) {
                    return NotificationListener<ScrollNotification>(
                        onNotification: (scrollNotification) {
                          if (scrollNotification.metrics.pixels >
                              scrollNotification.metrics.maxScrollExtent / 2) {
                            if (!_isLoadMoreActive &&
                                _scrollController
                                        .position.userScrollDirection ==
                                    ScrollDirection.reverse) {
                              _isLoadMoreActive = true;
                              context.read<GetAlbumCubit>().loadMore();
                            }
                          }
                          return true;
                        },
                        child: Column(
                            children: List.generate(state.data.length, (index) {
                          final data = allImages[state.data[index]];

                          if (data != null) {
                            return SizedBox(
                              //   height: 140.hp,
                              child: AlbumCard(
                                onPressed: () {
                                  NavigationService.push(
                                      target: ImagePage(id: data.id));
                                },
                                model: data,
                              ),
                            );
                          }
                          return const SizedBox();
                        })));
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom,
              )
            ],
          ),
        ),
      ),
    );
  }
}
