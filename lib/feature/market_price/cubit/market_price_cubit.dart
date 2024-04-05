import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/response/response.dart';
import 'package:krishi_hub/feature/market_price/resources/market_price_repository.dart';

class MarketPriceCubit extends Cubit<CommonState> {
  final MarketPriceRepository marketPriceRepository;
  MarketPriceCubit({required this.marketPriceRepository})
      : super(CommonInitial());

  getMarketPrice({
    String? searchSlug,
    String? marketId,
    String? type,
    String? category,
    String? product,
  }) async {
    emit(CommonLoading());
    await Future.delayed(const Duration(milliseconds: 200));
    final res = await marketPriceRepository.getMarketPriceNew(
      searchSlug: searchSlug,
      marketId: marketId,
      category: category,
      type: type,
      product: product,
    );
    if (res.status == Status.success) {
      if (res.data != null && res.data!.isNotEmpty) {
        emit(CommonDataFetchSuccess<String>(data: res.data!));
      } else {
        emit(const CommonNoData());
      }
    } else {
      emit(CommonError(message: res.message ?? "something went worng"));
    }
  }

  loadMore({
    String? searchSlug,
    String? marketId,
    String? category,
    String? product,
  }) async {
    emit(CommonDummyLoading());
    final res = await marketPriceRepository.getMarketPriceNew(
      isLoadMore: true,
      searchSlug: searchSlug,
      marketId: marketId,
      category: category,
      product: product,
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
