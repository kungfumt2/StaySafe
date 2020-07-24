import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;
import 'package:scoped_model/scoped_model.dart';

class Distrito extends Model{

  int idd;
  String nome;

  Distrito({int iddd, String name})
  {
    this.idd = iddd;
    this.nome = name;
  }

   factory Distrito.fromJson(Map<String,dynamic> json){

    return Distrito(
      iddd: json['idD'] as int,
      name: json['nome'] as String
          
    );

  }

   Future<List<Distrito>> getdistritos() async {
  
  http.Response response = await http.get(
    Uri.encodeFull("http://6f85a52b4f05.ngrok.io/api/Distrito"),
    headers:{
      "Accept":"application/json"
    }
  );

  List lista = json.decode(response.body);

  List<Distrito> listau = new List<Distrito>();

  
  for(int i = 0; i < lista.length; i++)
    listau.add(Distrito.fromJson(lista[i]));
  

  return listau;
}

Future<int> createdistrito(Distrito dis) async {

  var url ='http://6f85a52b4f05.ngrok.io/api/FatoresDeRisco';
  var body = json.encode(<String, String>{
      'IdD': dis.idd.toString(),
      'Nome':dis.nome

    });


   http.Response response = await http.post(url,
      headers: {"Content-Type": "application/json"},
      body: body
  );

  return response.statusCode;

}

}