import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/feature/weather/constant/city_constant.dart';
import 'package:krishi_hub/feature/weather/cubit/get_weather_cubit.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';

class CitySearchWidget extends StatelessWidget {
  final String selectedCity;

  final ValueChanged onChange;
  const CitySearchWidget({
    Key? key,
    required this.selectedCity,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: SizedBox(
              height: 40,
              child: DropdownButtonFormField<String>(
                focusColor: CustomTheme.white,
                hint: const Text("City"),
                value: selectedCity,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.wp),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    onChange(newValue);

                    context
                        .read<GetWeatherCubit>()
                        .getWeather(cityName: newValue);
                  }
                },
                items: CityConstant.city.map((String city) {
                  return DropdownMenuItem<String>(
                    value: city,
                    child: Text(city),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
