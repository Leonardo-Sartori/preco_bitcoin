import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _preco = "0";

  _atualizaValor() async {
     String url = "https://blockchain.info/ticker";
     http.Response response = await http.get(url);

     Map<String, dynamic> retorno = json.decode(response.body);
     print(retorno["BRL"]["buy"].toString());
     setState(() {
      _preco = retorno["BRL"]["buy"].toString().replaceAll(".", ","); 
     });
  }

  @override    
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("images/bitcoin.png"),
            Padding(
              padding: EdgeInsets.only(top: 30, bottom: 30),
              child: Column(
                children: <Widget>[ 
                  Text(
                    "R\$ " + _preco,
                    style: TextStyle(
                      fontSize: 35,
                    ),
                    textAlign: TextAlign.center,  
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    child: Text(
                      "Atualizar",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    color: Colors.orange,
                    padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                    onPressed: _atualizaValor,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
