import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/common_error_widget.dart';
import 'package:krishi_hub/common/common_nodata_widget.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/widget/app_bar/custom_app_bar.dart';
import 'package:krishi_hub/common/widget/button/custom_outline_button.dart';
import 'package:krishi_hub/common/widget/shimmer/shimmer_widget.dart';
import 'package:krishi_hub/feature/krishi_knowledge/cubit/get_krishi_cubit.dart';
import 'package:krishi_hub/feature/krishi_knowledge/resources/all_krishi_repository.dart';
import 'package:krishi_hub/feature/krishi_knowledge/ui/pages/disease_report_page.dart';
import 'package:krishi_hub/feature/krishi_knowledge/ui/widgets/disease_detail.dart';
import 'package:krishi_hub/feature/krishi_knowledge/ui/widgets/disease_list_view_card.dart';

class DiseaseWidget extends StatefulWidget {
  const DiseaseWidget({super.key});

  @override
  State<DiseaseWidget> createState() => _DiseaseWidgetState();
}

class _DiseaseWidgetState extends State<DiseaseWidget> {
  @override
  void initState() {
    super.initState();
  }

  bool _isLoadMoreActive = false;
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    // final textTheme = Theme.of(context).textTheme;

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
          title: LocaleKeys.diseaseTitle.tr(),
        ),
        bottomNavigationBar: Container(
          color: CustomTheme.lightGray,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(CustomTheme.symmetricHozPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomOutlineButton(
                      name: LocaleKeys.reportDisease.tr(),
                      onPressed: () {
                        NavigationService.push(
                            target: const DiseaseReportPage());
                      },
                      fontSize: 13,
                      verticalPadding: 5,
                      sufixIcon: const Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).padding.bottom,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            BlocBuilder<GetKrishiCubit, CommonState>(
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
                  return Expanded(
                    child: NotificationListener<ScrollNotification>(
                        onNotification: (scrollNotification) {
                          if (scrollNotification.metrics.pixels >
                              scrollNotification.metrics.maxScrollExtent / 2) {}
                          return true;
                        },
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          child: Column(
                              children:
                                  List.generate(state.data.length, (index) {
                            final data = allKrishi[state.data[index]];

                            if (data != null) {
                              return Column(
                                children: List.generate(
                                    data.agricultureType.length, (index) {
                                  final value = data.agricultureType[index];
                                  return DiseaseListViewCard(
                                    data: value,
                                    onPressed: () {
                                      NavigationService.push(
                                          target: DiseaseDetail(
                                        agricultureType: value,
                                      ));
                                    },
                                  );
                                }),
                              );
                            }
                            return const SizedBox();
                          })),
                        )),
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
    );
  }
}
