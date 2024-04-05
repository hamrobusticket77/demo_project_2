import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/common_error_widget.dart';
import 'package:krishi_hub/common/common_nodata_widget.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/widget/app_bar/custom_app_bar.dart';
import 'package:krishi_hub/common/widget/button/custom_icon_button.dart';
import 'package:krishi_hub/common/widget/shimmer/shimmer_widget.dart';
import 'package:krishi_hub/feature/agriculture_plan/cubit/get_agriculture_plan_cubit.dart';
import 'package:krishi_hub/feature/agriculture_plan/resources/all_agriculture_plan_repository.dart';
import 'package:krishi_hub/feature/agriculture_plan/ui/pages/agriculture_plan_form_page.dart';
import 'package:krishi_hub/feature/agriculture_plan/ui/pages/plan_details_page.dart';
import 'package:krishi_hub/feature/agriculture_plan/ui/widget/agriculute_card.dart';

class AgricultureplanListWidget extends StatefulWidget {
  const AgricultureplanListWidget({super.key});

  @override
  State<AgricultureplanListWidget> createState() =>
      _AgricultureplanListWidgetState();
}

class _AgricultureplanListWidgetState extends State<AgricultureplanListWidget> {
  bool _isLoadMoreActive = false;
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final allagriculture =
        RepositoryProvider.of<AllAgricultureRepository>(context)
            .getAgriculturePlan;
    return BlocListener<GetAgricultureCubit, CommonState>(
      listener: (context, state) {
        if (state is CommonDataFetchSuccess) {
          setState(() {
            _isLoadMoreActive = false;
          });
        }
      },
      child: Scaffold(
        floatingActionButton: CustomIconButton(
          verticalPadding: 9,
          horizontalPadding: 9,
          icon: Icons.add,
          backgroundColor: Theme.of(context).primaryColor,
          iconColor: CustomTheme.white,
          iconSize: 25,
          onPressed: () {
            NavigationService.push(target: const AgriculturePlanFormPage())
                .then((value) {
              if (value != null && value) {
                context.read<GetAgricultureCubit>().getAgriculturePlan();
              }
            });
          },
        ),
        appBar: CustomAppBar(
          title: LocaleKeys.programprojectapplication.tr(),
          actions: const [
            // CustomIconButton(
            //   icon: Icons.add_circle,
            //   iconColor: CustomTheme.white,
            //   backgroundColor: Colors.transparent,
            //   onPressed: () {
            //     NavigationService.push(target: const AgriculturePlanFormPage())
            //         .then((value) {
            //       if (value) {
            //         context.read<GetAgricultureCubit>().getAgriculturePlan();
            //       }
            //     });
            //   },
            // )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<GetAgricultureCubit, CommonState>(
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
                    return NotificationListener<ScrollNotification>(
                        onNotification: (scrollNotification) {
                          if (scrollNotification.metrics.pixels >
                              scrollNotification.metrics.maxScrollExtent / 2) {
                            if (!_isLoadMoreActive &&
                                _scrollController
                                        .position.userScrollDirection ==
                                    ScrollDirection.reverse) {
                              _isLoadMoreActive = true;
                              context
                                  .read<GetAgricultureCubit>()
                                  .loadMoreAgriculturePlan();
                            }
                          }
                          return true;
                        },
                        child: Column(
                            children: List.generate(state.data.length, (index) {
                          final data = allagriculture[state.data[index]];

                          if (data != null) {
                            return SizedBox(
                              // height: 140.hp,
                              child: AgricultureCard(
                                onPressed: () {
                                  NavigationService.push(
                                      target: PlanDetailsPage(
                                    agriculturePlanModel: data,
                                  ));
                                },
                                agriculturelistModel: data,
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
