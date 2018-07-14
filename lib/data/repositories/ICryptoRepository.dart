import 'dart:async';
import 'package:crypto_app/data/model/CryptoCurrency.dart';

abstract class ICryptoRepository {
  Future<List<CryptoCurrency>> fetchCurrencies();
}

