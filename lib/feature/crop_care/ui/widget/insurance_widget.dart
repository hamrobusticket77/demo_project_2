import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/common_error_widget.dart';
import 'package:krishi_hub/common/common_nodata_widget.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';
import 'package:krishi_hub/common/utils/search_utils.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/widget/search/animate_search_Widget.dart';
import 'package:krishi_hub/common/widget/shimmer/shimmer_widget.dart';
import 'package:krishi_hub/feature/crop_care/cubit/get_doctor_record_cubit.dart';
import 'package:krishi_hub/feature/crop_care/cubit/get_insurance_directory_cubit.dart';
import 'package:krishi_hub/feature/crop_care/resources/all_doctor_record_repository.dart';
import 'package:krishi_hub/feature/crop_care/ui/page/insurance_detail_page.dart';
import 'package:krishi_hub/feature/crop_care/ui/widget/doctor_record_card.dart';

class InsuranceWidget extends StatefulWidget {
  const InsuranceWidget({Key? key}) : super(key: key);

  @override
  State<InsuranceWidget> createState() => _DoctorRecordWidgetState();
}

class _DoctorRecordWidgetState extends State<InsuranceWidget> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  _search(String searchSlug) {
    SearchUtils().search(() {
      context
          .read<GetInsuranceDirectoryCubit>()
          .getInsuranceDirectory(searchSlug: searchSlug.trim());
    });
  }

  bool _isLoadMoreActive = false;

  @override
  Widget build(BuildContext context) {
    final doctorRecord =
        RepositoryProvider.of<AllDoctorRecordRepository>(context).getDoctorList;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AnimatedSearchBar(
               width: 0.85,
              boxShadow: false,
              hintText: LocaleKeys.search.tr(),
              onChanged: (value) {
                _search(value);
              },
              onTapSuffixButton: () {
                _searchController.clear();
                _search("");
              },
              controller: _searchController,
              onSuffixTap: () {
                _searchController.clear();
                _search("");
              },
              rtl: true,
              onSubmitted: (value) {
                FocusScope.of(context).unfocus();
                _search(value);
              },
              searchBarOpen: (a) {
                a = 0;
              },
            ),
            // Container(
            //   padding: EdgeInsets.only(
            //     left: CustomTheme.symmetricHozPadding.wp,
            //     right: CustomTheme.symmetricHozPadding.wp,
            //     top: 15.hp,
            //   ),
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: CustomSearchField(
            //           controller: _searchController,
            //           hintText: LocaleKeys.search.tr(),
            //           onChanged: (value) {
            //             _search(value);
            //           },
            //           onFieldSubmitted: (value) {
            //             FocusScope.of(context).unfocus();
            //             _search(value);
            //           },
            //           onTapSuffixButton: () {
            //             _searchController.clear();
            //             _search("");
            //           },
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            BlocBuilder<GetInsuranceDirectoryCubit, CommonState>(
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
                          _isLoadMoreActive = false;
                          context
                              .read<GetDoctorRecordCubit>()
                              .loadMoreDoctorRecord();
                        }
                      }
                      return true;
                    },
                    child: Column(
                      children: List.generate(state.data.length, (index) {
                        final data = doctorRecord[state.data[index]];
                        if (data != null) {
                          return SizedBox(
                            child: DoctorRecordCard(
                              doctorRecordModel: data,
                              onpress: () {
                                NavigationService.push(
                                    target: InsurnceDetailPage(
                                  doctorRecordModel: data,
                                ));
                              },
                            ),
                          );
                        }
                        return const SizedBox();
                      }),
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
    );
  }
}
