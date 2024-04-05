import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/common_error_widget.dart';
import 'package:krishi_hub/common/common_nodata_widget.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/image/custom_cache_network_image.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/utils/user_listener.dart';
import 'package:krishi_hub/common/widget/app_bar/custom_app_bar.dart';
import 'package:krishi_hub/common/widget/button/custom_rounded_button.dart';
import 'package:krishi_hub/common/widget/common_expandable_list_widget.dart';
import 'package:krishi_hub/common/widget/shimmer/shimmer_widget.dart';
import 'package:krishi_hub/common/widget/view_image_dialog.dart';
import 'package:krishi_hub/feature/auth/ui/page/login_page.dart';
import 'package:krishi_hub/feature/krishi_knowledge/cubit/get_agriculture_item_cubit.dart';
import 'package:krishi_hub/feature/krishi_knowledge/models/agriculture_name.dart';

class ViewAllDataWidget extends StatelessWidget {
  const ViewAllDataWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: const CustomAppBar(),
      body: SizedBox(
        child: UserListener(
          builder: (context, user) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: BlocBuilder<GetAgricultureItemCubit, CommonState>(
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
                  } else if (state is CommonStateSuccess<AgricultureName>) {
                    return SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: CustomTheme.symmetricHozPadding.wp),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(height: 10.hp),
                            Row(
                              children: [
                                Text(
                                  state.data.name.name,
                                  style: textTheme.headlineSmall!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ],
                            ),
                            // Row(
                            //   children: [
                            //     Container(
                            //       height: 2,
                            //       color: Theme.of(context).primaryColor,
                            //       width: double.tryParse(state
                            //               .data.name.name.length
                            //               .toString()) ??
                            //           10,
                            //     ),
                            //   ],
                            // ),
                            ...List.generate(
                                user == null
                                    ? state.data.details!.values.length <= 5
                                        ? state.data.details!.values.length
                                        : 5
                                    : state.data.details!.values.length,
                                (index) {
                              final value = state.data.details!.values;
                              return CommonExpandableListWidget(
                                margin: EdgeInsets.symmetric(vertical: 10.hp),
                                title: value[index].columnName,
                                index: index,
                                body: HtmlWidget(
                                  value[index].values,
                                  textStyle: textTheme.bodyLarge!
                                      .copyWith(fontSize: 14),
                                ),
                              );
                            }),
                            SizedBox(height: 10.hp),
                            if (state.data.disease.isNotEmpty && user != null)
                              Row(
                                children: [
                                  Text(
                                    LocaleKeys.diseaseTitle.tr(),
                                    style: textTheme.headlineSmall!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            if (state.data.disease.isNotEmpty && user != null)
                              ...List.generate(
                                state.data.disease.length,
                                (index) {
                                  final value = state.data.disease;
                                  return CommonExpandableListWidget(
                                      margin:
                                          EdgeInsets.symmetric(vertical: 10.hp),
                                      title: value[index].title,
                                      index: index,
                                      body: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          HtmlWidget(
                                            value[index].description,
                                            textStyle: textTheme.bodyLarge!
                                                .copyWith(fontSize: 14),
                                          ),
                                          SizedBox(height: 10.hp),
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                if (state.data.disease[index]
                                                        .media !=
                                                    null)
                                                  ...List.generate(
                                                      state
                                                          .data
                                                          .disease[index]
                                                          .media!
                                                          .medias
                                                          .length, (a) {
                                                    final path = state
                                                        .data
                                                        .disease[index]
                                                        .media!
                                                        .medias[a]
                                                        .path;
                                                    return InkWell(
                                                      onTap: () {
                                                        viewImageDialog(
                                                          context,
                                                          path,
                                                        );
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        0),
                                                            child:
                                                                CustomCachedNetworkImage(
                                                              url: path,
                                                              fit: BoxFit.cover,
                                                              height: 100.hp,
                                                              width: 80.wp,
                                                            )),
                                                      ),
                                                    );
                                                  }),
                                              ],
                                            ),
                                          )
                                        ],
                                      ));
                                },
                              ),
                            SizedBox(height: 10.hp),
                            if (user == null)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 0,
                                  vertical: 30,
                                ),
                                child: CustomRoundedButton(
                                    title:
                                        LocaleKeys.logintoacessfullcontent.tr(),
                                    verticalPadding: 10,
                                    outlineColor:
                                        Theme.of(context).primaryColor,
                                    color: CustomTheme.white,
                                    elevation: 0,
                                    icon: Icons.login_rounded,
                                    iconColor: Theme.of(context).primaryColor,
                                    textColor: Theme.of(context).primaryColor,
                                    onPressed: () {
                                      NavigationService.push(
                                          target: const LoginPage(
                                        loginFromOtherPage: true,
                                      ));
                                    }),
                              ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
