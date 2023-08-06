import 'package:crypto_assignment/home/network/model/bottom_bar_model.dart';
import 'package:crypto_assignment/util/string_constant.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class HomeScreenBloc {
  BehaviorSubject<int> _bottomNavIndexController =
      BehaviorSubject<int>.seeded(0);

  BehaviorSubject<int> get bottomNavIndexController =>
      _bottomNavIndexController;

  List<BottomBarModel> navigationBarItems = [
    BottomBarModel(
        index: 0,
        name: '${stringConstant.current_cryptocurrencies}',
        selectedIcondata: Icons. currency_bitcoin,
        unSelectedIcon: Icons.currency_bitcoin),
    BottomBarModel(
        index: 1,
        name: '${stringConstant.favourites}',
        selectedIcondata: Icons.favorite_outlined,
        unSelectedIcon: Icons.favorite_outlined),


  ];

  void setBottomNavIndex({int? botNavIndex}) {
    bottomNavIndexController.add(botNavIndex!);
  }
}

final homeScreenBloc = HomeScreenBloc();
