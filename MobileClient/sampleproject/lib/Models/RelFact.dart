import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;
import 'package:scoped_model/scoped_model.dart';


class RelFact extends Model{

  int idf;
  int idp;
  String tempo;

  RelFact({int idff,int idpp, String time})
  {
    this.idf = idff;
    this.idp = idpp;
    this.tempo = time;
  }

  factory RelFact.fromJson(Map<String,dynamic> json){

    return RelFact(
      idff: json['idF'] as int,
      idpp: json['idP'] as int,
      time: json['tempo'] as String
      
    );

  }

  Future<List<RelFact>> getrelfact() async {
  
  http.Response response = await http.get(
    Uri.encodeFull("http://6f85a52b4f05.ngrok.io/api/RelFact"),
    headers:{
      "Accept":"application/json"
    }
  );

  List lista = json.decode(response.body);

  List<RelFact> listau = new List<RelFact>();

  
  for(int i = 0; i < lista.length; i++)
    listau.add(RelFact.fromJson(lista[i]));
  

  return listau;
}

Future<List<RelFact>> getrelfactidp(int idp) async {
  
  http.Response response = await http.get(
    Uri.encodeFull("http://6f85a52b4f05.ngrok.io/api/RelFact/"+idp.toString()),
    headers:{
      "Accept":"application/json"
    }
  );

  List lista = json.decode(response.body);

  List<RelFact> listau = new List<RelFact>();

  
  for(int i = 0; i < lista.length; i++)
    listau.add(RelFact.fromJson(lista[i]));
  

  return listau;
}

Future<int> createRelFact(List<RelFact> relFact) async {

  var url ='http://6f85a52b4f05.ngrok.io/api/RelFact';

  http.Response response;

  int count = 0;

  for(RelFact i in relFact)
  {
    var element = json.encode(<String, String>{
        'IdF': i.idf.toString(),
        'IdP':i.idp.toString(),
        'Tempo':i.tempo   

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


  if(count == relFact.length)
  {
    return 1;
  }
  else
  {
    return 0;
  }

}



}