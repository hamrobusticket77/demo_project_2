import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/common_svg_widget.dart';
import 'package:krishi_hub/common/constant/constant_assets.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';
import 'package:krishi_hub/common/utils/custom_toast.dart';
import 'package:krishi_hub/common/widget/app_bar/custom_app_bar.dart';
import 'package:krishi_hub/common/widget/button/custom_rounded_button.dart';
import 'package:krishi_hub/common/widget/dropdown/common_dropdown_type.dart';
import 'package:krishi_hub/common/widget/dropdown/common_dropdown_widget.dart';
import 'package:krishi_hub/feature/filter/cubit/market_list_cubit.dart';
import 'package:krishi_hub/feature/filter/cubit/product_category_cubit.dart';
import 'package:krishi_hub/feature/filter/cubit/product_list_cubit.dart';

class ProductFilterDrawer extends StatefulWidget {
  final CommonDropDownType? selectedMarket;
  final CommonDropDownType? selectedType;
  final CommonDropDownType? selectedCategory;
  final CommonDropDownType? selectedProduct;

  final bool hasMarket;
  final bool hasType;
  final bool hasCategory;
  final bool hasProduct;
  final bool hasAppBar;
  final Function(
    CommonDropDownType? selectedMarket,
    CommonDropDownType? selectedType,
    CommonDropDownType? selectedCategory,
    CommonDropDownType? selectedProduct,
  ) onFilterUpdate;

  const ProductFilterDrawer({
    super.key,
    this.selectedMarket,
    this.selectedType,
    this.selectedCategory,
    this.selectedProduct,
    this.hasCategory = true,
    this.hasMarket = true,
    this.hasProduct = true,
    this.hasType = true,
    this.hasAppBar = true,
    required this.onFilterUpdate,
  });

  @override
  State<ProductFilterDrawer> createState() => ProductFilterDrawerState();
}

class ProductFilterDrawerState extends State<ProductFilterDrawer> {
  List<CommonDropDownType> marketList = [];
  List<CommonDropDownType> typeList = [];
  List<CommonDropDownType> categoryList = [];
  List<CommonDropDownType> productList = [];

  CommonDropDownType? selectedMarket;
  CommonDropDownType? selectedType;
  CommonDropDownType? selectedCategory;
  CommonDropDownType? selectedProduct;

