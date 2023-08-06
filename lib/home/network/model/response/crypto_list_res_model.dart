// To parse this JSON data, do
//
//     final cryptoListResModel = cryptoListResModelFromJson(jsonString);

import 'dart:convert';

CryptoListResModel cryptoListResModelFromJson(String str) => CryptoListResModel.fromJson(json.decode(str));

String cryptoListResModelToJson(CryptoListResModel data) => json.encode(data.toJson());

class CryptoListResModel {
  Status? status;
  List<CryptoModel>? data;

  CryptoListResModel({
    this.status,
    this.data,
  });

  factory CryptoListResModel.fromJson(Map<String, dynamic> json) => CryptoListResModel(
    status: json["status"] == null ? null : Status.fromJson(json["status"]),
    data: json["data"] == null ? [] : List<CryptoModel>.from(json["data"]!.map((x) => CryptoModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status?.toJson(),
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class CryptoModel {
  int? id;
  String? name;
  String? symbol;
  String? slug;
  int? numMarketPairs;
  List<String>? tags;
  double? maxSupply;
  double? circulatingSupply;
  double? totalSupply;
  bool? infiniteSupply;
  Platform? platform;
  int? cmcRank;
  double? selfReportedCirculatingSupply;
  double? selfReportedMarketCap;
  double? tvlRatio;
  Quote? quote;

  CryptoModel({
    this.id,
    this.name,
    this.symbol,
    this.slug,
    this.numMarketPairs,
    this.tags,
    this.maxSupply,
    this.circulatingSupply,
    this.totalSupply,
    this.infiniteSupply,
    this.platform,
    this.cmcRank,
    this.selfReportedCirculatingSupply,
    this.selfReportedMarketCap,
    this.tvlRatio,
    this.quote,
  });

  factory CryptoModel.fromJson(Map<String, dynamic> json) => CryptoModel(
    id: json["id"],
    name: json["name"],
    symbol: json["symbol"],
    slug: json["slug"],
    numMarketPairs: json["num_market_pairs"],
    tags: json["tags"] == null ? [] : List<String>.from(json["tags"]!.map((x) => x)),
    maxSupply: json["max_supply"]?.toDouble(),
    circulatingSupply: json["circulating_supply"]?.toDouble(),
    totalSupply: json["total_supply"]?.toDouble(),
    infiniteSupply: json["infinite_supply"],
    platform: json["platform"] == null ? null : Platform.fromJson(json["platform"]),
    cmcRank: json["cmc_rank"],
    selfReportedCirculatingSupply: json["self_reported_circulating_supply"]?.toDouble(),
    selfReportedMarketCap: json["self_reported_market_cap"]?.toDouble(),
    tvlRatio: json["tvl_ratio"]?.toDouble(),
    quote: json["quote"] == null ? null : Quote.fromJson(json["quote"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "symbol": symbol,
    "slug": slug,
    "num_market_pairs": numMarketPairs,
    "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
    "max_supply": maxSupply,
    "circulating_supply": circulatingSupply,
    "total_supply": totalSupply,
    "infinite_supply": infiniteSupply,
    "platform": platform?.toJson(),
    "cmc_rank": cmcRank,
    "self_reported_circulating_supply": selfReportedCirculatingSupply,
    "self_reported_market_cap": selfReportedMarketCap,
    "tvl_ratio": tvlRatio,
    "quote": quote?.toJson(),
  };
}

class Platform {
  int? id;
  String? name;
  String? symbol;
  String? slug;
  String? tokenAddress;

  Platform({
    this.id,
    this.name,
    this.symbol,
    this.slug,
    this.tokenAddress,
  });

  factory Platform.fromJson(Map<String, dynamic> json) => Platform(
    id: json["id"],
    name: json["name"],
    symbol: json["symbol"],
    slug: json["slug"],
    tokenAddress: json["token_address"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "symbol": symbol,
    "slug": slug,
    "token_address": tokenAddress,
  };
}

class Quote {
  Usd? usd;

  Quote({
    this.usd,
  });

  factory Quote.fromJson(Map<String, dynamic> json) => Quote(
    usd: json["USD"] == null ? null : Usd.fromJson(json["USD"]),
  );

  Map<String, dynamic> toJson() => {
    "USD": usd?.toJson(),
  };
}

class Usd {
  double? price;
  double? volume24H;
  double? volumeChange24H;
  double? percentChange1H;
  double? percentChange24H;
  double? percentChange7D;
  double? percentChange30D;
  double? percentChange60D;
  double? percentChange90D;
  double? marketCap;
  double? marketCapDominance;
  double? fullyDilutedMarketCap;
  double? tvl;

  Usd({
    this.price,
    this.volume24H,
    this.volumeChange24H,
    this.percentChange1H,
    this.percentChange24H,
    this.percentChange7D,
    this.percentChange30D,
    this.percentChange60D,
    this.percentChange90D,
    this.marketCap,
    this.marketCapDominance,
    this.fullyDilutedMarketCap,
    this.tvl,
  });

  factory Usd.fromJson(Map<String, dynamic> json) => Usd(
    price: json["price"]?.toDouble(),
    volume24H: json["volume_24h"]?.toDouble(),
    volumeChange24H: json["volume_change_24h"]?.toDouble(),
    percentChange1H: json["percent_change_1h"]?.toDouble(),
    percentChange24H: json["percent_change_24h"]?.toDouble(),
    percentChange7D: json["percent_change_7d"]?.toDouble(),
    percentChange30D: json["percent_change_30d"]?.toDouble(),
    percentChange60D: json["percent_change_60d"]?.toDouble(),
    percentChange90D: json["percent_change_90d"]?.toDouble(),
    marketCap: json["market_cap"]?.toDouble(),
    marketCapDominance: json["market_cap_dominance"]?.toDouble(),
    fullyDilutedMarketCap: json["fully_diluted_market_cap"]?.toDouble(),
    tvl: json["tvl"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "price": price,
    "volume_24h": volume24H,
    "volume_change_24h": volumeChange24H,
    "percent_change_1h": percentChange1H,
    "percent_change_24h": percentChange24H,
    "percent_change_7d": percentChange7D,
    "percent_change_30d": percentChange30D,
    "percent_change_60d": percentChange60D,
    "percent_change_90d": percentChange90D,
    "market_cap": marketCap,
    "market_cap_dominance": marketCapDominance,
    "fully_diluted_market_cap": fullyDilutedMarketCap,
    "tvl": tvl,
  };
}

class Status {
  DateTime? timestamp;
  int? errorCode;
  dynamic errorMessage;
  int? elapsed;
  int? creditCount;
  dynamic notice;
  int? totalCount;

  Status({
    this.timestamp,
    this.errorCode,
    this.errorMessage,
    this.elapsed,
    this.creditCount,
    this.notice,
    this.totalCount,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
    timestamp: json["timestamp"] == null ? null : DateTime.parse(json["timestamp"]),
    errorCode: json["error_code"],
    errorMessage: json["error_message"],
    elapsed: json["elapsed"],
    creditCount: json["credit_count"],
    notice: json["notice"],
    totalCount: json["total_count"],
  );

  Map<String, dynamic> toJson() => {
    "timestamp": timestamp?.toIso8601String(),
    "error_code": errorCode,
    "error_message": errorMessage,
    "elapsed": elapsed,
    "credit_count": creditCount,
    "notice": notice,
    "total_count": totalCount,
  };
}
