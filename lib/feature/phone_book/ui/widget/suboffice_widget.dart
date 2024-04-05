import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/common_error_widget.dart';
import 'package:krishi_hub/common/common_nodata_widget.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';
import 'package:krishi_hub/common/utils/search_utils.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/widget/app_bar/custom_app_bar.dart';
import 'package:krishi_hub/common/widget/shimmer/shimmer_widget.dart';
import 'package:krishi_hub/common/widget/text_field/custom_search_field.dart';
import 'package:krishi_hub/feature/phone_book/cubit/get_office_cubit.dart';
import 'package:krishi_hub/feature/phone_book/cubit/get_phone_book_cubit.dart';
import 'package:krishi_hub/feature/phone_book/cubit/get_suboffice_cubit.dart';
import 'package:krishi_hub/feature/phone_book/resources/all_office_repository.dart';
import 'package:krishi_hub/feature/phone_book/resources/all_phone_book_repository.dart';
import 'package:krishi_hub/feature/phone_book/resources/all_sub_office_repository.dart';
import 'package:krishi_hub/feature/phone_book/ui/page/office_detail_page.dart';
import 'package:krishi_hub/feature/phone_book/ui/page/suboffice_detail_page.dart';
import 'package:krishi_hub/feature/phone_book/ui/widget/office_card.dart';
import 'package:krishi_hub/feature/phone_book/ui/widget/phone_book_card.dart';
import 'package:krishi_hub/feature/phone_book/ui/widget/suboffice_card.dart';

class SubOfficeWidget extends StatefulWidget {
  const SubOfficeWidget({Key? key}) : super(key: key);

  @override
  State<SubOfficeWidget> createState() => _SubOfficeWidgetState();
}

class _SubOfficeWidgetState extends State<SubOfficeWidget> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      // context.read<GetOfficeCubit>().loadMoreOfficeList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final officelist =
        RepositoryProvider.of<AllSubOfficeRepository>(context).getSuboffice;

    return Scaffold(
      appBar: const CustomAppBar(
        title: "Sub Office",
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: CustomTheme.symmetricHozPadding.wp,
                vertical: 15.hp,
              ),
              child: Row(
                children: [
                  // Expanded(
                  //   child: CustomSearchField(
                  //     controller: _searchController,
                  //     hintText: LocaleKeys.search.tr(),
                  //     onChanged: (value) {
                  //       SearchUtils().search(() {
                  //         context
                  //             .read<GetOfficeCubit>()
                  //             .getOffice(searchSlug: value.trim());
                  //       });
                  //     },
                  //     onFieldSubmitted: (value) {
                  //       FocusScope.of(context).unfocus();
                  //       SearchUtils().search(() {
                  //         context
                  //             .read<GetPhoneBookCubit>()
                  //             .getPhoneBook(searchSlug: value.trim());
                  //       });
                  //     },
                  //     onTapSuffixButton: () {
                  //       _searchController.clear();
                  //       SearchUtils().search(() {
                  //         context
                  //             .read<GetPhoneBookCubit>()
                  //             .getPhoneBook(searchSlug: '');
                  //       });
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
            SizedBox(height: 5.wp),
            BlocBuilder<GetSubOfficeCubit, CommonState>(
              buildWhen: (context, state) {
                if (state is CommonDummyLoading) {
                  return false;
                } else {
                  return true;
                }
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
                  return Column(
                    children: List.generate(state.data.length, (index) {
                      final data = officelist[state.data[index]];
                      if (data != null) {
                        return SizedBox(
                          child: SubOfficeCard(
                            subofficeModel: data,
                            onPressed: () {
                              NavigationService.push(
                                  target: SubOfficeDetail(
                                subofficeModel: data,
                              ));
                            },
                          ),
                        );
                      }
                      return const SizedBox();
                    }),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            ),
          ],
        ),
      ),
    );
  }
}
