import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:sampleproject/Models/Conselho.dart';
import 'package:sampleproject/Models/Utilizador.dart';
import 'package:sampleproject/RegistoPaciente.dart';
import 'package:string_validator/string_validator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;


class Registo extends StatefulWidget {

  Registo();
  
  @override
  _RegistoState createState() => _RegistoState();
}



  

class _RegistoState extends State<Registo> {
  List<bool> isSelected;

  String usertype = "";
  final nomecontroller = TextEditingController();
  final passconttroller = TextEditingController();
  final emailcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(
        title: Center(child:Text('StaySafe IS')),
        backgroundColor: Colors.orange,
      ),

      body:Center( child:Column(
        
            children: <Widget>[
              Text("Registo de Utilizador", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.red, fontSize:24) ),
               SizedBox(height: 20),
              Text("Nome", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.black, fontSize:15) ),
             TextField(
                autofocus: false,
                controller: nomecontroller,
                style: new TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Nome',
                  contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 7.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                ),
           ), SizedBox(height: 10),

             Text("Password", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.black, fontSize:15) ),
            TextField(
                obscureText: true,
                autofocus: false,
                controller: passconttroller,
                style: new TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Password',
                  contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 7.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                ),
                
              ), SizedBox(height: 10),
              
              Text("Email", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.black, fontSize:15) ),
            TextField(
                keyboardType: TextInputType.emailAddress,
                autofocus: false,
                controller: emailcontroller,
                style: new TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Email',
                  contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 7.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                ),
            
              ),
               SizedBox(height: 100),
            new SizedBox(
       width: 200.0,
       height: 50.0,child: RaisedButton(color: Theme.of(context).accentColor,child:Row(children: [Text("Próximo", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.white, fontSize:15),),SizedBox(width: 80,),Icon(Icons.arrow_forward, color: Colors.white,),]),onPressed:(){
              
              Utilizador user = new Utilizador();
              Conselho cons = new Conselho();

              user.id = 0;
              user.nome = nomecontroller.text;
              user.password = passconttroller.text;
              user.email = emailcontroller.text;
              user.tipo = "Paciente";

               

              
                
                Future<Uint8List> fotoload = user.loadpic("avatar.png").then((Uint8List value){

                  user.fotografia = value;

                  user.estado = "Validado";

                  Future<int> cuserreq = user.createUtilizador(user).then((int newid){

                    Future<List> consreq = cons.getconselhos().then((List conselhos){

                    Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => RegistoPaciente(iduser: newid,conselhos: conselhos,)),
                              );

                  });

                  });



                });

               


             
              
              

            },),
            
            
            
            )],
      
            
          ),
    ));
    
  }

  typeButton(String v){
     setState(() {
   usertype = v;

    });
  }
  
}