import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;
import 'package:scoped_model/scoped_model.dart';

class Administrador extends Model{

  int id;
  String username;
  String password;

  Administrador({int idd,String usern, String pass})
  {
    this.id = idd;
    this.username = usern;
    this.password = pass;
  }

  factory Administrador.fromJson(Map<String,dynamic> json){

    return Administrador(
      idd: json['id'] as int,
      usern: json['username'] as String,
      pass: json['password'] as String
          
    );

  }

  Future<Administrador> getadministrador(String usern) async {
  
  http.Response response = await http.get(
    Uri.encodeFull("http://6f85a52b4f05.ngrok.io/api/Administrador/"+usern),
    headers:{
      "Accept":"application/json"
    }
  );

  Administrador administrador = json.decode(response.body);
  
  return administrador;
 
}

Future<int> createadministrador(Administrador admin) async {

  var url ='http://6f85a52b4f05.ngrok.io/api/Administrador';
  var body = json.encode(<String, String>{
      'Id': admin.id.toString(),
      'Username':admin.username,
      'Password':admin.password

    });


  http.Response response = await http.post(url,
      headers: {"Content-Type": "application/json"},
      body: body
  );

  return response.statusCode;

}

}