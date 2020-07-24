import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;
import 'package:scoped_model/scoped_model.dart';


class Localizacao extends Model{

  int idc;
  double latitude;
  double longitude;
  bool validado;

  Localizacao({int idcc,double lat,double long,bool val})
  {
    this.idc = idcc;
    this.latitude = lat;
    this.longitude = long;
    this.validado = val;
  }

  factory Localizacao.fromJson(Map<String,dynamic> json){

    return Localizacao(
      idcc: json['idC'] as int,
      lat: json['latitude'] as double,
      long:json['longitude'] as double,
      val: json['validado'] as bool     
          
    );

  }

  Future<List<Localizacao>> getlocalizacao(int idc) async {
  
  http.Response response = await http.get(
    Uri.encodeFull("http://6f85a52b4f05.ngrok.io/api/Localizacao/"+idc.toString()),
    headers:{
      "Accept":"application/json"
    }
  );

  List lista = json.decode(response.body);

  List<Localizacao> listau = new List<Localizacao>();

  
  for(int i = 0; i < lista.length; i++)
    listau.add(Localizacao.fromJson(lista[i]));
  
  return listau;
}

Future<int> createlocalizacao(Localizacao loc) async {

  var url ='http://6f85a52b4f05.ngrok.io/api/Localizacao';
  var body = json.encode(<String, dynamic>{
      'IdC': loc.idc,
      'Latitude':loc.latitude,
      'Longitude':loc.longitude,
      'Validado':loc.validado


    });


   http.Response response = await http.post(url,
      headers: {"Content-Type": "application/json"},
      body: body
  );

  return response.statusCode;

}

void updateLocalizacao(int idc,String value) async {

  var url ='http://6f85a52b4f05.ngrok.io/api/Localizacao/' + idc.toString();
  var body = json.encode(value);


  http.put(url,
      headers: {"Content-Type": "application/json"},
      body: body
  ).then((http.Response response) {
    

  });
}

}