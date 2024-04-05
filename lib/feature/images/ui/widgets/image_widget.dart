import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/common_error_widget.dart';
import 'package:krishi_hub/common/common_nodata_widget.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/image/custom_cache_network_image.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/widget/app_bar/custom_app_bar.dart';
import 'package:krishi_hub/common/widget/shimmer/shimmer_widget.dart';
import 'package:krishi_hub/common/widget/view_image_dialog.dart';
import 'package:krishi_hub/feature/images/cubit/get_image_cubit.dart';
import 'package:krishi_hub/feature/images/model/images_model.dart';

class ImageWidget extends StatelessWidget {
  // final data imagesModel;

  const ImageWidget({
    super.key,
    // required this.imagesModel,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // final height = MediaQuery.of(context).size.height;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.image.tr(),
      ),
      body: BlocConsumer<GetImagesCubit, CommonState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is CommonLoading) {
            return const Padding(
              padding: EdgeInsets.all(CustomTheme.symmetricHozPadding),
              child: GridViewPlaceHolder(
                itemInRow: 3,
                itemHeight: 120,
                itemBorderRadius: 0,
              ),
            );
          } else if (state is CommonError) {
            return Center(child: CommonErrorWidget(message: state.message));
          } else if (state is CommonNoData) {
            return const Center(child: CommonNoDataWidget());
          }
          if (state is CommonDataFetchSuccess<ImagesModel>) {
            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: CustomTheme.symmetricHozPadding.wp),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ...List.generate(state.data.length, (index) {
                      final data = state.data[index];
                      return Column(
                        children: [
                          SizedBox(height: 10.hp),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "${data.title} :",
                              style: textTheme.titleSmall!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Theme.of(context).primaryColor),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            padding: EdgeInsets.symmetric(
                                vertical: 5.hp, horizontal: 0),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 1,
                              crossAxisSpacing: 0,
                              mainAxisSpacing: 8.hp,
                            ),
                            itemCount: data.mediaGroup.medias.length,
                            itemBuilder: (context, index) {
                              final media = data.mediaGroup.medias[index];
                              return InkWell(
                                  onTap: () {
                                    viewImageDialog(context, media.path);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: CustomTheme.white,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: CustomCachedNetworkImage(
                                        fit: BoxFit.cover,
                                        url: media.path,
                                      ),
                                    ),
                                  ));
                            },
                          ),
                        ],
                      );
                    })
                  ],
                ),
              ),
            );
          }

          return SizedBox();
        },
      ),
    );
  }
}
