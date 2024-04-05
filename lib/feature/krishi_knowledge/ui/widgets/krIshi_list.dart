import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/common_error_widget.dart';
import 'package:krishi_hub/common/common_nodata_widget.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/widget/app_bar/custom_app_bar.dart';
import 'package:krishi_hub/common/widget/shimmer/shimmer_widget.dart';
import 'package:krishi_hub/feature/krishi_knowledge/cubit/get_krishi_cubit.dart';
import 'package:krishi_hub/feature/krishi_knowledge/resources/all_krishi_repository.dart';

import 'krishi_card.dart';
import 'krishi_detail_widget.dart';

class KrishiListWidget extends StatefulWidget {
  const KrishiListWidget({super.key});

  @override
  State<KrishiListWidget> createState() => _KrishiListWidgetState();
}

class _KrishiListWidgetState extends State<KrishiListWidget> {
  @override
  void initState() {
    super.initState();
  }

  bool _isLoadMoreActive = false;
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final allKrishi =
        RepositoryProvider.of<AllKrishiRepository>(context).getkrishi;
    return BlocListener<GetKrishiCubit, CommonState>(
      listener: (context, state) {
        if (state is CommonDataFetchSuccess) {
          setState(() {
            _isLoadMoreActive = false;
          });
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: LocaleKeys.krishiknowledge.tr(),
        ),
        body: BlocBuilder<GetKrishiCubit, CommonState>(
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
                      scrollNotification.metrics.maxScrollExtent / 2) {}
                  return true;
                },
                child: Column(children: [
                  ...List.generate(state.data.length, (index) {
                    final data = allKrishi[state.data[index]];

                    if (data != null) {
                      return SizedBox(
                        child: KrishiCard(
                          onPressed: () {
                            NavigationService.push(
                                target: KrishiDetailWidget(
                              krishiModel: data,
                            ));
                          },
                          krishiModel: data,
                        ),
                      );
                    }
                    return const SizedBox();
                  }),
                  SizedBox(
                    height: MediaQuery.of(context).padding.bottom,
                  )
                ]),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
