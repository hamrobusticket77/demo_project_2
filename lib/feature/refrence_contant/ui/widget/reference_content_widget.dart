import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/utils/search_utils.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/widget/app_bar/custom_app_bar.dart';
import 'package:krishi_hub/common/widget/shimmer/shimmer_widget.dart';
import 'package:krishi_hub/common/widget/text_field/custom_search_field.dart';
import 'package:krishi_hub/feature/news/resource/all_reference_content_repository.dart';
import 'package:krishi_hub/feature/refrence_contant/cubit/reference_content_cubit.dart';
import 'package:krishi_hub/feature/refrence_contant/model/reference_content_model.dart';
import 'package:krishi_hub/feature/refrence_contant/ui/widget/home_reference_content_card.dart';

class ReferenceContentWidget extends StatefulWidget {
  const ReferenceContentWidget({Key? key}) : super(key: key);

  @override
  State<ReferenceContentWidget> createState() => _ReferenceContentWidgetState();
}

class _ReferenceContentWidgetState extends State<ReferenceContentWidget> {
  bool _isLoadMoreActive = false;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  _search(String searchSlug) {
    SearchUtils().search(() {
      context
          .read<ReferenceContentCubit>()
          .getReferenceContent(searchSlug: searchSlug.trim());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReferenceContentCubit, CommonState>(
      listener: (context, state) {
        if (state is CommonDataFetchSuccess) {
          setState(() {
            _isLoadMoreActive = false;
          });
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(title: LocaleKeys.referenceMaterial.tr()),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                left: CustomTheme.symmetricHozPadding.wp,
                right: CustomTheme.symmetricHozPadding.wp,
                top: 15.hp,
              ),
              child: CustomSearchField(
                controller: _searchController,
                hintText: LocaleKeys.search.tr(),
                onChanged: (value) {
                  _search(value);
                },
                onFieldSubmitted: (value) {
                  FocusScope.of(context).unfocus();
                  _search(value);
                },
                onTapSuffixButton: () {
                  _searchController.clear();
                  _search("");
                },
              ),
            ),
            Expanded(
              child: BlocBuilder<ReferenceContentCubit, CommonState>(
                builder: (context, state) {
                  if (state is CommonError) {
                    return Center(child: Text(state.message));
                  } else if (state is CommonLoading) {
                    return const ListViewPlaceHolder(
                      itemHeight: 150,
                    );
                  } else if (state is CommonNoData) {
                    return Center(
                      child: Text(
                        LocaleKeys.noDataFound.tr(),
                      ),
                    );
                  } else if (state
                      is CommonDataFetchSuccess<ReferenceContentModel>) {
                    return NotificationListener<ScrollNotification>(
                      onNotification: (scrollNotification) {
                        if (scrollNotification.metrics.pixels >
                            scrollNotification.metrics.maxScrollExtent / 2) {
                          if (!_isLoadMoreActive &&
                              _scrollController.position.userScrollDirection ==
                                  ScrollDirection.reverse) {
                            _isLoadMoreActive = true;
                            context
                                .read<ReferenceContentCubit>()
                                .loadMoreReferenceContent(
                                    searchSlug: _searchController.text);
                          }
                        }
                        return true;
                      },
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: state.data.length,
                        itemBuilder: (context, index) {
                          final data = state.data[index];
                          return SizedBox(
                            height: 140.hp,
                            child: HomeReferenceContentCard(data: data),
                          );
                        },
                      ),
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
