import 'dart:io';
import 'package:dart_amqp/dart_amqp.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sampleproject/Models/Localizacao.dart';
import 'package:sampleproject/Models/Notificacao.dart';
import 'package:sampleproject/Models/Paciente.dart';
import 'package:sampleproject/Models/StatusPais.dart';
import 'package:sampleproject/Models/Utilizador.dart';
import 'package:string_validator/string_validator.dart';
import 'package:sampleproject/Models/MainViewConnection.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;
import 'package:sampleproject/MainView.dart';

class Resultados extends StatefulWidget {

List<String> respostas;
List<String> answers;
Utilizador loggeduser;
String estado;

  Resultados({Key key,@required this.respostas, @required this.loggeduser,@required this.answers,@required this.estado}) : super(key: key);
  
  @override
  _ResultadosState createState() => _ResultadosState();
}



class _ResultadosState extends State<Resultados> {
  List<bool> isSelected;


  
  @override
  Widget build(BuildContext context) {
    

    List<Widget> widgets = getWidgets();


    return Scaffold(
      appBar: AppBar(
        title: Text('StaySafe IS'),
        backgroundColor: Colors.green,
      ),

      body:Center(child:Column(
        
            children: widgets
              
      
            
          ),
    ));
    
  }

  List<Widget> getWidgets()
  {
    List<Widget> w = new List<Widget>();

    w.add(SizedBox(width: 100,));

    w.add(Text("RESULTADOS:", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.red, fontSize:24) ));
               w.add(SizedBox(height: 30),);
      // Dados pessoais
      
               w.add(Text("Identificacao:", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.red, fontSize:20) ));
              
              w.add(SizedBox(height: 5),);
              

              w.add(Text("Nome: " + this.widget.loggeduser.nome, style: TextStyle( fontWeight: FontWeight.bold, color: Colors.black, fontSize:17) ));
              w.add(SizedBox(height: 5),);

               w.add(Text("Email: " + this.widget.loggeduser.email, style: TextStyle( fontWeight: FontWeight.bold, color: Colors.black, fontSize:17) ));
               w.add(SizedBox(height: 5),);

              w.add(SizedBox(height: 15),);

              w.add(Text("Geral:", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.red, fontSize:20) ));
              
              w.add(SizedBox(height: 5),);
              
              // Principais sintomas:

              for(var a in this.widget.answers)
              {
                if(a.split(':')[0] == "Sintomas")
                {
                  if(a.split(':')[1] != "Contacto" && a.split(':')[2] == "SIM")
                  {
                     w.add(Text(a.split(':')[1], style: TextStyle( fontWeight: FontWeight.bold, color: Colors.black, fontSize:17) ));
                  }
                  else
                  {
                    if(a.split(':')[1] == "Contacto")
                    {
                       w.add(Text((a.split(':')[1] +" -> " + a.split(':')[2]), style: TextStyle( fontWeight: FontWeight.bold, color: Colors.black, fontSize:17) ));
                    }
                  }
                }
              }

              w.add(SizedBox(height: 15),);

               w.add(Text("Outros sintomas:", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.red, fontSize:20) ));
              
              w.add(SizedBox(height: 5),);
              
              // Outros sintomas:

              for(var a in this.widget.answers)
              {
                if(a.split(':')[0] == "Medicacao")
                {
                  w.add(Text("Encontra-se a tomar medicação", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.black, fontSize:17) ));

                  break;
                }
              }

              w.add(SizedBox(height: 15),);


              w.add(Text("Fatores de risco:", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.red, fontSize:15) ));
              
              w.add(SizedBox(height: 5),);
              
              // Outros sintomas:

              for(var a in this.widget.answers)
              {
                if(a.split(':')[0] == "FR" && a.split(':')[2] == "SIM")
                {
                   w.add(Text(a.split(':')[1], style: TextStyle( fontWeight: FontWeight.bold, color: Colors.black, fontSize:12) ));
                }
              }

              w.add(SizedBox(height: 15),);

              w.add(Row(children:[SizedBox(width: 90,), Text("Resultado da avaliação:", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.red, fontSize:17) ), SizedBox(width: 10,),Text(this.widget.estado, style: TextStyle( fontWeight: FontWeight.bold, color: Colors.black, fontSize:17) )]));

             w.add(SizedBox(height: 20,));

            w.add(SizedBox(
       width: 200.0,
       height: 50.0,child: RaisedButton(color: Theme.of(context).accentColor,child:Row(children: [Text("Enviar", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.white, fontSize:15),),SizedBox(width: 80,),Icon(Icons.arrow_forward, color: Colors.white,),]),onPressed:(){ 
              
        String message = "Novo caso: " + this.widget.estado;

          

             ConnectionSettings settings = new ConnectionSettings(
             host : "10.0.0.2",
              authProvider : new PlainAuthenticator("AndroidUser", "12345")
              );
              Client client = new Client(settings : settings);            
              client
              .channel()
              .then((Channel channel) => channel.exchange("MO", ExchangeType.DIRECT))
              .then((Exchange exchange) {

                exchange.publish(message, null);
                client.close();
            }); 

            StatusPais stat = new StatusPais();
            Paciente pac = new Paciente();
            MainViewConnection con = new MainViewConnection();
            Localizacao l = new Localizacao();
            Notificacao not = new Notificacao();

            Future<StatusPais> sreq = stat.getstatus().then((StatusPais value){

              Future<Paciente> pacreq = pac.getpacientes().then((List pacientes){

                for(Paciente p in pacientes)
                {
                  if(p.idu == this.widget.loggeduser.id)
                  {
                    pac = p;

                    break;
                  }
                }

                Future<MainViewConnection> mvc = con.getdadoslocal(this.widget.loggeduser.id).then((MainViewConnection locals){

                  Future<List<Localizacao>> localreq = l.getlocalizacao(this.widget.loggeduser.id).then((List<Localizacao> coordenadas){

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
            

            },),
            
            
            
            ),);

             return w;
}


}

 
