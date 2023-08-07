import 'dart:convert';

import 'package:crypto_assignment/common/logger/app_logger.dart';
import 'package:crypto_assignment/common/network/service/status.dart';
import 'package:crypto_assignment/home/bloc/favourte_screen_bloc.dart';
import 'package:crypto_assignment/home/network/api_provider/crypto_list_api_provider.dart';
import 'package:crypto_assignment/home/network/model/response/crypto_list_res_model.dart';
import 'package:crypto_assignment/main.dart';
import 'package:crypto_assignment/util/constants.dart';
import 'package:crypto_assignment/util/database/database_helper.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:rxdart/rxdart.dart';

class CryptoListScreenBloc {
  num? _pageNumber = DEFAULT_START;

  EasyRefreshController? refreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );
  BehaviorSubject<List<CryptoModel>> _cryptoModelListController =
      BehaviorSubject<List<CryptoModel>>.seeded([]);

  List<CryptoModel>? cryptoModelList = [];

  BehaviorSubject<List<CryptoModel>> get cryptoModelListController =>
      _cryptoModelListController;

  BehaviorSubject<bool> _loadMoreController =
      BehaviorSubject<bool>.seeded(false);

  BehaviorSubject<bool> get loadMoreController => _loadMoreController;

  BehaviorSubject<bool> _loadingController =
      BehaviorSubject<bool>.seeded(false);

  BehaviorSubject<bool> get loadingController => _loadingController;

  Future<void> callCryptoListApi({num? pageNumber, int? limit}) async {
    AppLogger.printLog('callCryptoListApi step 1');
    if (pageNumber! > DEFAULT_START) {
      _loadMoreController.add(true);
    } else {
      _loadingController.add(true);
    }

    //  try {
    final resp = await CryptoListAPIProvider().getCryptoList(
      pageNumber: pageNumber,
      limit: limit!,
    );
    if (resp.status == ApiStatus.SUCCESS) {
      AppLogger.printLog(resp.toString());
      CryptoListResModel? cryptoListResModel =
          CryptoListResModel.fromJson(json.decode(resp.data.toString()));

      AppLogger.printLog('resposne - ${resp.data.toString()}');
      if (cryptoListResModel != null &&
          cryptoListResModel.data!.isEmpty &&
          pageNumber == DEFAULT_START) {
        _loadingController.add(false);
        loadMoreController.add(false);
        return;
      }

      if (pageNumber == DEFAULT_START) {
        cryptoModelList = cryptoListResModel.data!;
        _cryptoModelListController.add([]);
        _cryptoModelListController.add(cryptoModelList ?? []);
      } else {
        cryptoModelList!.addAll(cryptoListResModel.data!);
        _cryptoModelListController.add(cryptoModelList ?? []);
        AppLogger.printLog('resposne list size - ${cryptoModelList!.length}');

      }
      if (cryptoModelList!.isNotEmpty) {
        setCurrentPageNumber(pageNumber: getCurrentPageNumber()! + 1);
      }

      _loadingController.add(false);
      _loadMoreController.add(false);
    }
    /*} catch (err) {
      _loadingController.addError(err);
    }*/
  }

  String? getBitCoinImageUrl({required String imageId}) {
    return 'https://s2.coinmarketcap.com/static/img/coins/64x64/${imageId}.png';
  }

  void addFavouriteInDB({CryptoModel? cryptoModel}) async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnCryptoData: json.encode(cryptoModel?.toJson()),
      DatabaseHelper.columnCryptoID: '${cryptoModel?.id}',
    };
    final id = await dbHelper.insert(row);
    favouriteScreenBloc.favouriteStatus.add(true);
    AppLogger.printLog('inserted row id: $id');
  }

  void deleteFavouriteInDB({CryptoModel? cryptoModel}) async {
    // row to delete
    final id = await dbHelper.delete(cryptoModel!.id ?? 0);
    favouriteScreenBloc.favouriteStatus.add(false);
    AppLogger.printLog('deleted row id: $id');
    favouriteScreenBloc.getFavouriteDataFromDB();
  }

  num? getCurrentPageNumber() {
    return _pageNumber;
  }

  void setCurrentPageNumber({num? pageNumber}) {
    _pageNumber = pageNumber;
  }

  void onRefresh() async {
    refreshController?.callRefresh();
    cryptoListScreenBloc.setCurrentPageNumber(pageNumber: DEFAULT_START);
    await cryptoListScreenBloc.callCryptoListApi(
        pageNumber: DEFAULT_START, limit: DEFAULT_LIMIT);
    refreshController?.finishRefresh();
  }
}

final cryptoListScreenBloc = CryptoListScreenBloc();
