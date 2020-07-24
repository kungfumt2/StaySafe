import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;
import 'package:scoped_model/scoped_model.dart';


class StatusPais extends Model{

  String pais;
  int novosconf;
  int totalconf;
  int novasmortes;
  int mortestotal;
  int novosrecup;
  int totalrecup;
  DateTime dataatualizacao;

  StatusPais({String count,int nc,int tc,int nm,int mt,int nr,int tr,DateTime daterec})
  {
    this.pais = count;
    this.novosconf = nc;
    this.totalconf = tc;
    this.novasmortes = nm;
    this.mortestotal = mt;
    this.novosrecup = nr;
    this.totalrecup = tr;
    this.dataatualizacao = daterec;
  }

  factory StatusPais.fromJson(Map<String,dynamic> json){

    return StatusPais(
      count: json['Country'] as String,
      nc:  json['NewConfirmed'] as int,
      tc: json['TotalConfirmed'] as int,
      nm: json['NewDeaths'] as int,
      mt: json['TotalDeaths'] as int,
      nr: json['NewRecovered'] as int,
      tr: json['TotalRecovered'] as int,
      daterec: DateTime.parse(json['Date']));

  }

   
   
  Future<StatusPais> getstatus() async {
  
  http.Response response = await http.get(
    Uri.encodeFull("https://api.covid19api.com/summary"),
    headers:{
      "Accept":"application/json"
    }
  );

  List<dynamic> result = json.decode(response.body)['Countries'];

  List<StatusPais> listau = new List<StatusPais>();

  
  for(int i = 0; i < result.length; i++)
  {
    StatusPais element = StatusPais.fromJson(result[i]);

    if(element.pais == "Portugal")
    {
      return element;
    }


  }

  return null;
}

}