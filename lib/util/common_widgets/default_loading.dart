import 'package:crypto_assignment/util/assets.dart';
import 'package:crypto_assignment/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DefaultLoading extends StatelessWidget {
  const DefaultLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
          child: Stack(
        children: [
          Center(
            child: SizedBox(
              height: 80,
              width: 80,
              child: CircularProgressIndicator(
                backgroundColor: AppColors.primary,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.lightGrey),
              ),
            ),
          ),
          Center(
            child: SizedBox(
                height: 50,
                width: 50,
                child: Image.asset(
                  Assets.appLogo,
                  fit: BoxFit.contain,
                  color: AppColors.primary.withOpacity(0.9),
                )),
          ),
        ],
      )),
    );
  }
}
