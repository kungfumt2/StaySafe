import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sampleproject/Models/Localizacao.dart';
import 'package:sampleproject/Models/Notificacao.dart';
import 'package:sampleproject/Models/Paciente.dart';
import 'package:sampleproject/Models/MainViewConnection.dart';
import 'package:sampleproject/Models/Utilizador.dart';
import 'package:string_validator/string_validator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;

import 'MainView.dart';
import 'Models/Loggin.dart';
import 'Models/StatusPais.dart';


class Login extends StatefulWidget {

  Login();
  
  @override
  _LoginState createState() => _LoginState();
}



  

class _LoginState extends State<Login> {
  List<bool> isSelected;
  

  @override
  Widget build(BuildContext context) {
    


    final emailcont = TextEditingController();
    final passcontroller = TextEditingController();


    return Scaffold(
      appBar: AppBar(
        title: Center(child:Text('StaySafe IS')),
        backgroundColor: Colors.orange,
      ),

      body:Center( child:Column(
        
            children: <Widget>[
              Text("Registo de Utilizador", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.red, fontSize:24) ),
               SizedBox(height: 20),
               Text("Email", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.black, fontSize:15) ),
            TextField(
                keyboardType: TextInputType.emailAddress,
                autofocus: false,
                controller: emailcont,
                style: new TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Email',
                  contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 7.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                ),
            ), SizedBox(height: 10,),

             Text("Password", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.black, fontSize:15) ),
            TextField(
                obscureText: true,
                autofocus: false,
                controller: passcontroller,
                style: new TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Password',
                  contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 7.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                ),
                
              ),
              
               SizedBox(height: 100),
            new SizedBox(
       width: 200.0,
       height: 50.0,child: RaisedButton(color: Theme.of(context).accentColor,child:Row(children: [Text("Submeter", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.white, fontSize:15),),SizedBox(width: 75,),Icon(Icons.arrow_forward, color: Colors.white,),]),onPressed:(){ 

          Loggin log = new Loggin();

          log.email = emailcont.text;
          log.password = passcontroller.text;

          Future<List> logreq = log.makelogin(log).then((List values){

              StatusPais stat = new StatusPais();
              Paciente pac = new Paciente();
              MainViewConnection con = new MainViewConnection();
              Localizacao l = new Localizacao();
              Notificacao not = new Notificacao();


            Future<StatusPais> sreq = stat.getstatus().then((StatusPais value){

              
              Future<Paciente> pacreq = pac.getpacientes().then((List pacientes){

                for(Paciente p in pacientes)
                {
                  if(p.idu == values[0])
                  {
                    pac = p;

                    break;
                  }
                }

                Future<MainViewConnection> mvc = con.getdadoslocal(values[0]).then((MainViewConnection locals){

                    Future<List<Localizacao>> localreq = l.getlocalizacao(values[0]).then((List<Localizacao> coordenadas){

                        Set<Marker> _markers = {
                            Marker(
                                  markerId: MarkerId('marker_2'),
                                  position: LatLng(coordenadas[0].latitude,coordenadas[0].longitude),
                                  draggable: true,

                        onTap: (){
                        },
                            ),

                        };

            Future<Notificacao> notreq = not.getnots().then((Notificacao newnot){

               Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => MainView(user:pac, status: value,locals: locals,usermarker: _markers,notificacao: newnot.mensagem,)),
                              );

                              });

                });

                });

            });

            });
          });


        },),
            
            
            
            )],
      
            
          ),
    ));
    
  }

  
}