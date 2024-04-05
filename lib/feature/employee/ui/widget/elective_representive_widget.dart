import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/feature/employee/cubit/get_elective_rep_cubit.dart';
import 'package:krishi_hub/feature/employee/cubit/get_employee_cubit.dart';
import 'package:krishi_hub/feature/employee/resource/all_electiverepresentive_repository.dart';
import 'package:krishi_hub/feature/employee/ui/widget/elective_card.dart';
import '../../../../common/common_error_widget.dart';
import '../../../../common/common_nodata_widget.dart';
import '../../../../common/cubit/data_state.dart';
import '../../../../common/widget/shimmer/shimmer_widget.dart';

class ElectiveRepresentivewidget extends StatefulWidget {
  const ElectiveRepresentivewidget({super.key});

  @override
  State<ElectiveRepresentivewidget> createState() => _EmployeeWidgetState();
}

class _EmployeeWidgetState extends State<ElectiveRepresentivewidget> {
  @override
  void initState() {
    context.read<GetElectiveCubit>().getElectiveRepresentive();
    super.initState();
  }

  bool _isLoadMoreActive = false;
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final allemployee =
        RepositoryProvider.of<AllElectiveRepresentiveRepository>(context)
            .getelectiverepresentivelist;
    return BlocListener<GetElectiveCubit, CommonState>(
      listener: (context, state) {
        if (state is CommonDataFetchSuccess) {
          setState(() {
            _isLoadMoreActive = false;
          });
        }
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<GetElectiveCubit, CommonState>(
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
                              _scrollController.position.userScrollDirection ==
                                  ScrollDirection.reverse) {
                            _isLoadMoreActive = true;
                            context.read<GetEmployeeCubit>().loadMoreNews();
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
                            child: ElectiveCard(
                              electiveModel: data,
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
    );
  }
}
