import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:krishi_hub/common/constant/env.dart';
import 'package:krishi_hub/common/hive/hive_storage.dart';
import 'package:krishi_hub/feature/auth/resource/auth_repository.dart';
import 'package:krishi_hub/feature/office_setup/model/answer_question_model.dart';

import 'package:krishi_hub/feature/office_setup/model/office_setup_model.dart';
import 'package:krishi_hub/feature/office_setup/resources/all_answer_question.dart';
import 'package:krishi_hub/feature/office_setup/resources/all_office_center_repository.dart';
import 'package:krishi_hub/feature/office_setup/resources/call_center_api_provider.dart';
import 'package:krishi_hub/feature/phone_book/model/phone_book_model.dart';
import 'package:krishi_hub/http/api_provider.dart';
import 'package:krishi_hub/common/response/response.dart';

class CallCenterRepository {
  final AllCallCenterRepositoy allCallCenterRepository;
  final AllAnswerQuestionRepository allanswerquestionRepository;
  Env env;
  final AuthRepository authRepository;

  final ApiProvider apiProvider;

  late CallCenterApiProvider callcenterApiProvider;

  CallCenterRepository(
      {required this.env,
      required this.allCallCenterRepository,
      required this.apiProvider,
      required this.allanswerquestionRepository,
      required this.authRepository}) {
    callcenterApiProvider = CallCenterApiProvider(
      baseUrl: env.baseUrl,
      apiProvider: apiProvider,
      authRepository: authRepository,
    );
  }

  int _currentPage = 1;
  int _totalPage = 0;
  final List<String> _items = [];
  List<String> get getItems => _items;

  final ValueNotifier<OfficeSetupModel?> _officeSetUp = ValueNotifier(null);
  ValueNotifier<OfficeSetupModel?> get officeSetUp => _officeSetUp;

  Future<DataResponse<List<String>>> getanswerquestionlist(
      {bool isLoadMore = false}) async {
    List<AnswerQuestionModel> temp = [];

    try {
      if (isLoadMore) {
        if (_currentPage == _totalPage) {
          return DataResponse.success(_items);
        }
        _currentPage++;
      }
      if (!isLoadMore) {
        _items.clear();
        _currentPage = 1;
        _totalPage = 0;
      }

      final res = await callcenterApiProvider.getanswerquestionlist(
        currentPage: _currentPage,
      );

      temp = List.from(res['data']?['data']?['data'] ?? [])
          .map((e) => AnswerQuestionModel.fromMap(e))
          .toList();
      _currentPage = res['pagination']?['currentPages'] ?? _currentPage;
      _totalPage = res['pagination']?['total'] ?? _totalPage;

      for (int i = 0; i < temp.length; i++) {
        allanswerquestionRepository.addAll({temp[i].id: temp[i]});
        _items.add(temp[i].id);
      }

      if (_currentPage == 1 && temp.isNotEmpty) {
        await HiveStorage().setListValues<AnswerQuestionModel>(
            HiveStorage().callCenterList, temp);
      }

      return DataResponse.success(_items);
    } catch (e) {
      debugPrint(e.toString());
      if (isLoadMore) {
        _currentPage--;
      }

      if (_currentPage == 1) {
        temp = await HiveStorage()
            .getListValues<AnswerQuestionModel>(HiveStorage().callCenterList);
        if (temp.isNotEmpty) {
          _items.clear();
          allanswerquestionRepository.removeAll();

          for (int i = 0; i < temp.length; i++) {
            allanswerquestionRepository.addAll({temp[i].id: temp[i]});
            _items.add(temp[i].id);
          }

          return DataResponse.success(_items);
        }
      }

      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<List<String>>> getOfficeSetup(
      {bool isLoadMore = false}) async {
    List<OfficeSetupModel> temp = [];

    try {
      final res = await callcenterApiProvider.getofficesetupList();

      temp = List.from(res['data']?['data']?['data'] ?? [])
          .map((e) => OfficeSetupModel.fromMap(e))
          .toList();

      for (int i = 0; i < temp.length; i++) {
        allCallCenterRepository.addAll({temp[i].id: temp[i]});
        _items.add(temp[i].id);
      }

      if (temp.isNotEmpty) {
        _officeSetUp.value = temp[0];

       

        await HiveStorage()
            .setListValues<OfficeSetupModel>(HiveStorage().officeSetup, temp);
      }

      return DataResponse.success(_items);
    } catch (e) {
      temp = await HiveStorage()
          .getListValues<OfficeSetupModel>(HiveStorage().officeSetup);
      if (temp.isNotEmpty) {
        _officeSetUp.value = temp[0];

        for (int i = 0; i < temp.length; i++) {
          allCallCenterRepository.addAll({temp[i].id: temp[i]});
          _items.add(temp[i].id);
        }

        return DataResponse.success(_items);
      }

      debugPrint(e.toString());

      return DataResponse.error(e.toString());
    }
  }
}
