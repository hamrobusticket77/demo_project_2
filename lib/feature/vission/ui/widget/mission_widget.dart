import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/feature/vission/cubit/get_mission_cubit.dart';
import 'package:krishi_hub/feature/vission/resource/all_mission_repository.dart';
import '../../../../common/common_error_widget.dart';
import '../../../../common/common_nodata_widget.dart';
import '../../../../common/constant/locale_keys.dart';
import '../../../../common/cubit/data_state.dart';
import '../../../../common/widget/app_bar/custom_app_bar.dart';
import '../../../../common/widget/shimmer/shimmer_widget.dart';
import 'mission_card.dart';

class MissionWidget extends StatefulWidget {
  const MissionWidget({super.key});

  @override
  State<MissionWidget> createState() => _EmployeeWidgetState();
}

class _EmployeeWidgetState extends State<MissionWidget> {
  @override
  void initState() {
    context.read<GetMissionCubit>().getMission();
    super.initState();
  }

  // bool _isLoadMoreActive = false;
  // final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final allemployee =
        RepositoryProvider.of<AllMissionRepository>(context).getmission;
    return BlocListener<GetMissionCubit, CommonState>(
      listener: (context, state) {
        if (state is CommonDataFetchSuccess) {
          // setState(() {
          //   _isLoadMoreActive = false;
          // }
          // );
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: LocaleKeys.ourmission.tr(),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<GetMissionCubit, CommonState>(
                buildWhen: (context, state) {
                  if (state is CommonDummyLoading) {
                    return false;
                  }
                  return true;
                },
                builder: (context, state) {
                  if (state is CommonLoading) {
                    return ListViewPlaceHolder(
                      numberofItem: 1,
                      itemHeight: MediaQuery.of(context).size.height * 0.9,
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
                            scrollNotification.metrics.maxScrollExtent / 2) {}
                        return true;
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: CustomTheme.symmetricHozPadding.wp,
                            vertical: CustomTheme.symmetricHozPadding,),
                        child: Column(
                          children: state.data.map((dataId) {
                            final data = allemployee[dataId];

                            if (data != null) {
                              return SizedBox(
                                child: MissionCard(
                                  onPressed: () {
                                    // NavigationService.push(
                                    //     target:ElectiveDetailWidget(
                                    //   electiveModel: data,
                                    // ));
                                  },
                                  missionModel: data,
                                ),
                              );
                            }
                            return const SizedBox();
                          }).toList(),
                        ),
                      ),
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
      ),
    );
  }
}
