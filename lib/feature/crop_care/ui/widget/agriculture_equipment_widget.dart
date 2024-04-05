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
import 'package:krishi_hub/feature/crop_care/cubit/get_agriculture_equipment_cubit.dart';
import 'package:krishi_hub/feature/crop_care/resources/all_doctor_record_repository.dart';
import 'package:krishi_hub/feature/crop_care/ui/page/agriculture_equipment_detail_page.dart';
import 'package:krishi_hub/feature/crop_care/ui/widget/doctor_record_card.dart';

class AgricultureEquipmentWidget extends StatefulWidget {
  const AgricultureEquipmentWidget({Key? key}) : super(key: key);

  @override
  State<AgricultureEquipmentWidget> createState() =>
      _AgricultureEquipmentWidgetState();
}

class _AgricultureEquipmentWidgetState
    extends State<AgricultureEquipmentWidget> {
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
          .read<GetAgricultureEquipmentCubit>()
          .getAgricultureEquipment(searchSlug: searchSlug.trim());
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
            BlocBuilder<GetAgricultureEquipmentCubit, CommonState>(
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
                              .read<GetAgricultureEquipmentCubit>()
                              .loadMoreAgricultureEquipment();
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
                                  target: AgricultureEquipmentDetailPage(
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
