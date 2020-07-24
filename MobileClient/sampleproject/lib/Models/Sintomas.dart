import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;
import 'package:scoped_model/scoped_model.dart';


class Sintomas extends Model{

  int ids;
  String sintoma;

  Sintomas({int idss,String sint})
  {
    this.ids = idss;
    this.sintoma = sint;
  }

  factory Sintomas.fromJson(Map<String,dynamic> json){

    return Sintomas(
      idss: json['iDS'] as int,
      sint: json['sintoma'] as String,
      
    );

  }

   
   
  Future<List<Sintomas>> getsintomas() async {
  
  http.Response response = await http.get(
    Uri.encodeFull("http://6f85a52b4f05.ngrok.io/api/Sintomas"),
    headers:{
      "Accept":"application/json"
    }
  );

  List lista = json.decode(response.body);

  List<Sintomas> listau = new List<Sintomas>();

  
  for(int i = 0; i < lista.length; i++)
    listau.add(Sintomas.fromJson(lista[i]));
  

  return listau;
}

Future<int> createSintoma(Sintomas sint) async {

  var url ='http://6f85a52b4f05.ngrok.io/api/Sintomas';
  var body = json.encode(<String, String>{
      'IDS': sint.ids.toString(),
      'Sintoma':sint.sintoma    

    });

  print(body);



  http.Response response = await http.post(url,
      headers: {"Content-Type": "application/json"},
      body: body
  );

  return response.statusCode;

}

}