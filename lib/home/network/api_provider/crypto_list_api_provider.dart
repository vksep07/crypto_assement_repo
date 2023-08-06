


import 'package:crypto_assignment/common/network/endpoints.dart';
import 'package:crypto_assignment/common/network/model/response_api.dart';
import 'package:crypto_assignment/common/network/service/api_service.dart';
import 'package:crypto_assignment/common/network/service/http_service.dart';
import 'package:crypto_assignment/common/network/service/status.dart';

class CryptoListAPIProvider {
  Future<ResponseApi> getCryptoList(
      {required num pageNumber, required int limit}) async {
    return await apiService.getRequest(
      headers: httpService.getHeader(),
      url: Endpoints.cryptoListUrl+'?start=$pageNumber&limit=$limit',
      apiType: ApiStatus.CRYPTO_CURRENCY_LIST_API,
    );
  }
}
