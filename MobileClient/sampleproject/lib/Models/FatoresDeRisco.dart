import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;
import 'package:scoped_model/scoped_model.dart';


class FatoresDeRisco extends Model{

  int id;
  String fator;

  FatoresDeRisco({int idd,String fatoor})
  {
    this.id = idd;
    this.fator = fatoor;
  }

  factory FatoresDeRisco.fromJson(Map<String,dynamic> json){

    return FatoresDeRisco(
      idd: json['id'] as int,
      fatoor: json['fator'] as String
          
    );

  }

   Future<List<FatoresDeRisco>> getfatoresderisco() async {
  
  http.Response response = await http.get(
    Uri.encodeFull("http://6f85a52b4f05.ngrok.io/api/FatoresDeRisco"),
    headers:{
      "Accept":"application/json"
    }
  );

  List lista = json.decode(response.body);

  List<FatoresDeRisco> listau = new List<FatoresDeRisco>();

  
  for(int i = 0; i < lista.length; i++)
    listau.add(FatoresDeRisco.fromJson(lista[i]));
  

  return listau;
}

Future<int> createfatoresderisco(FatoresDeRisco fr) async {

  var url ='http://6f85a52b4f05.ngrok.io/api/FatoresDeRisco';
  var body = json.encode(<String, String>{
      'Id': fr.id.toString(),
      'Fator':fr.fator

    });


  http.Response response = await http.post(url,
      headers: {"Content-Type": "application/json"},
      body: body
  );

  return response.statusCode;
  
}

}