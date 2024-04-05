import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/common_error_widget.dart';
import 'package:krishi_hub/common/common_nodata_widget.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/widget/app_bar/custom_app_bar.dart';
import 'package:krishi_hub/common/widget/shimmer/shimmer_widget.dart';
import 'package:krishi_hub/feature/demand/cubit/get_demand_list_cubit.dart';
import 'package:krishi_hub/feature/demand/resource/all_demand_repository.dart';
import 'package:krishi_hub/feature/demand/ui/page/demand_details_page.dart';
import 'package:krishi_hub/feature/demand/ui/widget/demand_card.dart';
import 'package:krishi_hub/feature/project/cubit/fiscal_year_cubit.dart';

class DemandListWidget extends StatefulWidget {
  const DemandListWidget({super.key});

  @override
  State<DemandListWidget> createState() => _DemandListWidgetState();
}

class _DemandListWidgetState extends State<DemandListWidget> {
  @override
  void initState() {
    context.read<FiscalYearCubit>().getCurrentFiscalYear();
    super.initState();
  }

  bool _isLoadMoreActive = false;
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final alldemandlist =
        RepositoryProvider.of<AllDemandListRepository>(context).getdemandlist;
    return BlocListener<GetDemandListCubit, CommonState>(
      listener: (context, state) {
        if (state is CommonDataFetchSuccess) {
          setState(() {
            _isLoadMoreActive = false;
          });
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: LocaleKeys.subsidyList.tr(),
          // : PreferredSize(
          //   preferredSize: Size.fromHeight(0.10),
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     children: [
          //       Row(
          //         children: [
          //           CustomRoundedButtom(
          //               title: LocaleKeys.appliedDemand.tr(),
          //               onPressed: () {})
          //         ],
          //       ),
          //     ],
          //   ),
          // )),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<GetDemandListCubit, CommonState>(
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
                                  .read<GetDemandListCubit>()
                                  .loadMoreDemandList();
                            }
                          }
                          return true;
                        },
                        child: Column(
                            children: List.generate(state.data.length, (index) {
                          final data = alldemandlist[state.data[index]];

                          if (data != null) {
                            return SizedBox(
                              child: DemandListCard(
                                onPressed: () {
                                  NavigationService.push(
                                      target: DemandDetailsPage(
                                    id: data.id,
                                  ));
                                },
                                demandlistModel: data,
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
            ],
          ),
        ),
      ),
    );
  }
}
