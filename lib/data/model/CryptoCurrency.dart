class CryptoCurrency {
  String id;
  String name;
  String symbol;
  String rank;
  String price_usd;
  String price_btc;
  String __invalid_name__24h_volume_usd;
  String market_cap_usd;
  String available_supply;
  String total_supply;
  String max_supply;
  String percent_change_1h;
  String percent_change_24h;
  String percent_change_7d;
  String last_updated;

  CryptoCurrency(this.name, this.price_usd, this.percent_change_1h);

  CryptoCurrency.fromMap(Map<String, dynamic> map)
      : name = map["name"],
        price_usd = map["price_usd"],
        percent_change_1h = map["percent_change_1h"];
}
