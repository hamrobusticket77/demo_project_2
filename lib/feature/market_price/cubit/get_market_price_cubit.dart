import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/response/response.dart';
import 'package:krishi_hub/feature/market_price/resources/market_price_repository.dart';

class GetMarketPriceCubit extends Cubit<CommonState> {
  final MarketPriceRepository marketPriceRepository;
  GetMarketPriceCubit({required this.marketPriceRepository})
      : super(CommonInitial());

  getMarketPrice() async {
    emit(CommonLoading());
    await Future.delayed(const Duration(milliseconds: 200));
    final res = await marketPriceRepository.getMarketPrices();
    if (res.status == Status.success) {
      if (res.data != null) {
        emit(CommonStateSuccess<List<List<String>>>(data: res.data!));
      } else {
        emit(const CommonNoData());
      }
    } else {
      emit(CommonError(message: res.message ?? "something went worng"));
    }
  }
}
