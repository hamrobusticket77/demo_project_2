import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/common_nodata_widget.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/widget/app_bar/custom_app_bar.dart';
import 'package:krishi_hub/common/widget/bottom_navigation_bar_wrapper.dart';
import 'package:krishi_hub/common/widget/button/custom_outline_button.dart';
import 'package:krishi_hub/feature/market_price/cubit/get_market_price_cubit.dart';
import 'package:krishi_hub/feature/market_price/ui/pages/wholesaller_price.dart';

class MarketPriceWidget extends StatefulWidget {
  const MarketPriceWidget({Key? key}) : super(key: key);

  @override
  State<MarketPriceWidget> createState() => _MarketPriceWidgetState();
}

class _MarketPriceWidgetState extends State<MarketPriceWidget> {
  final ScrollController _vertical = ScrollController();
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _vertical.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _vertical.removeListener(_scrollListener);
    _vertical.dispose();
    super.dispose();
  }

  void _scrollListener() {
    setState(() {
      _isScrolled = _vertical.position.pixels != 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: AnimatedContainer(
      //   duration: const Duration(milliseconds: 0),
      //   height: _isScrolled ? 0.0 : 50.0,
      //   child: CustomOutlineButton(
      //     verticalPadding: 4,
      //     fontSize: 13,
      //     sufixIcon: const Icon(
      //       Icons.arrow_forward_ios,
      //       size: 15,
      //       color: Theme.of(context).primaryColor,
      //     ),
      //     onPressed: () {
      //       NavigationService.push(target: const CurrentMarketPrice());
      //     },
      //     name: LocaleKeys.currentMarketPrice.tr(),
      //   ),
      // ),
      bottomNavigationBar: BottomNavigationBarWrapper(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(CustomTheme.symmetricHozPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomOutlineButton(
                    name: LocaleKeys.currentMarketPrice.tr(),
                    onPressed: () {
                      NavigationService.push(target: const WholeSallerPrice());
                    },
                    fontSize: 13,
                    verticalPadding: 5,
                    sufixIcon: const Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).padding.bottom,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      appBar: CustomAppBar(
        title: LocaleKeys.marketPrice.tr(),
      ),
      body: BlocBuilder<GetMarketPriceCubit, CommonState>(
        builder: (context, state) {
          if (state is CommonLoading) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: CustomTheme.symmetricHozPadding.wp,
              ),
              child: Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
            );
          } else if (state is CommonError) {
            return const CommonNoDataWidget();
          } else if (state is CommonNoData) {
            return const Center(child: CommonNoDataWidget());
          } else if (state is CommonStateSuccess<List<List<String>>>) {
            return NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification is ScrollUpdateNotification) {
                  _scrollListener();
                }
                return false;
              },
              child: Stack(
                children: [
                  SingleChildScrollView(
                    controller: _vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: [
                          DataTable(
                            dataRowMinHeight: 40,
                            columns: const [
                              DataColumn(label: Text('कृषि उपज')),
                              DataColumn(label: Text('न्यूनतम')),
                              DataColumn(label: Text('अधिकतम')),
                              DataColumn(label: Text('औसत')),
                            ],
                            rows: state.data.sublist(1).map((innerList) {
                              return DataRow(
                                cells: innerList.map((data) {
                                  return DataCell(
                                    Text(
                                      data,
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                  );
                                }).toList(),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
