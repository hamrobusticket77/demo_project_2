import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/common_card_wapper.dart';
import 'package:krishi_hub/common/common_error_widget.dart';
import 'package:krishi_hub/common/common_nodata_widget.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/widget/app_bar/custom_app_bar.dart';
import 'package:krishi_hub/common/widget/shimmer/shimmer_widget.dart';
import 'package:krishi_hub/common/widget/text_tile_widget.dart';
import 'package:krishi_hub/feature/demand/cubit/get_applied_demand_cubit.dart';
import 'package:krishi_hub/feature/demand/resource/all_applied_demand_repository.dart';
import 'package:krishi_hub/feature/project/cubit/fiscal_year_cubit.dart';

class AppliedDemandListWidget extends StatefulWidget {
  const AppliedDemandListWidget({super.key});

  @override
  State<AppliedDemandListWidget> createState() =>
      _AppliedDemandListWidgetState();
}

class _AppliedDemandListWidgetState extends State<AppliedDemandListWidget> {
  @override
  void initState() {
    context.read<FiscalYearCubit>().getCurrentFiscalYear();
    super.initState();
  }

  bool _isLoadMoreActive = false;
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final allAppliedDemandList =
        RepositoryProvider.of<AllAppliedDemendRepository>(context)
            .getAppliedDemand;
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.subsidyList.tr(),
      ),
      body: BlocListener<GetAppliedDemandCubit, CommonState>(
        listener: (context, state) {
          if (state is CommonDataFetchSuccess) {
            _isLoadMoreActive = false;
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<GetAppliedDemandCubit, CommonState>(
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
                                  .read<GetAppliedDemandCubit>()
                                  .loadMoreAppliedDemand();
                            }
                          }
                          return true;
                        },
                        child: Column(
                            children: List.generate(state.data.length, (index) {
                          final data = allAppliedDemandList[state.data[index]];

                          if (data != null) {
                            return CommonCardWrapper(
                                child: Column(
                              children: [
                                TextTileWidget(
                                    title: LocaleKeys.subsidy.tr(),
                                    subTitle:
                                        data.demandQuantity?.subCategory.name ??
                                            ""),
                                TextTileWidget(
                                    title: LocaleKeys.appliedQuantity.tr(),
                                    subTitle:
                                        data.appliedQuantity?.toString() ?? ""),
                                TextTileWidget(
                                    title: LocaleKeys.grantedQuantity.tr(),
                                    subTitle:
                                        data.grantedQuantity?.toString() ?? ""),
                                TextTileWidget(
                                    title: LocaleKeys.grantDate.tr(),
                                    subTitle: data.grantDate?.toString() ?? "")
                              ],
                            ));
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
