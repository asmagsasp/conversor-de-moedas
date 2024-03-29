import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request =
    'https://api.hgbrasil.com/finance/quotations?format=json&key=f4e74f48';
//const request = 'https://cardadio-da-ober.firebaseio.com/';

void main() async {
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(hintColor: Colors.amber, primaryColor: Colors.white),
  ));
}

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double dolar;
  double euro;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text("\$ Conversor \$"),
          backgroundColor: Colors.amber,
          centerTitle: true,
        ),
        body: FutureBuilder<Map>(
            future: getData(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(
                      child: Text(
                    "Caregando Dados...",
                    style: TextStyle(color: Colors.amber, fontSize: 25.0),
                    textAlign: TextAlign.center,
                  ));
                default:
                  if (snapshot.hasError) {
                    return Center(
                        child: Text(
                      "Erro Caregando Dados... :(",
                      style: TextStyle(color: Colors.amber, fontSize: 25.0),
                      textAlign: TextAlign.center,
                    ));
                  } else {
                    dolar =
                        snapshot.data["results"]["currencies"]["USD"]["buy"];
                    euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];

                    return SingleChildScrollView(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Icon(Icons.monetization_on,
                              size: 150.0, color: Colors.green),
                          TextField(
                            decoration: InputDecoration(
                                labelText: "Reais",
                                labelStyle: TextStyle(color: Colors.amber),
                                border: OutlineInputBorder(),
                                prefixText: "R\$"),
                            style:
                                TextStyle(color: Colors.amber, fontSize: 25.0),
                          ),
                          Divider(),
                          TextField(
                            decoration: InputDecoration(
                                labelText: "Dólares",
                                labelStyle: TextStyle(color: Colors.amber),
                                border: OutlineInputBorder(),
                                prefixText: "US\$"),
                            style:
                            TextStyle(color: Colors.amber, fontSize: 25.0),
                          ),
                          Divider(),
                          TextField(
                            decoration: InputDecoration(
                                labelText: "Euros",
                                labelStyle: TextStyle(color: Colors.amber),
                                border: OutlineInputBorder(),
                                prefixText: "EU\$"),
                            style:
                            TextStyle(color: Colors.amber, fontSize: 25.0),
                          )
                        ],
                      ),
                    );
                  }
              }
            }));
  }
}
