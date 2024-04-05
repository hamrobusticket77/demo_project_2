import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/common_error_widget.dart';
import 'package:krishi_hub/common/common_nodata_widget.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/image/custom_network_image.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/widget/app_bar/custom_app_bar.dart';
import 'package:krishi_hub/common/widget/shimmer/shimmer_widget.dart';
import 'package:krishi_hub/common/widget/view_image_dialog.dart';
import 'package:krishi_hub/feature/krishi_knowledge/cubit/get_disease_report_cubit.dart';
import 'package:krishi_hub/feature/krishi_knowledge/resources/all_disease_report_repository.dart';

class DiseaseReportViewWidget extends StatefulWidget {
  const DiseaseReportViewWidget({super.key});

  @override
  State<DiseaseReportViewWidget> createState() => _EmployeeWidgetState();
}

class _EmployeeWidgetState extends State<DiseaseReportViewWidget> {
  @override
  bool _isLoadMoreActive = false;
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final allDiseaseReport =
        RepositoryProvider.of<AllDiseaseReportRepository>(context)
            .getDiseaseReportList;

    return BlocListener<GetDiseaseReportCubit, CommonState>(
      listener: (context, state) {
        if (state is CommonDataFetchSuccess) {
          _isLoadMoreActive = false;
        }
      },
      child: Scaffold(
          appBar: CustomAppBar(
            title: LocaleKeys.diseaseReportList.tr(),
          ),
          body: NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) {
              if (scrollNotification.metrics.pixels >
                  scrollNotification.metrics.maxScrollExtent / 2) {
                if (!_isLoadMoreActive &&
                    _scrollController.position.userScrollDirection ==
                        ScrollDirection.reverse) {
                  _isLoadMoreActive = true;
                  context.read<GetDiseaseReportCubit>().loadMoreDiseaseReport();
                }
              }
              return true;
            },
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  BlocBuilder<GetDiseaseReportCubit, CommonState>(
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
                      } else if (state is CommonDataFetchSuccess<String>) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: CustomTheme.symmetricHozPadding.wp),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children:
                                  List.generate(state.data.length, (index) {
                                final data =
                                    allDiseaseReport[state.data[index]];

                                if (data != null) {
                                  return SizedBox(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      SizedBox(height: 15.hp),
                                      Text(
                                        data.name.name,
                                        style: textTheme.headlineMedium!
                                            .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: CustomTheme.darkGrey),
                                      ),
                                      // const Divider(),
                                      SizedBox(height: 15.hp),
                                      Text(
                                        data.title,
                                        style: textTheme.titleLarge!.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: CustomTheme
                                                .primarymaterialcolor.shade900),
                                      ),
                                      SizedBox(height: 10.hp),
                                      HtmlWidget(
                                        data.description,
                                        textStyle: textTheme.bodyLarge!
                                            .copyWith(
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                                color: CustomTheme.darkGrey),
                                      ),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                ...List.generate(
                                                  data.media.length,
                                                  (a) {
                                                    final path =
                                                        data.media[a].path;

                                                    return Row(
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            viewImageDialog(
                                                              context,
                                                              path,
                                                            );
                                                          },
                                                          child:
                                                              CustomNetWorkImage(
                                                            imageUrl: path,
                                                            boxFit:
                                                                BoxFit.cover,
                                                            height: 100.hp,
                                                            width: 100.wp,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10.wp,
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 20.hp),
                                      const Divider(),
                                    ],
                                  ));
                                }
                                return const SizedBox();
                              })),
                        );
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
          )),
    );
  }
}
