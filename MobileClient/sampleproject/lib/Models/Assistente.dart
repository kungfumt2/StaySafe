import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;
import 'package:scoped_model/scoped_model.dart';


class Assistente extends Model{

  int idu;
  String tipo;
  String cargo;

  Assistente({int iduu,String type,String carg})
  {
    this.idu = iduu;
    this.tipo = type;
    this.cargo = carg;

  }

   factory Assistente.fromJson(Map<String,dynamic> json){

    return Assistente(
      iduu: json['iDU'] as int,
      type: json['tipo'] as String,
      carg: json['cargo'] as String
          
    );

  }

  Future<List<Assistente>> getassistentes() async {
  
  http.Response response = await http.get(
    Uri.encodeFull("http://6f85a52b4f05.ngrok.io/api/Assistente"),
    headers:{
      "Accept":"application/json"
    }
  );

  List lista = json.decode(response.body);

  List<Assistente> listau = new List<Assistente>();

  
  for(int i = 0; i < lista.length; i++)
    listau.add(Assistente.fromJson(lista[i]));
  

  return listau;
}

  Future<List<Assistente>> getassistente(int idu,String what,String type,String car) async {
  
  http.Response response = await http.get(
    Uri.encodeFull("http://6f85a52b4f05.ngrok.io/api/Assistente/"+idu.toString()+"/"+what+"/"+type+"/"+car),
    headers:{
      "Accept":"application/json"
    }
  );

  List lista = json.decode(response.body);

  List<Assistente> listau = new List<Assistente>();

  
  for(int i = 0; i < lista.length; i++)
    listau.add(Assistente.fromJson(lista[i]));
  

  return listau;
}

Future<int> createassistente(Assistente assis) async {

  var url ='http://6f85a52b4f05.ngrok.io/api/Assistente';
  var body = json.encode(<String, String>{
      'IDU': assis.idu.toString(),
      'Tipo':assis.tipo,
      'Cargo':assis.cargo

    });


  http.Response response = await http.post(url,
      headers: {"Content-Type": "application/json"},
      body: body
  );

  return int.parse(response.body);
}

void updateassistente(int idu,String what,String value) async {

  var url ='http://6f85a52b4f05.ngrok.io/api/Localizacao/' + idu.toString()+"/"+what;
  var body = json.encode(value);


  http.put(url,
      headers: {"Content-Type": "application/json"},
      body: body
  ).then((http.Response response) {
    

  });
}

}