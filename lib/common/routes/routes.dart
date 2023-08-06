import 'package:crypto_assignment/home/network/model/response/crypto_list_res_model.dart';
import 'package:crypto_assignment/home/view/crypto_detail_screen.dart';
import 'package:crypto_assignment/home/view/home_screen.dart';
import 'package:crypto_assignment/splash_screen/view/splash_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String home_screen = 'home_Screen';
  static const String crypto_detail_screen = 'crypto_detail_screen';
  static const String splash = 'splash';

  static Route<dynamic>? getGeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute<dynamic>(
          settings: const RouteSettings(name: splash),
          builder: (_) => SplashScreen(),
        );

      case home_screen:
        return MaterialPageRoute<dynamic>(
          settings: const RouteSettings(name: home_screen),
          builder: (_) => HomeScreen(),
        );

      case crypto_detail_screen:
        final args = settings.arguments as CryptoModel;
        return MaterialPageRoute<dynamic>(
          settings: const RouteSettings(name: crypto_detail_screen),
          builder: (_) => CryptoDetailsScreen(cryptoModel: args),
        );
/*
      case chat_detail_screen:
        return MaterialPageRoute<dynamic>(
          settings: const RouteSettings(name: chat_detail_screen),
          builder: (_) => ChatDetailScreen(),
        );*/
      default:
        return null;
    }
  }
}
