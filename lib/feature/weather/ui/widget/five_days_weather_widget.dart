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
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/utils/time_utils.dart';
import 'package:krishi_hub/common/widget/app_bar/custom_app_bar.dart';
import 'package:krishi_hub/feature/weather/cubit/get_five_days_weather_cubit.dart';
import 'package:krishi_hub/feature/weather/model/five_days_weather.dart';
import 'package:krishi_hub/feature/weather/utils/temp_conversion_utils.dart';

class FiveDaysWeatherWidget extends StatefulWidget {
  const FiveDaysWeatherWidget({Key? key}) : super(key: key);

  @override
  State<FiveDaysWeatherWidget> createState() => _FiveDaysWeatherWidgetState();
}

class _FiveDaysWeatherWidgetState extends State<FiveDaysWeatherWidget> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    Widget getWeatherIcon(String weatherCondition) {
      switch (weatherCondition) {
        case 'Clouds':
          return const Image(
            image: AssetImage(Assets.cloud),
            height: 60,
            width: 60,
          );
        case 'Rain':
          return const Image(
            image: AssetImage(Assets.rainy),
            height: 60,
            width: 60,
          );
        case 'Thunderstorm':
          return const Image(
            image: AssetImage(Assets.storme),
            height: 60,
            width: 60,
          );
        case 'Clear':
          return const Image(
            image: AssetImage(Assets.sun),
            height: 60,
            width: 60,
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

    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.fivedaysweather.tr(),
      ),
      backgroundColor: CustomTheme.white,
      body: BlocBuilder<GetFiveDaysWeatherCubit, CommonState>(
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
            return CommonErrorWidget(
              message: state.message,
            );
          } else if (state is CommonNoData) {
            return const Center(child: CommonNoDataWidget());
          } else if (state is CommonDataFetchSuccess<FiveDaysWeatherModel>) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      final weatherData = state.data[index];

                      return CommonCardWrapper(
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    // SizedBox(
                                    //   width: 10.wp,
                                    // ),

                                    Text(
                                      "${DateTimeUtils.getWeekDayFromDataTime(weatherData.dt_txt)}, ",
                                      style: textTheme.titleSmall!.copyWith(
                                        fontWeight: FontWeight.w300,
                                        color: CustomTheme.darkGrey,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      textAlign: TextAlign.start,
                                    ),

                                    Text(
                                      DateTimeUtils.convertDateIntoTime(
                                          weatherData.dt_txt),
                                      style: textTheme.titleSmall!.copyWith(
                                        fontWeight: FontWeight.w300,
                                        color: CustomTheme.darkGrey,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      textAlign: TextAlign.start,
                                    ),

                                    const SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                                Text(
                                  weatherData.weather.first.main,
                                  style: textTheme.titleSmall!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                    color: CustomTheme.darkGrey,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                Text(
                                  TempConversionUtils.convertKelvinToCelsius(
                                          weatherData.main.temp) +
                                      '°C',
                                  style: textTheme.titleSmall!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 10.wp,
                            ),
                            // getWeatherIcon(weatherData.weather.first.main),
                            const SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
