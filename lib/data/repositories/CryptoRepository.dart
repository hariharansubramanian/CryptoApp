import 'dart:async';
import 'dart:convert';
import 'package:crypto_app/data/exceptions/FetchDataException.dart';
import 'package:http/http.dart' as http;
import 'package:crypto_app/data/model/CryptoCurrency.dart';
import 'package:crypto_app/data/repositories/ICryptoRepository.dart';

class CryptoRepository implements ICryptoRepository {
  String cryptoUrl = "https://api.coinmarketcap.com/v1/ticker/?limit=50";

  @override
  Future<List<CryptoCurrency>> fetchCurrencies() async {
    http.Response response = await http.get(cryptoUrl);
    final List responseBody = JSON.decode(response.body);
    final statusCode = response.statusCode;

    if (statusCode != 200 || responseBody == null) {
      throw new FetchDataException(
          "Error Fetching Data: [Status Code : $statusCode]");
    }
    return responseBody.map((c) => new CryptoCurrency.fromMap(c)).toList();
  }
}
