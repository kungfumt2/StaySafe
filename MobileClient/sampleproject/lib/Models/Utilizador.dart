import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;
import 'package:scoped_model/scoped_model.dart';


class Utilizador extends Model{

  int id;
  String nome;
  String password;
  String email;
  String tipo;
  Uint8List fotografia;
  String estado;

  Utilizador({int idd,String name,String pass,String mail, String type,Uint8List photo,String state})
  {
    this.id = idd;
    this.nome = name;
    this.password = pass;
    this.email = mail;
    this.tipo = type;
    this.fotografia = photo;
    this.estado = state;

  }

  factory Utilizador.fromJson(Map<String,dynamic> json){

     String bystring = json['fotografia'] as String;

     List<int> list = bystring.codeUnits;
     Uint8List bytes = Uint8List.fromList(list);

    return Utilizador(
      idd: json['id'] as int,
      name: json['nome'] as String,
      pass: json['password'] as String,
      mail: json['email'] as String,
      type: json['tipo'] as String,
      photo: bytes,
      state: json['estado'] as String
    );

  }

  Future<List<Utilizador>> getutilizadores() async {
  


  http.Response response = await http.get(
    Uri.encodeFull("http://6f85a52b4f05.ngrok.io/api/Utilizador"),
    headers:{
      "Accept":"application/json"
    }
  );

  List lista = json.decode(response.body);

  List<Utilizador> listau = new List<Utilizador>();

  
  for(int i = 0; i < lista.length; i++)
    listau.add(Utilizador.fromJson(lista[i]));
  

  return listau;

}

Future<Utilizador> getutilizador(int idd) async {
  

  http.Response response = await http.get(
    Uri.encodeFull("http://6f85a52b4f05.ngrok.io/api/Utilizador/"+idd.toString()),
    headers:{
      "Accept":"application/json"
    }
  );


  Utilizador user = Utilizador.fromJson(json.decode(response.body));

  
  

  return user;
}

Future<int> createUtilizador(Utilizador user) async {

  var list  = new List.from(user.fotografia);

  var url ='http://6f85a52b4f05.ngrok.io/api/Utilizador';
  var body = json.encode(<String, dynamic>{
      'Id': user.id.toString(),
      'Nome':user.nome,
      'Password': user.password,
      'Email':user.email,
      'Tipo':user.tipo,
      'Fotografia':list,
      'Estado':user.estado

    });

  print(body);



  http.Response response = await http.post(url,
      headers: {"Content-Type": "application/json"},
      body: body
  );

  return int.parse(response.body);
}

Future<int> updateUtilizador(int id, String what, String value) async {

  List<String> values = new List<String>();

  var url ='http://6f85a52b4f05.ngrok.io/api/Utilizador/' + id.toString();

  values.add(what);
  values.add(value);

  var body = json.encode(values);


  http.Response response = await http.put(url,
      headers: {"Content-Type": "application/json"},
      body: body
  );

  return response.statusCode;
}

Future<Uint8List> loadpic(String nome) async {

final ByteData bytes = await rootBundle.load('images/'+nome);



return bytes.buffer.asUint8List();

}

Future<String> avaliarUtilizador(List<String> lista) async {

  var url ='http://6f85a52b4f05.ngrok.io/api/AvaliarPaciente';
  var body = json.encode(lista);
  
  print(body);



  http.Response response = await http.post(url,
      headers: {"Content-Type": "application/json"},
      body: body
  );

  return response.body.toString();
}


}