import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;
import 'package:scoped_model/scoped_model.dart';

class RelCons extends Model{

  DateTime datarel;
  int idu;
  int idc;

  RelCons({DateTime datarele,int iduu,int idcc})
  {
    this.datarel = datarele;
    this.idu = iduu;
    this.idc = idcc;
  }

  factory RelCons.fromJson(Map<String,dynamic> json){

    return RelCons(
      datarele:DateTime.parse(json['DataRel']),
      iduu: json['idU'] as int,
      idcc: json['idC'] as int
      
    );

  }

  Future<List<RelCons>> getrelcons() async {
  
  http.Response response = await http.get(
    Uri.encodeFull("http://6f85a52b4f05.ngrok.io/api/RelCons"),
    headers:{
      "Accept":"application/json"
    }
  );

  List lista = json.decode(response.body);

  List<RelCons> listau = new List<RelCons>();

  
  for(int i = 0; i < lista.length; i++)
    listau.add(RelCons.fromJson(lista[i]));
  

  return listau;
}

Future<List<RelCons>> getrelconsidu(int idu) async {
  
  http.Response response = await http.get(
    Uri.encodeFull("http://6f85a52b4f05.ngrok.io/api/RelCons/"+idu.toString()),
    headers:{
      "Accept":"application/json"
    }
  );

  List lista = json.decode(response.body);

  List<RelCons> listau = new List<RelCons>();

  
  for(int i = 0; i < lista.length; i++)
    listau.add(RelCons.fromJson(lista[i]));
  

  return listau;
}

Future<int> createRelCons(RelCons relCons) async {

  var url ='http://6f85a52b4f05.ngrok.io/api/RelCons';
  var body = json.encode(<String, String>{
      'DataRel': relCons.datarel.toString(),
      'IdU':relCons.idu.toString(),
      'IdC':relCons.idc.toString()
      
    });

  print(body);



   http.Response response = await http.post(url,
      headers: {"Content-Type": "application/json"},
      body: body
  );

  return response.statusCode;
}

}