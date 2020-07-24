import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;
import 'package:scoped_model/scoped_model.dart';


class Relatorio extends Model{

  DateTime datarelatorio;
  int idp;
  int ida;
  Uint8List ficheiro;


  Relatorio({DateTime dr, int idpp, int idaa, Uint8List file})
  {
    this.datarelatorio = dr;
    this.idp = idpp;
    this.ida = idaa;
    this.ficheiro = file;
  }

  factory Relatorio.fromJson(Map<String,dynamic> json){

     String bystring = json['Ficheiro'] as String;

     List<int> list = bystring.codeUnits;
     Uint8List bytes = Uint8List.fromList(list);

    return Relatorio(
      dr: DateTime.parse(json['DataRelatorio']),
      idpp: json['idP'] as int,
      idaa: json['idA'] as int,
      file: bytes
      
    );

  }

  Future<List<Relatorio>> getrelatorios() async {
  
  http.Response response = await http.get(
    Uri.encodeFull("http://6f85a52b4f05.ngrok.io/api/Relatorio"),
    headers:{
      "Accept":"application/json"
    }
  );

  List lista = json.decode(response.body);

  List<Relatorio> listau = new List<Relatorio>();

  
  for(int i = 0; i < lista.length; i++)
    listau.add(Relatorio.fromJson(lista[i]));
  

  return listau;
}

Future<List<Relatorio>> getrelatorio(int id,String what, String value) async {
  
  http.Response response = await http.get(
    Uri.encodeFull("http://6f85a52b4f05.ngrok.io/api/Relatorio/"+id.toString()+"/"+what+"/"+value),
    headers:{
      "Accept":"application/json"
    }
  );

  List lista = json.decode(response.body);

  List<Relatorio> listau = new List<Relatorio>();

  
  for(int i = 0; i < lista.length; i++)
    listau.add(Relatorio.fromJson(lista[i]));
  

  return listau;
}

Future<int> createRelatorio(Relatorio relatorio) async {

  var list  = new List.from(relatorio.ficheiro);

  var url ='http://6f85a52b4f05.ngrok.io/api/Relatorio';
  var body = json.encode(<String, dynamic>{
      'DataRelatorio': relatorio.datarelatorio.toString(),
      'IdP':relatorio.idp.toString(),
      'IdA':relatorio.ida.toString(),
      'Ficheiro':list
      
    });

  print(body);



   http.Response response = await http.post(url,
      headers: {"Content-Type": "application/json"},
      body: body
  );

  return response.statusCode;

}

}