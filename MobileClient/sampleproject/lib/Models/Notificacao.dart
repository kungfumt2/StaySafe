import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;
import 'package:scoped_model/scoped_model.dart';

class Notificacao extends Model{

  int id;
  String mensagem;

  Notificacao({int idd, String mess})
  {
    this.id = idd;
    this.mensagem = mess;
  }

   

   Future<Notificacao> getnots() async {
  
  http.Response response = await http.get(
    Uri.encodeFull("http://6f85a52b4f05.ngrok.io/api/Notificacao"),
    headers:{
      "Accept":"application/json"
    }
  );

  Notificacao not = new Notificacao();

  
  not.id = json.decode(response.body)["id"] as int;
  not.mensagem = json.decode(response.body)["mensagem"] as String;

  return not;
}

Future<int> createnot(Notificacao dis) async {

  var url ='http://6f85a52b4f05.ngrok.io/api/Notificacao';
  var body = json.encode(<String, String>{
      'Id': dis.id.toString(),
      'Mensagem':dis.mensagem

    });


   http.Response response = await http.post(url,
      headers: {"Content-Type": "application/json"},
      body: body
  );

  return response.statusCode;

}


}