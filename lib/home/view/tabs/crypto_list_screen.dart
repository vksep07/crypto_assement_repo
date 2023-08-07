import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_assignment/common/routes/routes.dart';
import 'package:crypto_assignment/common/services/navigation_service.dart';
import 'package:crypto_assignment/home/bloc/crypto_list_screen_bloc.dart';
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
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({Key? key}) : super(key: key);

  @override
  _CryptoListScreenState createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  final ScrollController _scrollController = ScrollController();
  double _lastPosition = 0;

  @override
  void initState() {
    super.initState();
    cryptoListScreenBloc.cryptoModelListController.add([]);
    cryptoListScreenBloc.setCurrentPageNumber(pageNumber: DEFAULT_START);
    cryptoListScreenBloc.callCryptoListApi(
        pageNumber: DEFAULT_START, limit: DEFAULT_LIMIT);
    _scrollController.addListener(checkForEnd);
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
        stream: cryptoListScreenBloc.loadingController,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null && !snapshot.data!) {
            return  EasyRefresh(
                header: MaterialHeader(
                  color: AppColors.primary,
                ),
                controller: cryptoListScreenBloc.refreshController,
                onRefresh: () {
                  cryptoListScreenBloc.onRefresh();
                },
                child:  Column(
                  children: [
                    Expanded(
                      child: StreamBuilder(
                        stream: cryptoListScreenBloc.cryptoModelListController,
                        builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.data != null) {
                            if (snapshot.data!.isNotEmpty) {
                              return  ListView.builder(
                                  controller: _scrollController,
                                  //  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.length ?? 0,
                                  itemBuilder: (BuildContext context, int index) {
                                    CryptoModel cryptoModel = snapshot.data![index];
                                    final price = double.parse(
                                        cryptoModel.quote!.usd!.price.toString());
                                    final priceString = price.toStringAsFixed(2);
                                    return CryptoItemWidget(
                                      bitCoinName: cryptoModel.name,
                                      bitCoinValue: priceString,
                                      imageUrl:
                                      cryptoListScreenBloc.getBitCoinImageUrl(
                                          imageId: cryptoModel.id.toString()),
                                      onClick: () {
                                        appNavigationService.pushNamed(
                                            Routes.crypto_detail_screen,
                                            arguments: cryptoModel);
                                      },
                                    );
                                  });
                            } else {
                              return Center(
                                child: AppTextWidget(
                                  text: stringConstant.no_data_found,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                  size: 18,
                                ),
                              );
                            }
                          } else {
                            return DefaultLoading();
                          }
                        },
                      ),
                    ),
                    StreamBuilder<bool>(
                        stream: cryptoListScreenBloc.loadMoreController,
                        builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.data!) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primary,
                              ),
                            );
                          }

                          return SizedBox();
                        }),
                  ],
                ));

          }

          return DefaultLoading();
        },
      )),
    );
  }

  checkForEnd() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _scrollController.keepScrollOffset;
      _lastPosition = _scrollController.position.pixels;

      cryptoListScreenBloc.callCryptoListApi(
        pageNumber: cryptoListScreenBloc.getCurrentPageNumber()!,
        limit: DEFAULT_LIMIT,
      );
      moveToLastIndex();
    }
  }

  moveToLastIndex() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _lastPosition,
        duration: Duration(milliseconds: 1000),
        curve: Curves.easeInOut,
      );
    });
  }
}
