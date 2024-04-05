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
import 'package:krishi_hub/common/widget/button/custom_icon_button.dart';
import 'package:krishi_hub/common/widget/dropdown/common_dropdown_type.dart';
import 'package:krishi_hub/common/widget/search/animate_search_Widget.dart';
import 'package:krishi_hub/common/widget/shimmer/shimmer_widget.dart';
import 'package:krishi_hub/feature/crop_care/cubit/get_doctor_record_cubit.dart';
import 'package:krishi_hub/feature/crop_care/resources/all_doctor_record_repository.dart';
import 'package:krishi_hub/feature/crop_care/ui/page/doctor_detail_page.dart';
import 'package:krishi_hub/feature/crop_care/ui/widget/doctor_record_card.dart';
import 'package:krishi_hub/feature/filter/ui/widget/product_filter_widget.dart';

class DoctorRecordWidget extends StatefulWidget {
  const DoctorRecordWidget({super.key});

  @override
  State<DoctorRecordWidget> createState() => _DoctorRecordWidgetState();
}

class _DoctorRecordWidgetState extends State<DoctorRecordWidget> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  CommonDropDownType? selectedType;
  CommonDropDownType? selectedCategory;
  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  _search(String searchSlug) {
    SearchUtils().search(() {
      context
          .read<GetDoctorRecordCubit>()
          .getDoctorRecord(searchSlug: searchSlug.trim());
    });
  }

  bool _isLoadMoreActive = false;

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final doctorRecord =
        RepositoryProvider.of<AllDoctorRecordRepository>(context).getDoctorList;

    return Scaffold(
      key: scaffoldKey,
      endDrawer: ProductFilterDrawer(
        hasAppBar: false,
        hasMarket: false,
        hasProduct: false,
        selectedType: selectedType,
        selectedCategory: selectedCategory,
        onFilterUpdate: (market, type, category, product) {
          selectedType = type;
          selectedCategory = category;
          setState(() {});
          context.read<GetDoctorRecordCubit>().getDoctorRecord(
                type: selectedType?.type,
                category: selectedCategory?.id,
              );
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: AnimatedSearchBar(
                    boxShadow: false,
                    hintText: LocaleKeys.search.tr(),
                    width: 0.7,
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
                ),
                CustomIconButton(
                  icon: Icons.tune,
                  onPressed: () {
                    scaffoldKey.currentState!.openEndDrawer();
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            BlocBuilder<GetDoctorRecordCubit, CommonState>(
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
                                  target: DoctorDetailPage(
                                    doctorRecordModel: data,
                                  ),
                                );
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
