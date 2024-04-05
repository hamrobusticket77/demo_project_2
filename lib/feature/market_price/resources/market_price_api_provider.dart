import '../../../http/api_provider.dart';

class MarketPriceApiProvider {
  final String baseUrl;
  final String globalBaseUrl;
  final ApiProvider apiProvider;

  MarketPriceApiProvider({
    required this.baseUrl,
    required this.apiProvider,
    required this.globalBaseUrl,
  });

  Future<dynamic> getMarketList() async {
    Uri uri = Uri.parse("$globalBaseUrl/market/list");

    return await apiProvider.get(
      uri,
      globalBaseUrl: globalBaseUrl,
    );
  }

  Future<dynamic> getMarketPrice({
    required int currentPage,
    String? search,
    String? marketId,
    String? type,
    String? category,
    String? product,
  }) async {
    final Map<String, dynamic> param = {
      "page": currentPage.toString(),
      "perpage": "20",
      "search": search ?? "",
    };

    if (marketId != null && marketId.isNotEmpty) param['market'] = marketId;
    if (type != null && type.isNotEmpty) param['type'] = type;
    if (category != null && category.isNotEmpty) param['category'] = category;
    if (product != null && product.isEmpty) param['product'] = product;

    Uri uri = Uri.parse(
      "$globalBaseUrl/market-price",
    );

    uri = uri.replace(queryParameters: param);
    return await apiProvider.get(uri, globalBaseUrl: globalBaseUrl);
  }

  Future<dynamic> getWholesalerRate({
    required int currentPage,
    String searchSlug = "",
    String? type,
    String? category,
    String? product,
  }) async {
    final Map<String, dynamic> param = {
      "page": currentPage.toString(),
      "perpage": "20",
      "search": searchSlug,
    };
    if (type != null && type.isNotEmpty) param['type'] = type;
    if (category != null && category.isNotEmpty) param['category'] = category;
    if (product != null && product.isEmpty) param['product'] = product;
    Uri uri = Uri.parse("$globalBaseUrl/wholesaler");
    uri = uri.replace(queryParameters: param);

    return await apiProvider.get(
      uri,
    );
  }

  Future<dynamic> getCurrentMarkerDetail({required String id}) async {
    Uri uri = Uri.parse("$globalBaseUrl/wholesaler/$id");

    return await apiProvider.get(
      uri,
      globalBaseUrl: globalBaseUrl,
    );
  }
}
