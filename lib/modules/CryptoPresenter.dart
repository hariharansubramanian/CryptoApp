import 'package:crypto_app/DependencyInjection.dart';
import 'package:crypto_app/data/model/CryptoCurrency.dart';
import 'package:crypto_app/data/repositories/CryptoRepository.dart';

abstract class CryptoListViewContract {
  void onLoadCryptoDownloadComplete(List<CryptoCurrency> currencies);

  void onLoadCryptoDownloadError();
}

class CryptoListPresenter {
  CryptoListViewContract _view;
  CryptoRepository _repository;

  CryptoListPresenter(this._view) {
    _repository = new Injector().cryptoRepository;
  }

  void loadCurrencies() {
    _repository
        .fetchCurrencies()
        .then((c) => _view.onLoadCryptoDownloadComplete(c))
        .catchError((onError) => _view.onLoadCryptoDownloadError());
  }
}
