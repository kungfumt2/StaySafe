import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;
import 'package:scoped_model/scoped_model.dart';


class MainViewConnection extends Model{

  int ninfet;
  int nrisco;
  int nninft;
  int nimunes;


  MainViewConnection({int ninf, int nrisc, int nnif, int nimunees})
  {
    this.ninfet = ninf;

  }

  

  Future<MainViewConnection> getdadoslocal(int iduser) async {

  var url ='http://6f85a52b4f05.ngrok.io/api/MainView';
  var body = json.encode(iduser.toString());



   http.Response response = await http.post(url,
      headers: {"Content-Type": "application/json"},
      body: body
  );

  MainViewConnection data = new MainViewConnection();

  data.ninfet = int.parse(json.decode(response.body)["ninfet"]);
  data.nrisco = int.parse(json.decode(response.body)["nrisco"]);
  data.nninft = int.parse(json.decode(response.body)["nninft"]);
  data.nimunes = int.parse(json.decode(response.body)["nimunes"]);

  return data;

}

}