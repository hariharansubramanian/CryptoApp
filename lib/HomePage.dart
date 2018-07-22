import 'package:crypto_app/data/model/CryptoCurrency.dart';
import 'package:crypto_app/modules/CryptoPresenter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> implements CryptoListViewContract {
  CryptoListPresenter _presenter;
  List<CryptoCurrency> _currencies;
  bool _isLoading;

  final List<MaterialColor> _colors = [Colors.blue, Colors.indigo, Colors.red];

  _HomePageState() {
    _presenter = new CryptoListPresenter(this);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLoading = true;
    _presenter.loadCurrencies();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Crypto App"),
        elevation: defaultTargetPlatform == TargetPlatform.iOS ? 0.5 : 0.0,
      ),
      body: _isLoading
          ? new Center(
              child: new CircularProgressIndicator(),
            )
          : _cryptoWidget(),
    );
  }

  Widget _cryptoWidget() {
    return new Container(
      child: Column(
        children: <Widget>[
          new Flexible(
              child: new ListView.builder(
            itemCount: _currencies.length,
            itemBuilder: (BuildContext context, int index) {
              final CryptoCurrency currency = _currencies[index];
              final MaterialColor color = _colors[index % _colors.length];

              return _getListItemUI(currency, color);
            },
          ))
        ],
      ),
    );
  }

  ListTile _getListItemUI(CryptoCurrency currency, MaterialColor color) {
    return new ListTile(
      leading: new CircleAvatar(
        backgroundColor: color,
        child: new Text(currency.name[0]),
      ),
      title: new Text(currency.name),
      subtitle:
          _getSubtitleText(currency.price_usd, currency.percent_change_1h),
      isThreeLine: true,

//        style: new TextStyle(fontWeight: FontWeight.bold)
    );
  }

  Widget _getSubtitleText(String priceUSD, String percentageChange) {
    TextSpan priceTextWidget = new TextSpan(
        text: "\$$priceUSD\n", style: new TextStyle(color: Colors.black));

    String percentageChangeText = "1 hour: $percentageChange%";
    TextSpan percentageChangeTextWidget;

    if (double.parse(percentageChange) > 0) {
      percentageChangeTextWidget = new TextSpan(
          text: percentageChangeText,
          style: new TextStyle(color: Colors.green));
    } else {
      percentageChangeTextWidget = new TextSpan(
          text: percentageChangeText, style: new TextStyle(color: Colors.red));
    }
    return new RichText(
        text: new TextSpan(
            children: [priceTextWidget, percentageChangeTextWidget]));
  }

  @override
  void onLoadCryptoDownloadComplete(List<CryptoCurrency> currencies) {
    // TODO: implement onLoadCryptoDownloadComplete

    setState(() {
      _currencies = currencies;
      _isLoading = false;
    });
  }

  @override
  void onLoadCryptoDownloadError() {
    // TODO: implement onLoadCryptoDownloadError
  }
}
