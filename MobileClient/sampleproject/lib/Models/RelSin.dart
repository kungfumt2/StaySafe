import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;
import 'package:scoped_model/scoped_model.dart';


class RelSin extends Model{

  int idp;
  int ids;
  DateTime datasintoma;

  RelSin({int idpp,int idss,DateTime ds})
  {
    this.idp = idpp;
    this.ids = idss;
    this.datasintoma = ds;
  }

  factory RelSin.fromJson(Map<String,dynamic> json){

    return RelSin(
      idpp: json['idP'] as int,
      idss: json['idS'] as int,
      ds:DateTime.parse(json['dataSintoma'])
      
    );

  }

  Future<List<RelSin>> getrelsin() async {
  
  http.Response response = await http.get(
    Uri.encodeFull("http://6f85a52b4f05.ngrok.io/api/RelSin"),
    headers:{
      "Accept":"application/json"
    }
  );

  List lista = json.decode(response.body);

  List<RelSin> listau = new List<RelSin>();

  
  for(int i = 0; i < lista.length; i++)
    listau.add(RelSin.fromJson(lista[i]));
  

  return listau;
}

Future<List<RelSin>> getrelsinidp(int idp) async {
  
  http.Response response = await http.get(
    Uri.encodeFull("http://6f85a52b4f05.ngrok.io/api/RelSin/"+idp.toString()),
    headers:{
      "Accept":"application/json"
    }
  );

  List lista = json.decode(response.body);

  List<RelSin> listau = new List<RelSin>();

  
  for(int i = 0; i < lista.length; i++)
    listau.add(RelSin.fromJson(lista[i]));
  

  return listau;
}

Future<int> createRelSin(List<RelSin> relSin) async {

  var url ='http://6f85a52b4f05.ngrok.io/api/RelSin';

   http.Response response;

   int count = 0;

  for(RelSin i in relSin)
  {
    var element = json.encode(<String, String>{
        'IdP': i.idp.toString(),
        'IdS':i.ids.toString(),
        'DataSintoma':i.datasintoma.toString()    

      });


      response = await http.post(url,
      headers: {"Content-Type": "application/json"},
      body: element
  );

  if(response.statusCode == 200)
  {
    count++;
  }

  }

  if(count == relSin.length)
  {
    return 1;
  }
  else
  {
    return 0;
  }
}

}