  @override
  void initState() {
    typeList = [
      CommonDropDownType.all(),
      CommonDropDownType.liveStock(),
      CommonDropDownType.crop()
    ];
    final marketBloc = context.read<MarketListCubit>();
    final productCategoryBloc = context.read<ProductCategoryCubit>();
    final productBloc = context.read<ProductCategoryCubit>();

    if (marketBloc.state is CommonDataFetchSuccess<CommonDropDownType>) {
      var value =
          marketBloc.state as CommonDataFetchSuccess<CommonDropDownType>;

      marketList = value.data;
    } else {}

    if (productCategoryBloc.state
        is CommonDataFetchSuccess<CommonDropDownType>) {
      var value = productCategoryBloc.state
          as CommonDataFetchSuccess<CommonDropDownType>;

      categoryList = value.data;
    } else {
      // widget.reload!();
    }

    if (productBloc.state is CommonDataFetchSuccess<CommonDropDownType>) {
      var value =
          productBloc.state as CommonDataFetchSuccess<CommonDropDownType>;

      productList = value.data;
    }

    if (widget.selectedMarket != null) selectedMarket = widget.selectedMarket!;
    selectedType = widget.selectedType;
    selectedCategory = widget.selectedCategory;
    setState(() {});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<ProductListCubit, CommonState>(
      listener: (context, state) {
        if (state is CommonError) {
          CustomToast.error(message: state.message);
        }
        if (state is CommonDataFetchSuccess<CommonDropDownType>) {
          productList.clear();
          productList = state.data;
          setState(() {});
        }
      },
      child: BlocListener<ProductCategoryCubit, CommonState>(
        listener: (context, state) {
          if (state is CommonDataFetchSuccess<CommonDropDownType>) {
            categoryList.clear();
            categoryList = state.data;
            setState(() {});
          }
          if (state is CommonError) {
            CustomToast.error(message: state.message);
          }
        },
        child: Drawer(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          child: Column(
            children: [
              if (widget.hasAppBar)
                CustomAppBar(
                  title: LocaleKeys.filter.tr(),
                  leadingIcon: InkWell(
                      onTap: () {
                        NavigationService.pop();
                      },
                      child: const CommonSvgWidget(
                        svgName: Assets.cancel,
                        color: CustomTheme.white,
                      )),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      if (widget.hasMarket)
                        Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.business_center_sharp,
                                  color: theme.primaryColor,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: CommonDropDownWidget(
                                    onChange: (value) {
                                      selectedMarket = value;
                                      setState(() {});
                                    },
                                    dropDownList: marketList,
                                    hintText: LocaleKeys.market.tr(),
                                    selectedDropDown: selectedMarket,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      if (widget.hasType)
                        Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.dashboard,
                                  color: theme.primaryColor,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: CommonDropDownWidget(
                                    onChange: (value) {
                                      selectedType = value;
                                      selectedCategory = null;

                                      setState(() {});
                                      context
                                          .read<ProductCategoryCubit>()
                                          .getProductCategory(
                                              selectedType?.type ?? "");
                                    },
                                    dropDownList: typeList,
                                    hintText: LocaleKeys.type.tr(),
                                    selectedDropDown: selectedType,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      if (widget.hasCategory && selectedType != null)
                        Column(
                          children: [
                            BlocBuilder<ProductCategoryCubit, CommonState>(
                              builder: (context, state) {
                                return AbsorbPointer(
                                  absorbing:
                                      state is CommonLoading ? true : false,
                                  child: Row(
                                    children: [
                                      state is CommonLoading
                                          ? const CupertinoActivityIndicator()
                                          : Icon(
                                              Icons.category,
                                              color: theme.primaryColor,
                                            ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: CommonDropDownWidget(
                                          key: UniqueKey(),
                                          onChange: (value) {
                                            selectedCategory = value;

                                            if (widget.hasProduct &&
                                                selectedCategory != null) {
                                              context
                                                  .read<ProductListCubit>()
                                                  .getProductByCategoryType(
                                                      selectedCategory?.id ??
                                                          "");
                                            }
                                          },
                                          dropDownList: categoryList,
                                          hintText:
                                              LocaleKeys.prodcutCategory.tr(),
                                          selectedDropDown: selectedCategory,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      if (widget.hasProduct)
                        Column(
                          children: [
                            if (widget.hasCategory && selectedType != null)
                              BlocBuilder<ProductListCubit, CommonState>(
                                builder: (context, state) {
                                  return AbsorbPointer(
                                    absorbing:
                                        state is CommonLoading ? true : false,
                                    child: Row(
                                      children: [
                                        state is CommonLoading
                                            ? const CupertinoActivityIndicator()
                                            : Icon(
                                                Icons.category,
                                                color: theme.primaryColor,
                                              ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: CommonDropDownWidget(
                                            key: UniqueKey(),
                                            onChange: (value) {
                                              selectedProduct = value;
                                            },
                                            dropDownList: productList,
                                            hintText:
                                                LocaleKeys.productTitle.tr(),
                                            selectedDropDown: selectedProduct,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      const SizedBox(
                        height: 34,
                      ),
                      // CustomRoundedButton(
                      //   verticalPadding: 10,
                      //   // horizontalPadding: 40,
                      //   title: LocaleKeys.applyFilter.tr(),
                      //   onPressed: () {
                      //     widget.onFilterUpdate(
                      //       selectedMarket,
                      //       selectedType,
                      //       selectedCategory,
                      //       selectedProduct,
                      //     );
                      //     Navigator.pop(
                      //       context,
                      //     );
                      //   },
                      // ),
                      Row(
                        children: [
                          const Expanded(child: SizedBox()),
                          CustomRoundedButton(
                            verticalPadding: 10,
                            // horizontalPadding: 40,
                            title: LocaleKeys.applyFilter.tr(),
                            onPressed: () {
                              widget.onFilterUpdate(
                                selectedMarket,
                                selectedType,
                                selectedCategory,
                                selectedProduct,
                              );
                              Navigator.pop(
                                context,
                              );
                            },
                          ),
                          const Expanded(child: SizedBox()),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
