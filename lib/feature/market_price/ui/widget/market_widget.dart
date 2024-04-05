import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/common_error_widget.dart';
import 'package:krishi_hub/common/common_nodata_widget.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/utils/search_utils.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/widget/app_bar/custom_app_bar.dart';
import 'package:krishi_hub/common/widget/button/custom_icon_button.dart';
import 'package:krishi_hub/common/widget/dropdown/common_dropdown_type.dart';
import 'package:krishi_hub/common/widget/shimmer/shimmer_widget.dart';
import 'package:krishi_hub/common/widget/text_field/custom_search_field.dart';
import 'package:krishi_hub/feature/filter/cubit/market_list_cubit.dart';
import 'package:krishi_hub/feature/market_price/cubit/market_price_cubit.dart';
import 'package:krishi_hub/feature/market_price/resources/all_market_price_repository.dart';
import 'package:krishi_hub/feature/market_price/ui/widget/market_item.dart';
import 'package:krishi_hub/feature/filter/ui/widget/product_filter_widget.dart';

class MarketWidget extends StatefulWidget {
  const MarketWidget({super.key});

  @override
  State<MarketWidget> createState() => _MarketWidgetState();
}

class _MarketWidgetState extends State<MarketWidget> {
  bool _isLoadMoreActive = false;

  final ScrollController _scrollController = ScrollController();

  TextEditingController searchController = TextEditingController();

  _search(String searchSlug) {
    SearchUtils().search(() {
      context
          .read<MarketPriceCubit>()
          .getMarketPrice(searchSlug: searchSlug.trim());
    });
  }

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    context.read<MarketListCubit>().getMarketList();
    super.initState();
  }

  CommonDropDownType? selectedMarket;
  CommonDropDownType? selectedType;
  CommonDropDownType? selectedCategory;

  @override
  Widget build(BuildContext context) {
    final marketPriceList =
        RepositoryProvider.of<AllMarketPriceRepository>(context);
    return Scaffold(
      key: scaffoldKey,
      appBar: CustomAppBar(title: LocaleKeys.marketPrice.tr()),
      endDrawer: ProductFilterDrawer(
        selectedMarket: selectedMarket,
        selectedType: selectedType,
        hasProduct: false,
        selectedCategory: selectedCategory,
        onFilterUpdate: (market, type, category, product) {
          selectedMarket = market;
          selectedType = type;
          selectedCategory = category;

          setState(() {});
          context.read<MarketPriceCubit>().getMarketPrice(
                searchSlug: searchController.text,
                marketId: market?.id,
                type: type?.type,
                category: category?.id,
              );
        },
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: CustomTheme.symmetricHozPadding, vertical: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: CustomSearchField(
                        controller: searchController,
                        hintText: LocaleKeys.search.tr(),
                        onChanged: (value) {
                          _search(value);
                        },
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).unfocus();
                          _search(value);
                        },
                        onTapSuffixButton: () {
                          searchController.clear();
                          _search("");
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
              ],
            ),
          ),
          Expanded(
              child: Container(
            child: BlocConsumer<MarketPriceCubit, CommonState>(
              listener: (context, state) {
                if (state is CommonDataFetchSuccess) {
                  _isLoadMoreActive = false;
                }
              },
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
                } else if (state is CommonLoading) {
                  return const CommonNoDataWidget();
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
                            _isLoadMoreActive = true;
                            context.read<MarketPriceCubit>().loadMore(
                                searchSlug: searchController.text.trim());
                          }
                        }
                        return true;
                      },
                      child: SingleChildScrollView(
                        child: Column(
                          children: List.generate(state.data.length, (index) {
                            final data = marketPriceList
                                .getMarketPrice[state.data[index]];
                            if (data != null) {
                              return MarketItemWidget(data: data);
                            }
                            return const SizedBox.expand();
                          }),
                        ),
                      ));
                }

                return const SizedBox();
              },
            ),
          ))
        ],
      ),
    );
  }
}
