import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  final List _currencies;

  HomePage(this._currencies);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<MaterialColor> _colors = [Colors.blue, Colors.indigo, Colors.red];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Crypto App"),
      ),
      body: _cryptoWidget(),
    );
  }

  Widget _cryptoWidget() {
    return new Container(
      child: Column(
        children: <Widget>[
          new Flexible(
              child: new ListView.builder(
            itemCount: widget._currencies.length,
            itemBuilder: (BuildContext context, int index) {
              final Map currency = widget._currencies[index];
              final MaterialColor color = _colors[index % _colors.length];

              return _getListItemUI(currency, color);
            },
          )
          )
        ],
      ),
    );
  }

  ListTile _getListItemUI(Map currency, MaterialColor color) {
    return new ListTile(
      leading: new CircleAvatar(
        backgroundColor: color,
        child: new Text(currency['name'][0]),
      ),
      title: new Text(currency['name']),
      subtitle: _getSubtitleText(
          currency['price_usd'], currency['percent_change_1h']),
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
}
