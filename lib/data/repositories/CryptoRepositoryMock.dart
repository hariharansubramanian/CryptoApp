import 'dart:async';

import 'package:crypto_app/data/model/CryptoCurrency.dart';
import 'package:crypto_app/data/repositories/ICryptoRepository.dart';

class CryptoRepositoryMock implements ICryptoRepository {
  @override
  Future<List<CryptoCurrency>> fetchCurrencies() {
    return new Future.value(currencies);
  }
}

var currencies = <CryptoCurrency>[
  new CryptoCurrency("Bitcoin", "800.60", "-0.7"),
  new CryptoCurrency("Etherium", "6750.00", "0.5"),
  new CryptoCurrency("Ripple", "300.60", "-0.25"),
];