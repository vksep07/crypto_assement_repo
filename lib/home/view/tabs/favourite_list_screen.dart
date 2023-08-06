import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_assignment/common/routes/routes.dart';
import 'package:crypto_assignment/common/services/navigation_service.dart';
import 'package:crypto_assignment/home/bloc/crypto_list_screen_bloc.dart';
import 'package:crypto_assignment/home/bloc/favourte_screen_bloc.dart';
import 'package:crypto_assignment/home/bloc/home_screen_bloc.dart';
import 'package:crypto_assignment/home/network/model/response/crypto_list_res_model.dart';
import 'package:crypto_assignment/home/view/tabs/crypto_item_widget.dart';
import 'package:crypto_assignment/home/view/tabs/crypto_list_screen.dart';
import 'package:crypto_assignment/util/assets.dart';
import 'package:crypto_assignment/util/colors.dart';
import 'package:crypto_assignment/util/common_widgets/app_text_widget.dart';
import 'package:crypto_assignment/util/common_widgets/default_loading.dart';
import 'package:crypto_assignment/util/common_widgets/extensions.dart';
import 'package:crypto_assignment/util/constants.dart';
import 'package:crypto_assignment/util/string_constant.dart';
import 'package:crypto_assignment/util/toast_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FavouriteListScreen extends StatefulWidget {
  const FavouriteListScreen({Key? key}) : super(key: key);

  @override
  _FavouriteListScreenState createState() => _FavouriteListScreenState();
}

class _FavouriteListScreenState extends State<FavouriteListScreen> {



  @override
  void initState() {
    super.initState();
   favouriteScreenBloc.getFavouriteDataFromDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: favouriteScreenBloc.favouriteListController,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              if (snapshot.data!.isNotEmpty) {
                return ListView.builder(
                    itemCount: snapshot.data!.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      CryptoModel cryptoModel = snapshot.data![index];
                      final price = double.parse(
                          cryptoModel.quote!.usd!.price.toString());
                      final priceString = price.toStringAsFixed(2);
                      return CryptoItemWidget(
                        bitCoinName: cryptoModel.name,
                        bitCoinValue: priceString,
                        imageUrl: cryptoListScreenBloc.getBitCoinImageUrl(
                            imageId: cryptoModel.id.toString()),
                        onClick: () {
                          appNavigationService.pushNamed(
                              Routes.crypto_detail_screen,
                              arguments: cryptoModel);
                        },
                      );
                    });
              } else {
                return Center(child:  AppTextWidget(
                  text: stringConstant.no_data_found,
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  size: 18,
                ),);
              }
            } else {
              return DefaultLoading();
            }
          },
        ),
      ),
    );
  }


}

