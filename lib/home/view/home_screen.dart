import 'package:crypto_assignment/common/logger/app_logger.dart';
import 'package:crypto_assignment/home/bloc/home_screen_bloc.dart';
import 'package:crypto_assignment/home/view/tabs/crypto_list_screen.dart';
import 'package:crypto_assignment/home/view/tabs/favourite_list_screen.dart';
import 'package:crypto_assignment/util/colors.dart';
import 'package:crypto_assignment/util/common_widgets/app_text_widget.dart';
import 'package:crypto_assignment/util/common_widgets/extensions.dart';
import 'package:crypto_assignment/util/constants.dart';
import 'package:crypto_assignment/util/string_constant.dart';
import 'package:crypto_assignment/util/toast_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
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
        child: StreamBuilder<int>(
          stream: homeScreenBloc.bottomNavIndexController,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              if (snapshot.data == bottomNavigationBarHome) {
                return CryptoListScreen();
              } else if (snapshot.data == bottomNavigationBarFavourites) {
                return FavouriteListScreen();
              }
            } else {
              return CryptoListScreen();
            }
            return CryptoListScreen();
          },
        ),
      ),
      bottomNavigationBar: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        child: BottomAppBar(
          child: StreamBuilder<int>(
              stream: homeScreenBloc.bottomNavIndexController,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  int? navIndex = snapshot.data;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            getBottomBarItemLayout(
                                title: homeScreenBloc
                                    .navigationBarItems[bottomNavigationBarHome]
                                    .name,
                                icon: homeScreenBloc
                                    .navigationBarItems[bottomNavigationBarHome]
                                    .selectedIcondata,
                                isSelected: navIndex == bottomNavigationBarHome
                                    ? true
                                    : false,
                                navigationBarIndex: bottomNavigationBarHome),
                            getBottomBarItemLayout(
                                title: homeScreenBloc
                                    .navigationBarItems[
                                        bottomNavigationBarFavourites]
                                    .name,
                                icon: homeScreenBloc
                                    .navigationBarItems[
                                        bottomNavigationBarFavourites]
                                    .selectedIcondata,
                                isSelected:
                                    navIndex == bottomNavigationBarFavourites
                                        ? true
                                        : false,
                                navigationBarIndex:
                                    bottomNavigationBarFavourites),
                          ]),
                    ],
                  );
                }
                return SizedBox();
              }),
        ),
      ),
    );
  }

  getBottomBarItemLayout(
      {String? title,
      IconData? icon,
      bool? isSelected,
      String? imagePath,
      int? navigationBarIndex}) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: () {
          homeScreenBloc.setBottomNavIndex(botNavIndex: navigationBarIndex);
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            12.heightBox,
            Icon(icon ?? Icons.home_outlined,
                color: isSelected! ? AppColors.primary : AppColors.lightGrey,
                size: 24),
            5.heightBox,
            AppTextWidget(
              text: title ?? '',
              color: (() {
                if (isSelected ?? false) {
                  return AppColors.primary;
                }
                return AppColors.lightGrey;
              }()),
              fontWeight: FontWeight.bold,
              size: 12,
            ),
            10.heightBox,
          ],
        ),
      ),
    );
  }
}
