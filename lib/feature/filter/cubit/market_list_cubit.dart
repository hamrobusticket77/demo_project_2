

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/response/response.dart';
import 'package:krishi_hub/common/widget/dropdown/common_dropdown_type.dart';
import 'package:krishi_hub/feature/market_price/resources/market_price_repository.dart';

class MarketListCubit extends Cubit<CommonState> {
  final MarketPriceRepository marketPriceRepository;

  MarketListCubit({
    required this.marketPriceRepository,
  }) : super(CommonInitial());

  getMarketList() async {
    emit(CommonLoading());
    final res = await marketPriceRepository.getMarketList();

    if (res.status == Status.success) {
      if (res.data != null && res.data!.isNotEmpty) {
        List<CommonDropDownType> _data = [];

        _data.add(CommonDropDownType.all());
        for (var value in res.data!) {
          CommonDropDownType(
            type: "",
            en: value.title,
            ne: value.title,
            id: value.id,
          );
          _data.add(CommonDropDownType(
            type: "",
            en: value.title,
            ne: value.title,
            id: value.id,
          ));
        }
        emit(CommonDataFetchSuccess<CommonDropDownType>(data: _data));
      } else {
        emit(const CommonNoData());
      }
    } else {
      emit(CommonError(message: res.message ?? "something went wrong"));
    }
  }
}
