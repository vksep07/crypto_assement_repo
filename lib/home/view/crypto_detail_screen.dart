import 'package:crypto_assignment/home/bloc/crypto_list_screen_bloc.dart';
import 'package:crypto_assignment/home/bloc/favourte_screen_bloc.dart';
import 'package:crypto_assignment/home/network/model/response/crypto_list_res_model.dart';
import 'package:crypto_assignment/util/colors.dart';
import 'package:crypto_assignment/util/string_constant.dart';
import 'package:flutter/material.dart';

class CryptoDetailsScreen extends StatefulWidget {
  final CryptoModel cryptoModel;

  CryptoDetailsScreen({required this.cryptoModel});

  @override
  State<CryptoDetailsScreen> createState() => _CryptoDetailsScreenState();
}

class _CryptoDetailsScreenState extends State<CryptoDetailsScreen> {
  @override
  void initState() {
    super.initState();
    favouriteScreenBloc.getFavouriteDataFromDB(cryptoModel: widget.cryptoModel);
  }

  @override
  Widget build(BuildContext context) {
    final price = double.parse(widget.cryptoModel.quote!.usd!.price.toString());
    final priceString = price.toStringAsFixed(2);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.cryptoModel.name ?? ''),
            StreamBuilder(
              stream: favouriteScreenBloc.favouriteStatus,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!) {
                  return IconButton(
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      cryptoListScreenBloc.deleteFavouriteInDB(
                          cryptoModel:widget.cryptoModel);
                    },
                  );
                } else {
                  return IconButton(
                    icon: const Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      cryptoListScreenBloc.addFavouriteInDB(
                          cryptoModel: widget.cryptoModel);
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
      body: Card(
        elevation: 0.0,
        color: Colors.transparent,
        child: Column(
          children: [
            ListTile(
              leading: Image.network(
                '${cryptoListScreenBloc.getBitCoinImageUrl(imageId: widget.cryptoModel.id.toString())}',
                height: 40.0,
                width: 40.0,
              ),
              title: Text(
                widget.cryptoModel.name ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
              trailing: Text(
                '\$$priceString',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              title: Text(
                widget.cryptoModel.symbol ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
              subtitle: Text(
                widget.cryptoModel.slug ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
            ),
            ListTile(
              title:  Text(
                stringConstant.market_cap,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
              subtitle: Text(
                '\$${widget.cryptoModel.quote!.usd!.marketCap!.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
            ),
            ListTile(
              title:  Text(
                stringConstant.volume_24h,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
              subtitle: Text(
                '\$${widget.cryptoModel.quote!.usd!.volume24H!.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
            ),
            ListTile(
              title:  Text(
                stringConstant.poercent_change_24h,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
              subtitle: Text(
                '${widget.cryptoModel.quote!.usd!.percentChange24H!.toStringAsFixed(2)}%',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
            ),
            ListTile(
              title:  Text(
                stringConstant.percent_change_7d,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
              subtitle: Text(
                '${widget.cryptoModel.quote!.usd!.percentChange7D!.toStringAsFixed(2)}%',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
            ),
            ListTile(
              title:  Text(
                stringConstant.percent_change_30d,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
              subtitle: Text(
                '${widget.cryptoModel.quote!.usd!.percentChange30D!.toStringAsFixed(2)}%',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
            ),
            ListTile(
              title:  Text(
                stringConstant.percent_change_60d,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
              subtitle: Text(
                '${widget.cryptoModel.quote!.usd!.percentChange60D!.toStringAsFixed(2)}%',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
            ),
            //display future data
          ],
        ),
      ),
    );
  }
}
