import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/response/response.dart';
import 'package:krishi_hub/feature/market_price/model/current_market_price_model.dart';
import 'package:krishi_hub/feature/market_price/resources/market_price_repository.dart';

class GetCurrentMarketPriceDetailCubit extends Cubit<CommonState> {
  final MarketPriceRepository marketPriceRepository;
  GetCurrentMarketPriceDetailCubit({
    required this.marketPriceRepository,
  }) : super(CommonInitial());

  getCurrentMarketPriceDetailCubit({required String id}) async {
    emit(CommonLoading());
    final res = await marketPriceRepository.getCurrentMarketPriceDetail(id: id);
    if (res.status == Status.success) {
      if (res.data != null) {
        emit(CommonStateSuccess<CurrentMarketPriceModel>(data: res.data!));
      } else {
        emit(const CommonNoData());
      }
    } else {
      emit(CommonError(message: res.message ?? ""));
    }
  }
}
