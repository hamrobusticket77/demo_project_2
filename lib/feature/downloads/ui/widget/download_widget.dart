import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/feature/downloads/cubit/get_download_cubit.dart';
import 'package:krishi_hub/feature/downloads/resources/all_download_repository.dart';
import 'package:krishi_hub/feature/employee/cubit/get_employee_cubit.dart';
import '../../../../common/common_error_widget.dart';
import '../../../../common/common_nodata_widget.dart';
import '../../../../common/constant/locale_keys.dart';
import '../../../../common/cubit/data_state.dart';
import '../../../../common/widget/app_bar/custom_app_bar.dart';
import '../../../../common/widget/shimmer/shimmer_widget.dart';
import 'download_card.dart';

class DownloadWidget extends StatefulWidget {
  const DownloadWidget({super.key});

  @override
  State<DownloadWidget> createState() => _EmployeeWidgetState();
}

class _EmployeeWidgetState extends State<DownloadWidget> {
  @override
  void initState() {
    context.read<GetEmployeeCubit>().getEmployee();
    super.initState();
  }

  bool _isLoadMoreActive = false;
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final allemployee = RepositoryProvider.of<AllDownloadRepository>(context)
        .getdwonloadpdflist;
    return BlocListener<DownloadCubit, CommonState>(
      listener: (context, state) {
        if (state is CommonDataFetchSuccess) {
          setState(() {
            _isLoadMoreActive = false;
          });
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: LocaleKeys.downloads.tr(),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<DownloadCubit, CommonState>(
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
                              context.read<DownloadCubit>().loadMoreNews();
                            }
                          }
                          return true;
                        },
                        child: Column(
                            children: List.generate(state.data.length, (index) {
                          final data = allemployee[state.data[index]];

                          if (data != null) {
                            return SizedBox(
                              // height: 140.hp,
                              child: DownloadCard(
                                onPressed: () {
                                  // NavigationService.push(
                                  //     target: EmployeeDetailsWidget(
                                  //   employeeModel: data,
                                  // ));
                                },
                                downloadsModel: data,
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
