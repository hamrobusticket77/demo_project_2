import 'package:flutter/material.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/constant/env.dart';
import 'package:krishi_hub/common/response/response.dart';
import 'package:krishi_hub/common/utils/log.dart';
import 'package:krishi_hub/feature/auth/resource/auth_repository.dart';
import 'package:krishi_hub/feature/calender/constant/calender_constant.dart';
import 'package:krishi_hub/feature/calender/constant/month.dart';
import 'package:krishi_hub/feature/calender/model/calender_model.dart';
import 'package:krishi_hub/feature/calender/model/calender_month_model.dart';
import 'package:krishi_hub/feature/calender/resource/all_calender_repository.dart';
import 'package:krishi_hub/feature/calender/resource/calender_api_provider.dart';
import 'package:krishi_hub/http/api_provider.dart';

class CalenderRepository {
  final ApiProvider apiProvider;

  final AllCalenderRepository allCalenderRepository;

  late CalenderApiProvider calenderApiProvider;
  final AuthRepository authRepository;

  final Env env;

  CalenderRepository({
    required this.apiProvider,
    required this.env,
    required this.authRepository,
    required this.allCalenderRepository,
  }) {
    calenderApiProvider = CalenderApiProvider(
        apiProvider: apiProvider,
        baseUrl: env.baseUrl,
        authRepository: authRepository);
  }

  int _currentPage = 1;
  int _totalPage = 0;
  final List<String> _items = [];
  List<String> get getItems => _items;

  List<CalenderMonthModel> calenderMonthModel = List.generate(
    12,
    (index) => CalenderMonthModel(
      index: index,
      color: CustomTheme.white,
      timePeriod: "",
    ),
  );

  Future<DataResponse<List<String>>> getCalender(
      {bool isLoadMore = false,
      required int id,
      required String ecologicalRegion}) async {
    List<CalenderModel> temp;
    try {
      if (isLoadMore) {
        if (_currentPage == _totalPage) {
          return DataResponse.success(_items);
        }
        _currentPage++;
      }
      if (!isLoadMore) {
        _items.clear();
        allCalenderRepository.clearAll();
        _currentPage = 1;
        _totalPage = 0;
      }

      final res = await calenderApiProvider.getAgricultureCalender(
          currentPage: _currentPage, id: id);

      temp = List.from(res['data']?['data']?['data'] ?? [])
          .map((e) => CalenderModel.fromMap(e))
          .toList();

      _currentPage = res['pagination']?['currentPage'] ?? _currentPage;
      _totalPage = res['pagination']?['total'] ?? _totalPage;

      for (int i = 0; i < temp.length; i++) {
        allCalenderRepository.addAll({temp[i].id: temp[i]});
        _items.add(temp[i].id);
      }

      onChangeEcologicalRegion(
          ecologicalRegion, _items.isNotEmpty ? _items[0] : "");

      return DataResponse.success(_items);
    } catch (e) {
      Log.e(e);
      if (isLoadMore) {
        _currentPage--;
      }

      return DataResponse.error(e.toString());
    }
  }

  onChangeEcologicalRegion(String ecologicalRegion, String index) {
    calenderMonthModel = List.generate(
      12,
      (index) => CalenderMonthModel(
        index: index,
        color: CustomTheme.white,
        timePeriod: "",
      ),
    );

    if (allCalenderRepository.getCalender.values.toList().isNotEmpty) {
      final temp = allCalenderRepository.getCalender[index];

      if (temp != null) {
        if (temp.information
            .any((element) => element.ecologicalArea == ecologicalRegion)) {
          int harvestStartIndex = Month.getMonthIndex(temp.information
              .firstWhere(
                  (element) => element.ecologicalArea == ecologicalRegion)
              .harvestTime
              .startMonth);

          int harvestEndIndex = Month.getMonthIndex(temp.information
              .firstWhere(
                  (element) => element.ecologicalArea == ecologicalRegion)
              .harvestTime
              .endMonth);

          int sowingStartIndex = Month.getMonthIndex(temp.information
              .firstWhere(
                  (element) => element.ecologicalArea == ecologicalRegion)
              .sowingTime
              .startMonth);

          int sowingEndIndex = Month.getMonthIndex(temp.information
              .firstWhere(
                  (element) => element.ecologicalArea == ecologicalRegion)
              .sowingTime
              .endMonth);

          int growingStartIndex = Month.getMonthIndex(temp.information
              .firstWhere(
                  (element) => element.ecologicalArea == ecologicalRegion)
              .growingTime
              .startMonth);

          int growingEndIndex = Month.getMonthIndex(temp.information
              .firstWhere(
                  (element) => element.ecologicalArea == ecologicalRegion)
              .growingTime
              .endMonth);

          if (harvestEndIndex < harvestStartIndex) {
            for (int i = harvestStartIndex; i <= 11; i++) {
              addCalenderData(i, CalenderConstant.harvestingTime);
            }

            for (int i = 0; i <= harvestEndIndex; i++) {
              addCalenderData(i, CalenderConstant.harvestingTime);
            }
          } else {
            for (int i = harvestStartIndex; i <= harvestEndIndex; i++) {
              addCalenderData(i, CalenderConstant.harvestingTime);
            }
          }

          if (sowingEndIndex < sowingStartIndex) {
            for (int i = sowingStartIndex; i <= 11; i++) {
              addCalenderData(i, CalenderConstant.sowingTime);
            }

            for (int i = 0; i <= sowingEndIndex; i++) {
              addCalenderData(i, CalenderConstant.sowingTime);
            }
          } else {
            for (int i = sowingStartIndex; i <= sowingEndIndex; i++) {
              addCalenderData(i, CalenderConstant.sowingTime);
            }
          }

          if (growingEndIndex < growingStartIndex) {
            for (int i = growingStartIndex; i <= 11; i++) {
              addCalenderData(i, CalenderConstant.growingTime);
            }

            for (int i = 0; i <= growingEndIndex; i++) {
              addCalenderData(i, CalenderConstant.growingTime);
            }
          } else {
            for (int i = growingStartIndex; i <= growingEndIndex; i++) {
              addCalenderData(i, CalenderConstant.growingTime);
            }
          }
        }
      }
    }
  }

  addCalenderData(int i, String timePeriod) {
    if (timePeriod == CalenderConstant.harvestingTime) {
      calenderMonthModel[i] = CalenderMonthModel(
          index: i, timePeriod: timePeriod, color: Colors.green.shade600);
    } else if (timePeriod == CalenderConstant.sowingTime) {
      calenderMonthModel[i] = CalenderMonthModel(
          index: i, timePeriod: timePeriod, color: Colors.yellow.shade600);
    } else if (timePeriod == CalenderConstant.growingTime) {
      calenderMonthModel[i] = CalenderMonthModel(
          index: i, timePeriod: timePeriod, color: Colors.grey.shade500);
    }
  }
}
