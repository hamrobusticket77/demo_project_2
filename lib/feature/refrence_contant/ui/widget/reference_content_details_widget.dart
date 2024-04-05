import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/common_card_wapper.dart';
import 'package:krishi_hub/common/common_error_widget.dart';
import 'package:krishi_hub/common/common_nodata_widget.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/image/custom_cache_network_image.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/widget/app_bar/custom_app_bar.dart';
import 'package:krishi_hub/common/widget/shimmer/shimmer_widget.dart';
import 'package:krishi_hub/feature/auth/utils/fullname_utils.dart';
import 'package:krishi_hub/feature/refrence_contant/cubit/get_reference_cubit_id.dart';
import 'package:krishi_hub/feature/refrence_contant/model/reference_content_model.dart';

class ReferenceContentDetailsWidget extends StatelessWidget {
  final ReferenceContentModel data;

  const ReferenceContentDetailsWidget({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocListener<GetReferenceCubitId, CommonState>(
      listener: (context, state) {},
      child: Scaffold(
        appBar: CustomAppBar(
          title: LocaleKeys.details.tr(),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: BlocBuilder<GetReferenceCubitId, CommonState>(
              builder: (context, state) {
                if (state is CommonLoading) {
                  return ListViewPlaceHolder(
                    itemHeight: 100.hp,
                    // numberofItem: 200,
                  );
                } else if (state is CommonError) {
                  return CommonErrorWidget(
                    message: state.message,
                  );
                } else if (state is CommonNoData) {
                  return const Center(child: CommonNoDataWidget());
                } else if (state is CommonStateSuccess<ReferenceContentModel>) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: CustomTheme.symmetricHozPadding.wp),
                      child: CommonCardWrapper(
                        hasShadow: false,
                        backgroundColor: CustomTheme.white,
                        margin: EdgeInsets.all(5.hp),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: CustomCachedNetworkImage(
                                    url: state.data.details.profileImage.first
                                            .path.isNotEmpty
                                        ? state.data.details.profileImage.first
                                            .path
                                        : "",
                                    fit: BoxFit.cover,
                                    height: 100.wp,
                                    width: 100.wp,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.hp,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                    "\" ${data.title} \"",
                                    // textScaleFactor:
                                    //     SizeUtils.textScaleFactor,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                    textAlign: TextAlign.center,
                                    style: textTheme.titleSmall!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.hp,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: HtmlWidget(
                                    "${state.data.description} ",

                                    // textScaleFactor:
                                    //     SizeUtils.textScaleFactor,
                                    // overflow: TextOverflow.ellipsis,
                                    // maxLines: 3,
                                    // textAlign: TextAlign.center,
                                    // style: textTheme.titleSmall!.copyWith(
                                    //   fontWeight: FontWeight.bold,
                                    // ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.hp,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Text(
                                    FullNameUtils.getFullName(
                                      firstName: data.details.firstName,
                                      lastName: data.details.lastName,
                                      middleName: data.details.middleName,
                                    ),
                                    // textScaleFactor:
                                    //     SizeUtils.textScaleFactor,
                                    textAlign: TextAlign.end,

                                    style: textTheme.titleSmall!.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).primaryColor),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.hp,
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.end,
                            //   children: [
                            //     Expanded(
                            //       child: Text(
                            //         data.details.,
                            //         // textScaleFactor:
                            //         //     SizeUtils.textScaleFactor,
                            //         textAlign: TextAlign.end,
                            //         overflow: TextOverflow.ellipsis,
                            //         style: textTheme.titleSmall!.copyWith(
                            //             fontWeight: FontWeight.w400,
                            //             color: CustomTheme.darkGrey),
                            //         maxLines: 1,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
