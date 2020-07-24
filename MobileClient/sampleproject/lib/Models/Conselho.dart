import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;
import 'package:scoped_model/scoped_model.dart';


class Conselho extends Model{

  int idconselho;
  String nome;
  int iddist;


  Conselho({int idc, String name, int idd})
  {
    this.idconselho = idc;
    this.nome = name;
    this.iddist = idd;
  }

  factory Conselho.fromJson(Map<String,dynamic> json){

    return Conselho(
      idc: json['idConselho'] as int,
      name: json['nome'] as String,
      idd: json['idDist'] as int
          
    );

  }

  Future<List<Conselho>> getconselhos() async {
  
  http.Response response = await http.get(
    Uri.encodeFull("http://6f85a52b4f05.ngrok.io/api/Conselho"),
    headers:{
      "Accept":"application/json"
    }
  );

  List lista = json.decode(response.body);

  List<Conselho> listau = new List<Conselho>();

  
  for(int i = 0; i < lista.length; i++)
    listau.add(Conselho.fromJson(lista[i]));
  

  return listau;
}

Future<List> getconselho(String what, int id) async {
  
  http.Response response = await http.get(
    Uri.encodeFull("http://6f85a52b4f05.ngrok.io/api/Conselho/"+what+"/"+id.toString()),
    headers:{
      "Accept":"application/json"
    }
  );

  List lista = json.decode(response.body);

  List<Conselho> listau = new List<Conselho>();

  
  for(int i = 0; i < lista.length; i++)
    listau.add(Conselho.fromJson(lista[i]));
  

  return listau;
}

Future<int> createconselho(Conselho cons) async {

  var url ='http://6f85a52b4f05.ngrok.io/api/Conselho';
  var body = json.encode(<String, String>{
      'IdConselho': cons.idconselho.toString(),
      'Nome':cons.nome,
      'IdDist':cons.iddist.toString()

    });


   http.Response response = await http.post(url,
      headers: {"Content-Type": "application/json"},
      body: body
  );

  return response.statusCode;

}

}