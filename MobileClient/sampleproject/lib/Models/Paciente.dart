import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;
import 'package:scoped_model/scoped_model.dart';


class Paciente extends Model{

  int idu;
  String codigopac;
  int idade;
  String sexo;
  String estado;
  bool risco;
  String morada;
  String codigopostal;

  Paciente({int iduu,String cp, int age,String sex,String state,bool risk, String mor,String codigop})
  {
    this.idu = iduu;
    this.codigopac = cp;
    this.idade = age;
    this.sexo = sex;
    this.estado = state;
    this.risco = risk;
    this.morada = mor;
    this.codigopostal = codigop;

  }

  factory Paciente.fromJson(Map<String,dynamic> json){

    return Paciente(
      iduu: json['idu'] as int,
      cp: json['codigoPac'] as String,
      age: json['idade'] as int,
      sex:json['sexo'] as String,
      state: json['estado'] as String,
      risk: json['risco'] as bool,
      mor: json['morada'] as String,
      codigop:json['codigoPostal'] as String
          
    );

  }

  Future<List> getpacientes() async {
  
  http.Response response = await http.get(
    Uri.encodeFull("http://6f85a52b4f05.ngrok.io/api/Paciente"),
    headers:{
      "Accept":"application/json"
    }
  );

  List lista = json.decode(response.body);

  List<Paciente> listau = new List<Paciente>();

  
  for(int i = 0; i < lista.length; i++)
    listau.add(Paciente.fromJson(lista[i]));
  

  return listau;
}

Future<List<Paciente>> getpaciente(int idu,String what, String value) async {
  
  http.Response response = await http.get(
    Uri.encodeFull("http://6f85a52b4f05.ngrok.io/api/Paciente/"+idu.toString()+"/"+what+"/"+value),
    headers:{
      "Accept":"application/json"
    }
  );

  List lista = json.decode(response.body);

  List<Paciente> listau = new List<Paciente>();

  
  for(int i = 0; i < lista.length; i++)
    listau.add(Paciente.fromJson(lista[i]));
  
  return listau;
}

Future<int> createpaciente(Paciente pac) async {

  var url ='http://6f85a52b4f05.ngrok.io/api/Paciente';
  var body = json.encode(<String, String>{
      'IDU': pac.idu.toString(),
      'CodigoPac':pac.codigopac,
      'Idade':pac.idade.toString(),
      'Sexo':pac.sexo,
      'Estado':pac.estado,
      'Risco':pac.risco.toString(),
      'Morada':pac.morada,
      'CodigoPostal':pac.codigopostal

    });


  http.Response response = await http.post(url,
      headers: {"Content-Type": "application/json"},
      body: body
  );

  return response.statusCode;
}

Future<int> updatePaciente(int idu,String value) async {

  var url ='http://6f85a52b4f05.ngrok.io/api/Paciente/' + idu.toString();
  var body = json.encode(value);


  http.Response response = await http.put(url,
      headers: {"Content-Type": "application/json"},
      body: body
  );

  return response.statusCode;
}


}