import 'package:hive_flutter/hive_flutter.dart';
import 'package:krishi_hub/common/constant/env.dart';
import 'package:krishi_hub/common/hive/hive_storage.dart';
import 'package:krishi_hub/common/utils/log.dart';
import 'package:krishi_hub/feature/auth/resource/auth_repository.dart';
import 'package:krishi_hub/feature/phone_book/model/office_model.dart';
import 'package:krishi_hub/feature/phone_book/model/phone_book_model.dart';
import 'package:krishi_hub/feature/phone_book/model/sub_office_model.dart';
import 'package:krishi_hub/feature/phone_book/resources/all_office_repository.dart';
import 'package:krishi_hub/feature/phone_book/resources/all_phone_book_repository.dart';
import 'package:krishi_hub/feature/phone_book/resources/all_sub_office_repository.dart';
import 'package:krishi_hub/feature/phone_book/resources/phone_book_api_provider.dart';
import 'package:krishi_hub/http/api_provider.dart';
import 'package:krishi_hub/common/response/response.dart';

class PhoneBookRepository {
  final Env env;
  final ApiProvider apiProvider;
  late PhoneBookApiProvider phoneBookApiProvider;
  final AuthRepository authRepository;
  final AllPhoneBookRepository allPhoneBookRepository;
  final AllOfficeRepository allOfficeRepository;
  final AllSubOfficeRepository allSubOfficeRepository;
  PhoneBookRepository({
    required this.apiProvider,
    required this.env,
    required this.allPhoneBookRepository,
    required this.authRepository,
    required this.allOfficeRepository,
    required this.allSubOfficeRepository,
  }) {
    phoneBookApiProvider = PhoneBookApiProvider(
      baseUrl: env.baseUrl,
      apiProvider: apiProvider,
      authRepository: authRepository,
      globalUrl: env.globalBaseUrl,
    );
  }

  int _currentPage = 1;
  int _totalPage = 0;

  int _officeCurrentPage = 1;
  int _officetotalPage = 0;

  int _subOfficeCurrentPage = 1;
  int _subOfficeTotalPage = 0;
  final List<String> _items = [];
  final List<String> _office = [];

  List<String> get getItems => _items;
  List<String> get getOffices => _office;

  final List<String> _suboffice = [];
  List<String> get getSuboffice => _suboffice;

  Future<DataResponse<List<String>>> getPhoneBook(
      {bool isLoadMore = false, String searchSlug = ""}) async {
    List<PhoneBookModel> temp = [];

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
      final res = await phoneBookApiProvider.getphoneBook(
        currentPage: _currentPage,
        searchSlug: searchSlug,
      );

      temp = List.from(res['data']?['data']?['data'] ?? [])
          .map((e) => PhoneBookModel.fromMap(e))
          .toList();
      _currentPage = res['data']?['pagination']?['currentPage'] ?? _currentPage;
      _totalPage = res['data']?['pagination']?['totalPages'] ?? _totalPage;

      for (int i = 0; i < temp.length; i++) {
        allPhoneBookRepository.addAll({temp[i].id: temp[i]});
        _items.add(temp[i].id);
      }

      return DataResponse.success(_items);
    } catch (e) {
      Log.e(e);
      if (isLoadMore) {
        _currentPage--;
      }

      return DataResponse.success(_items);
    }
  }

  Future<DataResponse<List<String>>> getOffice(
      {bool isLoadMore = false,
      String searchSlug = "",
      required String id}) async {
    List<OfficeModel> temp = [];

    try {
      if (isLoadMore) {
        if (_officeCurrentPage == _officetotalPage) {
          return DataResponse.success(_office);
        }
        _currentPage++;
      }
      if (!isLoadMore) {
        _office.clear();
        _currentPage = 1;
        _totalPage = 0;
      }
      final res = await phoneBookApiProvider.getOffice(
        currentPage: _currentPage,
        searchSlug: searchSlug,
        id: id,
      );

      temp = List.from(res['data']?['data']?['data'] ?? [])
          .map((e) => OfficeModel.fromMap(e))
          .toList();
      _officeCurrentPage =
          res['data']?['pagination']?['currentPage'] ?? _officeCurrentPage;
      _officetotalPage =
          res['data']?['pagination']?['totalPages'] ?? _officetotalPage;

      for (int i = 0; i < temp.length; i++) {
        allOfficeRepository.addAll({temp[i].id: temp[i]});
        _office.add(temp[i].id);
      }

      return DataResponse.success(_office);
    } catch (e) {
      Log.e(e);
      if (isLoadMore) {
        _officeCurrentPage--;
      }

      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<List<String>>> getSubOffice({
    bool isLoadMore = false,
    String searchSlug = "",
    required String departement,
    required String office,
  }) async {
    List<SubofficeModel> temp = [];

    try {
      if (isLoadMore) {
        if (_subOfficeCurrentPage == _subOfficeTotalPage) {
          return DataResponse.success(_suboffice);
        }
        _currentPage++;
      }
      if (!isLoadMore) {
        _suboffice.clear();
        _currentPage = 1;
        _subOfficeTotalPage = 0;
      }
      final res = await phoneBookApiProvider.getSuboffice(
        currentPage: _currentPage,
        searchSlug: searchSlug,
        departement: departement,
        office: office,
      );

      temp = List.from(res['data']?['data']?['data'] ?? [])
          .map((e) => SubofficeModel.fromMap(e))
          .toList();
      _subOfficeCurrentPage =
          res['data']?['pagination']?['currentPage'] ?? _subOfficeCurrentPage;
      _subOfficeTotalPage =
          res['data']?['pagination']?['totalPages'] ?? _subOfficeTotalPage;

      for (int i = 0; i < temp.length; i++) {
        allSubOfficeRepository.addAll({temp[i].id: temp[i]});
        _suboffice.add(temp[i].id);
      }

      return DataResponse.success(_suboffice);
    } catch (e) {
      Log.e(e);
      if (isLoadMore) {
        _currentPage--;
      }

      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<OfficeModel>> getOfficeDetail(
      {required String id}) async {
    try {
      final res = await phoneBookApiProvider.getofficeDetail(id: id);

      OfficeModel temp = OfficeModel.fromMap(res['data']?['data']);

      return DataResponse.success(temp);
    } catch (e) {
      Log.e(e);

      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<SubofficeModel>> getSubOfficeDetail(
      {required String id}) async {
    try {
      final res = await phoneBookApiProvider.getSubOfficeDetail(id: id);

      SubofficeModel temp = SubofficeModel.fromMap(res['data']?['data']);

      return DataResponse.success(temp);
    } catch (e) {
      Log.e(e);

      return DataResponse.error(e.toString());
    }
  }
}
