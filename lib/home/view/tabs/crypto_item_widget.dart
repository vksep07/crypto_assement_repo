import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_assignment/util/assets.dart';
import 'package:crypto_assignment/util/colors.dart';
import 'package:crypto_assignment/util/common_widgets/app_text_widget.dart';
import 'package:crypto_assignment/util/common_widgets/extensions.dart';
import 'package:flutter/material.dart';

class CryptoItemWidget extends StatelessWidget {
  String? imageUrl;
  String? bitCoinName;
  String? bitCoinValue;
  Function? onClick;

  CryptoItemWidget(
      {this.bitCoinName, this.imageUrl, this.bitCoinValue, this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 2),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: InkWell(
            onTap: () {
              if (onClick != null) {
                this.onClick!();
              }
            },
            child: Container(
              // height: 100,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 15, bottom: 15),
                child: Row(
                  children: [
                    CachedNetworkImage(
                      height: 60,
                      width: 60,
                      fit: BoxFit.fill,
                      //TODO : ADD IMAGE URL WHEN WE GET FROM RESPONSE
                      imageUrl: imageUrl ?? '',
                      errorWidget: (context, url, error) {
                        return Image.asset(
                          Assets.appLogo,
                          fit: BoxFit.cover,
                          color: AppColors.primary,
                        );
                      },
                    ),
                    15.widthBox,
                    AppTextWidget(
                      text: bitCoinName,
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      size: 16,
                    ),
                    Spacer(),
                    AppTextWidget(
                      text: bitCoinValue,
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      size: 16,
                    ),
                    10.widthBox
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
