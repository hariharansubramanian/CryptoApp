import 'package:crypto_app/data/repositories/CryptoRepository.dart';
import 'package:crypto_app/data/repositories/CryptoRepositoryMock.dart';
import 'package:crypto_app/data/repositories/ICryptoRepository.dart';

enum Flavor { MOCK, PROD }

class Injector {
  static final Injector _singleton = new Injector._internal();
  static Flavor _flavor;

  static void configure(Flavor flavor) {
    _flavor = flavor;
  }

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  ICryptoRepository get cryptoRepository {
    switch (_flavor) {
      case Flavor.MOCK:
        return new CryptoRepositoryMock();
      default:
        return new CryptoRepository();
    }
  }
}
