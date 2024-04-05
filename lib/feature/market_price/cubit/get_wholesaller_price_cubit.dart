import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/response/response.dart';
import 'package:krishi_hub/feature/market_price/resources/market_price_repository.dart';

class GetWholeSallerPriceCubit extends Cubit<CommonState> {
  final MarketPriceRepository marketPriceRepository;
  GetWholeSallerPriceCubit({required this.marketPriceRepository})
      : super(CommonInitial());

  getWholeSallerPrice(
      {String searchSlug = "",
      String? type,
      String? categeory,
      String? product}) async {
    emit(CommonLoading());
    await Future.delayed(const Duration(milliseconds: 200));
    final res = await marketPriceRepository.getWholesalerRate(
      searchSlug: searchSlug,
      type: type,
      category: categeory,
      product: product,
    );
    if (res.status == Status.success) {
      if (res.data != null) {
        emit(CommonDataFetchSuccess<String>(data: res.data!));
      } else {
        emit(const CommonNoData());
      }
    } else {
      emit(CommonError(message: res.message ?? "something went worng"));
    }
  }

  loadMoreWholeSallerPrice({String searchSlug = ""}) async {
    emit(CommonDummyLoading());
    final res = await marketPriceRepository.getWholesalerRate(
      isLoadMore: true,
      searchSlug: searchSlug,
    );
    if (res.status == Status.success) {
      if (res.data != null) {
        if (res.data!.isEmpty) {
          emit(const CommonNoData());
        } else {
          emit(
            CommonDataFetchSuccess<String>(data: res.data!),
          );
        }
      } else {
        emit(CommonDataFetchSuccess<String>(
            data: marketPriceRepository.getItems));
      }
    } else {
      emit(
          CommonDataFetchSuccess<String>(data: marketPriceRepository.getItems));
    }
  }
}
