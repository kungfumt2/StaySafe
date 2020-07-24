import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sampleproject/IntroQuestionario.dart';
import 'package:sampleproject/Models/Localizacao.dart';
import 'package:sampleproject/Models/Paciente.dart';
import 'package:sampleproject/Models/StatusPais.dart';
import 'package:sampleproject/Models/MainViewConnection.dart';
import 'package:sampleproject/Models/Utilizador.dart';
import 'package:string_validator/string_validator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class MainView extends StatefulWidget {


Paciente user;
StatusPais status;
MainViewConnection locals;
Set<Marker> usermarker;
String notificacao;


  MainView({Key key,@required this.user,@required this.status, @required this.locals,@required this.usermarker, @required this.notificacao}) : super(key: key);
  
  
  @override
  _MainViewState createState() => _MainViewState();
}

  

class _MainViewState extends State<MainView> {
  List<bool> isSelected;
  double lat = 0.0;
  double long = 0.0;
  
  Completer<GoogleMapController> _controller = Completer();
  static GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(41.300255, -7.743935),
    zoom: 14.4746,
  );

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }
  


  @override
  Widget build(BuildContext context) {

    
    
    return Scaffold(
      appBar: AppBar(
        title: Center(child:Text('StaySafe IS')),
        backgroundColor: Colors.green,
      ),

      body:Center( child:Column(
        
            children: [
              Row(children: <Widget>[ Text("O SEU ESTADO:", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.black, fontSize:15) ),SizedBox(width: 10,),Text(this.widget.user.estado, style: TextStyle( fontWeight: FontWeight.bold, color: Colors.black, fontSize:15) )],),

              Flexible(   //<--Wrapped carousel widget in a Flexible container
            child:GoogleMap(
         mapType: MapType.normal,
         initialCameraPosition: _kGooglePlex,
         onMapCreated: _onMapCreated,
         markers: this.widget.usermarker,
         myLocationEnabled: true,
         myLocationButtonEnabled: true,
        ),),SizedBox(height: 10,),
        Text("Num raio de 5 km da sua morada:", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.black, fontSize:15) ),
        SizedBox(height: 4,),
        Row(children: <Widget>[Text("Infetados", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.red, fontSize:12) ), SizedBox(width: 10,), Text(this.widget.locals.ninfet.toString(), style: TextStyle( fontWeight: FontWeight.bold, color: Colors.red, fontSize:12) ),],),
        SizedBox(height: 4,),
        Row(children: <Widget>[Text("Risco", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.orange, fontSize:12) ), SizedBox(width: 10,), Text(this.widget.locals.nrisco.toString(), style: TextStyle( fontWeight: FontWeight.bold, color: Colors.orange, fontSize:12) ),],),
        SizedBox(height: 4,),
        Row(children: <Widget>[Text("Não infetado", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.blue, fontSize:12) ), SizedBox(width: 10,), Text(this.widget.locals.nninft.toString(), style: TextStyle( fontWeight: FontWeight.bold, color: Colors.blue, fontSize:12) ),],),
        SizedBox(height: 4,),
        Row(children: <Widget>[Text("Imune", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.green, fontSize:12) ), SizedBox(width: 10,), Text(this.widget.locals.nimunes.toString(), style: TextStyle( fontWeight: FontWeight.bold, color: Colors.green, fontSize:12) ),],),
        SizedBox(height: 10,),
        Text("Dados de Portugal:", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.black, fontSize:15) ),
        SizedBox(height: 2,),
        Row(children: <Widget>[Text("Novos confirmados: ", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.red, fontSize:12) ), SizedBox(width: 10,), Text(this.widget.status.novosconf.toString(), style: TextStyle( fontWeight: FontWeight.bold, color: Colors.red, fontSize:12) ),],),
        SizedBox(height: 2,),
        Row(children: <Widget>[Text("Total Confirmados: ", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.orange, fontSize:12) ), SizedBox(width: 10,), Text(this.widget.status.totalconf.toString(), style: TextStyle( fontWeight: FontWeight.bold, color: Colors.orange, fontSize:12) ),],),
        SizedBox(height: 2,),
        Row(children: <Widget>[Text("Novas mortes: ", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.blue, fontSize:12) ), SizedBox(width: 10,), Text(this.widget.status.novasmortes.toString(), style: TextStyle( fontWeight: FontWeight.bold, color: Colors.blue, fontSize:12) ),],),
        SizedBox(height: 2,),
        Row(children: <Widget>[Text("Total de mortes: ", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.green, fontSize:12) ), SizedBox(width: 10,), Text(this.widget.status.mortestotal.toString(), style: TextStyle( fontWeight: FontWeight.bold, color: Colors.green, fontSize:12) ),],),
        SizedBox(height: 2,),
          Row(children: <Widget>[Text("Novos recuperados: ", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.blue, fontSize:12) ), SizedBox(width: 10,), Text(this.widget.status.novosrecup.toString(), style: TextStyle( fontWeight: FontWeight.bold, color: Colors.blue, fontSize:12) ),],),
        SizedBox(height: 2,),
        Row(children: <Widget>[Text("Total de recuperados: ", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.green, fontSize:12) ), SizedBox(width: 10,), Text(this.widget.status.totalrecup.toString(), style: TextStyle( fontWeight: FontWeight.bold, color: Colors.green, fontSize:12) ),],),
        SizedBox(height: 20,),
        Row(children: <Widget>[Text("Notícias: ", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.black, fontSize:12) ), SizedBox(width: 10,), Text(this.widget.notificacao != "" ? this.widget.notificacao: "",style: TextStyle( fontWeight: FontWeight.bold, color: Colors.black, fontSize:12) ),],),

        new SizedBox(
       width: 200.0,
       height: 50.0,child: RaisedButton(color: Theme.of(context).accentColor,child:Row(children: [Text("Repetir Teste", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.white, fontSize:15),),SizedBox(width: 25,),Icon(Icons.arrow_forward, color: Colors.white,),]),onPressed:(){ 
              

       Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => IntroQuestionario(iduser: this.widget.user.idu,)),
                              );


       },),
            
            
            
            )]
      
            
          ),
    ));

    
    
  }


}