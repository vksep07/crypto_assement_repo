import 'dart:convert';

import 'package:crypto_assignment/home/network/model/response/crypto_list_res_model.dart';
import 'package:crypto_assignment/main.dart';
import 'package:rxdart/rxdart.dart';

class FavouriteScreenBloc {
  BehaviorSubject<List<CryptoModel>> _favouriteListController =
      BehaviorSubject<List<CryptoModel>>.seeded([]);

  BehaviorSubject<List<CryptoModel>> get favouriteListController =>
      _favouriteListController;

  BehaviorSubject<bool> _favouriteStatus = BehaviorSubject<bool>.seeded(false);

  BehaviorSubject<bool> get favouriteStatus => _favouriteStatus;

  Map<String, CryptoModel> favouritesMap = {};
  List<CryptoModel>? favouriteList = [];

  void getFavouriteDataFromDB({CryptoModel? cryptoModel}) async {
    List<Map> list = await dbHelper.queryAllRows();
    favouriteList!.clear();
    favouritesMap.clear();
    if (list != null && list.isNotEmpty) {
      for (Map map in list) {
        CryptoModel? cryptoModel =
            CryptoModel.fromJson(json.decode(map['columnCryptoData']));
        favouritesMap.putIfAbsent(cryptoModel.id.toString(), () => cryptoModel);
        favouriteList!.add(cryptoModel);
        _favouriteListController.add(favouriteList ?? []);
      }
    } else {
      _favouriteListController.add([]);
    }

    if (cryptoModel != null && favouritesMap.isNotEmpty) {
      var value = favouritesMap['${cryptoModel.id}'];
      if (value != null) {
        _favouriteStatus.add(true);
      } else {
        _favouriteStatus.add(false);
      }
    }
  }
}

final favouriteScreenBloc = FavouriteScreenBloc();
