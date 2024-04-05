import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/common_card_wapper.dart';
import 'package:krishi_hub/common/common_error_widget.dart';
import 'package:krishi_hub/common/common_nodata_widget.dart';
import 'package:krishi_hub/common/constant/constant_assets.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';
import 'package:krishi_hub/common/utils/check_locale.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/widget/app_bar/custom_app_bar.dart';
import 'package:krishi_hub/common/widget/shimmer/shimmer_widget.dart';
import 'package:krishi_hub/feature/weather/constant/city_constant.dart';
import 'package:krishi_hub/feature/weather/cubit/get_weather_cubit.dart';
import 'package:krishi_hub/feature/weather/model/today_weather_model.dart';
import 'package:krishi_hub/feature/weather/ui/pages/five_day_weather_page.dart';
import 'package:krishi_hub/feature/weather/ui/widget/city_search_widget_page.dart';
import 'package:krishi_hub/feature/weather/ui/widget/common_weather_item.dart';
import 'package:krishi_hub/feature/weather/utils/temp_conversion_utils.dart';

class WeatherWidgetPage extends StatefulWidget {
  const WeatherWidgetPage({
    super.key,
  });

  @override
  State<WeatherWidgetPage> createState() => _WeatherWidgetPageState();
}

class _WeatherWidgetPageState extends State<WeatherWidgetPage> {
  String _selectedCity = CheckLocal.isEnglish()
      ? CityConstant.benighatEn
      : CityConstant.benighatNe;
  Widget getWeatherIcon(String weatherCondition) {
    switch (weatherCondition) {
      case 'Clouds':
        return const Image(
          image: AssetImage(Assets.cloud),
          height: 85,
          width: 85,
        );
      case 'Rain':
        return const Image(
          image: AssetImage(Assets.rainy),
          height: 85,
          width: 85,
        );
      case 'Thunderstorm':
        return const Image(
          image: AssetImage(Assets.storme),
          height: 85,
          width: 85,
        );
      case 'Snow':
        return const Image(
          image: AssetImage(Assets.winter),
          height: 85,
          width: 85,
        );
      case 'Drizzle':
        return const Image(
          image: AssetImage(Assets.storme),
          height: 60,
          width: 60,
        );
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    // double myWidth = MediaQuery.of(context).size.width;

    final textTheme = Theme.of(context).textTheme;

    return BlocListener<GetWeatherCubit, CommonState>(
        listener: (context, state) {},
        child: Scaffold(
          appBar: CustomAppBar(
            title: LocaleKeys.weather.tr(),
          ),
          body: BlocBuilder<GetWeatherCubit, CommonState>(
              builder: (context, state) {
            if (state is CommonLoading) {
              return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 0,
                  ),
                  child: ListViewPlaceHolder(
                    itemHeight: myHeight,
                    numberofItem: 1,
                  ));
            } else if (state is CommonError) {
              return CommonErrorWidget(
                message: state.message,
              );
            } else if (state is CommonNoData) {
              return const Center(child: CommonNoDataWidget());
            } else if (state is CommonStateSuccess<TodayWeatherModel>) {
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: CustomTheme.symmetricHozPadding.wp),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10.hp,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CitySearchWidget(
                              onChange: (value) {
                                _selectedCity = value ?? "Benighat";

                                // setState(() {});
                              },
                              selectedCity: _selectedCity,
                            ),
                          ),
                          const Expanded(child: SizedBox())
                        ],
                      ),
                      SizedBox(
                        height: 20.hp,
                      ),
                      Text(
                        TempConversionUtils.convertKelvinToCelsius(
                                state.data.main.temp) +
                            '°C',
                        style: const TextStyle(
                          fontSize: 45,
                          color: CustomTheme.darkGrey,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            state.data.weather.first.main,
                            style: const TextStyle(
                              fontSize: 20,
                              color: CustomTheme.darkGrey,
                            ),
                          ),
                          SizedBox(
                            width: 5.hp,
                          ),
                          // getWeatherIcon(state.data.weather.first.main),
                        ],
                      ),
                      SizedBox(height: 20.hp),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CommonCardWrapper(
                            onTap: () {
                              NavigationService.push(
                                  target: const FiveDaysWeatherPage());
                            },
                            margin: const EdgeInsets.all(0),
                            child: Row(
                              children: [
                                Text(
                                  LocaleKeys.fivedays.tr() +
                                      LocaleKeys.weather.tr(),
                                  style: textTheme.titleSmall,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: 15,
                                  color: Theme.of(context).primaryColor,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20.hp),
                      Row(
                        children: [
                          Expanded(
                              child: CommonWeatherItem(
                            icon: Assets.temperature,
                            subTitle:
                                TempConversionUtils.convertKelvinToCelsius(
                                        state.data.main.tempMin) +
                                    '°C',
                            title: TempConversionUtils.convertKelvinToCelsius(
                                    state.data.main.tempMax) +
                                '°C',
                          )),
                          SizedBox(width: 10.wp),
                          Expanded(
                              child: CommonWeatherItem(
                            icon: Assets.air,
                            subTitle: state.data.wind.speed.toString(),
                            title: LocaleKeys.winespped.tr(),
                          ))
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: CommonWeatherItem(
                            icon: Assets.waves,
                            subTitle: (state.data.main.pressure / 100)
                                .toStringAsFixed(2),
                            title: LocaleKeys.pressure.tr(),
                          )),
                          SizedBox(width: 10.wp),
                          Expanded(
                            child: CommonWeatherItem(
                              icon: Assets.light,
                              subTitle: state.data.main.humidity.toString(),
                              title: LocaleKeys.humidity.tr(),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: CommonWeatherItem(
                            icon: Assets.nights,
                            subTitle: DateFormat('h:mm a').format(
                              DateTime.fromMillisecondsSinceEpoch(
                                int.tryParse(
                                        state.data.sys.sunrise.toString())! *
                                    1000,
                              ),
                            ),
                            title: LocaleKeys.sunrise.tr(),
                          )),
                          SizedBox(width: 10.wp),
                          Expanded(
                              child: CommonWeatherItem(
                            icon: Assets.sunset,
                            subTitle: DateFormat('h:mm a').format(
                              DateTime.fromMillisecondsSinceEpoch(
                                int.tryParse(
                                        state.data.sys.sunset.toString())! *
                                    1000,
                              ),
                            ),
                            title: LocaleKeys.sunset.tr(),
                          ))
                        ],
                      )
                    ],
                  ),
                ),
              );
            } else {
              return const SizedBox();
            }
          }),
        ));
  }
}
