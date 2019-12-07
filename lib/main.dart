import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HelloFriend(),
    );
  }
}

class HelloFriend extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _helloFriendState();
}

class _helloFriendState extends State<HelloFriend> {
  final double _formdistance = 5.0;
  String result = '';
  final _currencies = ['Birr', 'Dollars', 'Euro', 'Pounds'];
  String _currency = 'Birr';
  TextEditingController distanceController = TextEditingController();
  TextEditingController avgController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      appBar: AppBar(
        title: Text('hello world'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  top: _formdistance,
                  bottom: _formdistance,
                ),
                child: TextField(
                  controller: distanceController,
                  decoration: InputDecoration(
                    labelText: 'Distance',
                    hintText: 'e.g. 123 ',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: _formdistance,
                  bottom: _formdistance,
                ),
                child: TextField(
                  controller: avgController,
                  decoration: InputDecoration(
                    labelText: 'Distance per Unit',
                    hintText: 'e.g. 19 ',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: _formdistance,
                  bottom: _formdistance,
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: priceController,
                        decoration: InputDecoration(
                          labelText: 'Price',
                          hintText: 'e.g. 1.65 ',
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Container(width: _formdistance * 5),
                    Expanded(
                      child: DropdownButton<String>(
                        items: _currencies.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        value: _currency,
                        onChanged: (String value) {
                          _onDropdownChanged(value);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'submit',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        setState(() {
                          _calculate();
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).buttonColor,
                      textColor: Theme.of(context).primaryColorDark,
                      child: Text(
                        'reset',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        setState(() {
                          _reset();
                        });
                      },
                    ),
                  ),
                ],
              ),
              Text(result),
            ],
          )),
    );
  }

  void _onDropdownChanged(String value) {
    setState(() {
      this._currency = value;
    });
  }

  _calculate() {
    double _Distance = double.parse(distanceController.text);
    double _fuelCost = double.parse(priceController.text);
    double _consumption = double.parse(avgController.text);
    double _totalCost = _Distance / _consumption * _fuelCost;
    String _result =
        'The Total Cost for your trip is ${_totalCost.toStringAsFixed(2)} $_currency';
    return _result;
  }

  void _reset() {
    distanceController.text = '';
    avgController.text = '';
    priceController.text = '';
    setState(() {
      result = '';
    });
  }
}
