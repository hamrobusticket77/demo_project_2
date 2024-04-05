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
import 'package:krishi_hub/common/widget/button/custom_icon_button.dart';
import 'package:krishi_hub/common/widget/dropdown/common_dropdown_type.dart';
import 'package:krishi_hub/common/widget/shimmer/shimmer_widget.dart';
import 'package:krishi_hub/common/widget/text_field/custom_search_field.dart';
import 'package:krishi_hub/feature/filter/ui/widget/product_filter_widget.dart';
import 'package:krishi_hub/feature/market_price/cubit/get_wholesaller_price_cubit.dart';
import 'package:krishi_hub/feature/market_price/resources/all_current_market_price_repository.dart';
import 'package:krishi_hub/feature/market_price/ui/widget/wholesaller_market_price_card.dart';

class WholeSalerPriceWidget extends StatefulWidget {
  const WholeSalerPriceWidget({Key? key}) : super(key: key);

  @override
  State<WholeSalerPriceWidget> createState() => _WholeSalerPriceWidgetState();
}

class _WholeSalerPriceWidgetState extends State<WholeSalerPriceWidget> {
  bool _isLoadMoreActive = false;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  CommonDropDownType? selectedType;
  CommonDropDownType? selectedCategory;
  CommonDropDownType? selectedProduct;

  @override
  Widget build(BuildContext context) {
    final currentmarket =
        RepositoryProvider.of<AllCurrentMarketPriceRepository>(context)
            .getCurrentMarketPrice;
    return Scaffold(
      key: scaffoldKey,
      // appBar: CustomAppBar(
      //   title: LocaleKeys.wholeSaler.tr(),
      // ),
      endDrawer: ProductFilterDrawer(
        selectedType: selectedType,
        selectedCategory: selectedCategory,
        selectedProduct: selectedProduct,
        hasProduct: true,
        hasMarket: false,
        onFilterUpdate: (market, type, category, product) {
          selectedType = type;
          selectedCategory = category;
          selectedProduct = product;
          setState(() {});
          context.read<GetWholeSallerPriceCubit>().getWholeSallerPrice(
                categeory: category?.id,
                type: type?.type,
                product: product?.id,
              );
        },
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: CustomTheme.symmetricHozPadding.wp,
          vertical: 15.hp,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomSearchField(
                    controller: _searchController,
                    hintText: LocaleKeys.search.tr(),
                    onChanged: (value) {
                      _handleSearch(value.trim());
                    },
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).unfocus();
                      _handleSearch(value.trim());
                    },
                    onTapSuffixButton: () {
                      _searchController.clear();
                      _handleSearch('');
                    },
                  ),
                ),
                const SizedBox(width: 10),
                CustomIconButton(
                  icon: Icons.tune,
                  onPressed: () {
                    scaffoldKey.currentState!.openEndDrawer();
                  },
                )
              ],
            ),
            const SizedBox(height: 10),
            BlocListener<GetWholeSallerPriceCubit, CommonState>(
              listener: (context, state) {
                if (state is CommonDataFetchSuccess) {
                  _isLoadMoreActive = false;
                }
              },
              child: NotificationListener<ScrollNotification>(
                onNotification: (scrollNotification) {
                  return true;
                },
                child: Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        BlocBuilder<GetWholeSallerPriceCubit, CommonState>(
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
                            } else if (state
                                is CommonDataFetchSuccess<String>) {
                              if (state.data.isEmpty) {
                                return const Center(
                                    child: CommonNoDataWidget());
                              } else {
                                return Column(
                                  children: state.data.map((key) {
                                    final data = currentmarket[key];
                                    if (data != null) {
                                      return SizedBox(
                                        child: WholeSalerPriceCard(
                                          marketPriceModels: data,
                                        ),
                                      );
                                    }
                                    return const SizedBox();
                                  }).toList(),
                                );
                              }
                            } else {
                              return const SizedBox();
                            }
                          },
                        ),
                        // SizedBox(
                        //   height: MediaQuery.of(context).padding.bottom,
                        // )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSearch(String value) {
    SearchUtils().search(() {
      context
          .read<GetWholeSallerPriceCubit>()
          .getWholeSallerPrice(searchSlug: value);
    });
  }
}
