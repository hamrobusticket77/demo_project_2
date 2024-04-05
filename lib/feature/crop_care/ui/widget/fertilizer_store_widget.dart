import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/common_error_widget.dart';
import 'package:krishi_hub/common/common_nodata_widget.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/utils/search_utils.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/widget/search/animate_search_Widget.dart';
import 'package:krishi_hub/common/widget/shimmer/shimmer_widget.dart';
import 'package:krishi_hub/feature/crop_care/cubit/get_fertilizer_store_cubit.dart';
import 'package:krishi_hub/feature/crop_care/resources/all_fertilizer_store_repository.dart';
import 'package:krishi_hub/feature/crop_care/ui/widget/fertilizer_store_card.dart';

class FertilizerStoreWidget extends StatefulWidget {
  const FertilizerStoreWidget({Key? key}) : super(key: key);

  @override
  State<FertilizerStoreWidget> createState() => _DoctorRecordWidgetState();
}

class _DoctorRecordWidgetState extends State<FertilizerStoreWidget> {
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
          .read<GetFertilizerStoreCubit>()
          .getFertilizerStore(searchSlug: searchSlug.trim());
    });
  }

  bool _isLoadMoreActive = false;

  @override
  Widget build(BuildContext context) {
    final fertilizerStore =
        RepositoryProvider.of<AllFertilizerStoreRepository>(context)
            .getFertilizerStore;

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
            BlocBuilder<GetFertilizerStoreCubit, CommonState>(
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
                              .read<GetFertilizerStoreCubit>()
                              .loadMoreFertilizerStore();
                        }
                      }
                      return true;
                    },
                    child: Column(
                      children: List.generate(state.data.length, (index) {
                        final data = fertilizerStore[state.data[index]];
                        if (data != null) {
                          return SizedBox(
                            child: FertilizerStoreCard(
                              fertilizerStoreModel: data,
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
