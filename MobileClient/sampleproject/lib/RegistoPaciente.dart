import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sampleproject/IntroQuestionario.dart';
import 'package:sampleproject/Models/Conselho.dart';
import 'package:sampleproject/PacMorada.dart';
import 'package:sampleproject/Models/Paciente.dart';
import 'package:sampleproject/Models/Utilizador.dart';
import 'package:string_validator/string_validator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;

class RegistoPaciente extends StatefulWidget {

int iduser;
List conselhos;

  RegistoPaciente({Key key,@required this.iduser,@required this.conselhos}) : super(key: key);
  
  @override
  _RegistoPacienteState createState() => _RegistoPacienteState();
}

  

class _RegistoPacienteState extends State<RegistoPaciente> {
 
  final idadecont = TextEditingController();
  final moradacont = TextEditingController();
  final conscontr = TextEditingController();
  final codigopostalcont = TextEditingController();

  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentconselho;

   String genero = "";

   @override
  void initState() {
    _dropDownMenuItems = getDropDownMenuItems();
    _currentconselho = _dropDownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();

    for (Conselho tipo in  this.widget.conselhos) {
      items.add(new DropdownMenuItem(
          value: tipo.nome,
          child: new Text(tipo.nome)
      ));
    }
    return items;
  }


  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(
        title: Center(child:Text('StaySafe IS')),
        backgroundColor: Colors.orange,
      ),

      body:Center( child:Column(
        
            children: <Widget>[
              Text("Registo de Paciente", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.red, fontSize:24) ),
               SizedBox(height: 20),
              Text("Idade", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.black, fontSize:15) ),
             TextField(
                autofocus: false,
                controller: idadecont,
                style: new TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Idade',
                  contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 7.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                ),
            ), SizedBox(height: 10),

             Text("Morada", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.black, fontSize:15) ),
            TextField(
                autofocus: false,
                controller: moradacont,
                style: new TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Morada',
                  contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 7.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                ),

              ), SizedBox(height: 10),

              Text("Conselho de Morada", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.black, fontSize:15) ),
            new DropdownButton(
                icon: Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.red),
                    underline: Container(
                      height: 2,
                      width: 100,
                      color: Colors.red,
                    ),
                value: _currentconselho,
                items: _dropDownMenuItems,
                onChanged:changedDropDownItem ,
              ), SizedBox(height: 10),
              
              Text("Codigo Postal", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.black, fontSize:15) ),
            TextField(
                keyboardType: TextInputType.emailAddress,
                autofocus: false,
                controller: codigopostalcont,
                style: new TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Codigo Postal',
                  contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 7.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                ),
          
              ), SizedBox(height: 10), Text("Genero", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.black, fontSize:15) ),SizedBox(height: 10,), Row(children: [ SizedBox(width: 70,),
        FlatButton(
                onPressed: () => generoButton("Masculino"),
                color: genero == "Masculino" ? Colors.blue : Colors.grey,
                padding: EdgeInsets.all(10.0),
                child: Column( 
                  children: <Widget>[
                  
                    Image.asset("images/Masculino.PNG",height: 75, width: 75), 
                    Text("Masculino", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.white, fontSize:12) ),
 
                  ],
                )),


                SizedBox(width: 75,),

                
        FlatButton(
                onPressed: () => generoButton("Feminino"),
                color: genero == "Feminino" ? Colors.pink : Colors.grey,
                padding: EdgeInsets.all(10.0),
                child: Column( // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                   
                    Image.asset("images/Feminino.PNG",height: 75, width: 75),
                     Text("Feminino", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.white, fontSize:12) ),
                  ],
                )),]),
               SizedBox(height: 100),
            new SizedBox(
       width: 200.0,
       height: 50.0,child: RaisedButton(color: Theme.of(context).accentColor,child:Row(children: [Text("Próximo", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.white, fontSize:15),),SizedBox(width: 80,),Icon(Icons.arrow_forward, color: Colors.white,),]),onPressed:(){
              
              Paciente pac = new Paciente();

              pac.codigopac = "";
              pac.idade = int.parse(idadecont.text);
              pac.sexo = genero;
              pac.morada = moradacont.text;
              pac.codigopostal = codigopostalcont.text;
              pac.estado = "Nao Infetado";
              pac.risco = false;
              pac.idu = this.widget.iduser;
              
              Future<int> cpacinete = pac.createpaciente(pac).then((int sc){

                if(sc == 200)
                {
                   Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => PacMorada(iduser: this.widget.iduser,)),
                              );

                }
              });

            },),
            
            
            
            )],
      
            
          ),
    ));
    
  }

  void changedDropDownItem(String selectedtipo) {
    setState(() {
      _currentconselho = selectedtipo;
      print(selectedtipo);
    });
  }

   generoButton(String v){
     setState(() {
    genero = v;

    });
  }
}