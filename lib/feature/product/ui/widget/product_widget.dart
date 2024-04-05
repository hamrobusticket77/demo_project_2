import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/common_error_widget.dart';
import 'package:krishi_hub/common/common_nodata_widget.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/utils/search_utils.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/widget/app_bar/custom_app_bar.dart';
import 'package:krishi_hub/common/widget/shimmer/shimmer_widget.dart';
import 'package:krishi_hub/common/widget/text_field/custom_search_field.dart';
import 'package:krishi_hub/feature/product/cubit/product_cubit.dart';
import 'package:krishi_hub/feature/product/resource/all_product_repository.dart';
import 'package:krishi_hub/feature/product/ui/widget/product_card.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({super.key});

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  final TextEditingController _searchController = TextEditingController();

  final ScrollController _scrollController = ScrollController();

  _search(String searchSlug) {
    SearchUtils().search(() {
      context.read<ProductCubit>().getProduct(searchSlug: searchSlug.trim());
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final allProducts =
        RepositoryProvider.of<AllProductRepository>(context).getProducts;
    return Scaffold(
      backgroundColor: CustomTheme.lighterGrey,
      appBar: CustomAppBar(
        title: LocaleKeys.productTitle.tr(),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              left: CustomTheme.symmetricHozPadding.wp,
              right: CustomTheme.symmetricHozPadding.wp,
              top: 15.hp,
            ),
            child: Row(
              children: [
                Expanded(
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
                // SizedBox(
                //   width: 5.wp,
                // ),
                // CustomIconButton(
                //   icon: Icons.add,
                //   borderRadius: 8,
                //   iconColor: CustomTheme.white,
                //   backgroundColor: CustomTheme.primarymaterialcolor.shade300,
                //   onPressed: () {
                //     Navigator.pop(context);
                //   },
                // )
              ],
            ),
          ),
          SizedBox(height: 10.hp),
          Expanded(
            child: BlocBuilder<ProductCubit, CommonState>(
              buildWhen: (context, state) {
                if (state is CommonDummyLoading) {
                  return false;
                }
                return true;
              },
              builder: (context, state) {
                if (state is CommonLoading) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: CustomTheme.symmetricHozPadding.wp),
                    child: GridViewPlaceHolder(
                      itemHeight: 170.hp,
                    ),
                  );
                } else if (state is CommonError) {
                  return CommonErrorWidget(
                    message: state.message,
                  );
                } else if (state is CommonNoData) {
                  return const Center(child: CommonNoDataWidget());
                } else if (state is CommonDataFetchSuccess<String>) {
                  return SingleChildScrollView(
                    controller: _scrollController,
                    child: GridView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      padding: EdgeInsets.symmetric(
                          vertical: 10.hp, horizontal: 15.hp),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 11 / 12,
                        crossAxisSpacing: 15.wp,
                        mainAxisSpacing: 15.hp,
                      ),
                      children: List.generate(state.data.length, (index) {
                        final data = allProducts[state.data[index]];

                        if (data != null) {
                          return ProductCard(model: data);
                        } else {
                          return const SizedBox();
                        }
                      }),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).padding.bottom,
          )
        ],
      ),
    );
  }
}
