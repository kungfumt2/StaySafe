import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:sampleproject/Login.dart';
import 'dart:convert' show json;
import 'package:scoped_model/scoped_model.dart';

class Loggin extends Model{

  String email;
  String password;

  Loggin({String mail,String pass})
  {
    this.email = mail;
    this.password = pass;

  }


Future<List> makelogin(Loggin user) async {

  var url ='http://6f85a52b4f05.ngrok.io/api/Login';
  var body = json.encode(<String, String>{
      'email': user.email,
      'password':user.password,

    });

  print(body);



  http.Response response = await http.post(url,
      headers: {"Content-Type": "application/json"},
      body: body
  );

  if(response.statusCode == 200)
    {
      int userid = json.decode(response.body)["id"] as int;
      String role = json.decode(response.body)["role"] as String;

      return [userid,role];
    }
    else
    {
      return [];
    }

}




}