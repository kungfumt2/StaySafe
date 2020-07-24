
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:sampleproject/FatoresDeRiscoQuest.dart';
import 'package:sampleproject/Models/Paciente.dart';
import 'package:sampleproject/Models/Utilizador.dart';


class Viagem extends StatefulWidget {

List<String> respostas;
int iduser;
List<String> answers;

Viagem({Key key,@required this.respostas, @required this.iduser, @required this.answers}) : super(key: key);
  
  @override
  _ViagemState createState() => _ViagemState();

   
}

  

class _ViagemState extends State<Viagem> {

bool china = false;
bool eua = false;
bool espanha = false;
bool italia = false;

  @override
  Widget build(BuildContext context) {

    
    List<Widget> lista  = getwidgets();

   

    return Scaffold(
      appBar: AppBar(
        title: Text('StaySafe IS'),
        backgroundColor: Colors.green,
      ),

      body: Center(child:Column(children: lista,))
      
    );


}

List<Widget> getwidgets()
{
  List<Widget> w = [Center(child:Text("VIAGENS DE RISCO", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.red, fontSize:24) )),
        SizedBox(height: 20),Text("Viajou para algum destes países?", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.red, fontSize:10) ),SizedBox(height: 20),Row(children: [ SizedBox(width: 50,),
        FlatButton(
                onPressed: () => chinaButton(),
                color: china ? Colors.green : Colors.red,
                padding: EdgeInsets.all(10.0),
                child: Column( 
                  children: <Widget>[
                  
                    Image.asset("images/China.png",height: 100, width: 100),
                    Text("China", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.white, fontSize:15) ),
 
                  ],
                )),


                SizedBox(width: 75,),

                
        FlatButton(
                onPressed: () => euaButton(),
                color: eua ? Colors.green : Colors.red,
                padding: EdgeInsets.all(10.0),
                child: Column( // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                   
                    Image.asset("images/EUA.jpg",height: 100, width: 100),
                     Text("Estados Unidos", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.white, fontSize:15) ),
                  ],
                )),]),

                

                SizedBox(height: 100,),

              Row(children: [ SizedBox(width: 50,),
        FlatButton(
                onPressed: () => espanhaButton(),
                color: espanha ? Colors.green : Colors.red,
                padding: EdgeInsets.all(10.0),
                child: Column( 
                  children: <Widget>[
                   
                    Image.asset("images/Espanha.jpg",height: 100, width: 100),
                    Text("Espanha", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.white, fontSize:15) ),
                  ],
                )),


                SizedBox(width: 70,),


        FlatButton(
                onPressed: () => italiaButton(),
                color: italia ? Colors.green : Colors.red,
                padding: EdgeInsets.all(10.0),
                child: Column( // Replace with a Row for horizontal icon + text
                  children: <Widget>[

                    Image.asset("images/Italia.jpg",height: 100, width: 100),
                    Text("Itália", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.white, fontSize:15) ),
                  ],
                )),]), SizedBox(height: 70,),
                 Row(children:[SizedBox(width: 130,),new LinearPercentIndicator(
                width: 140.0,
                lineHeight: 20.0,
                percent: 0.9,
                backgroundColor: Colors.grey,
                progressColor: Colors.green,
                center: new Text(
                  "90 %"
              )),]),

        SizedBox(height: 40),];
 
  

      w.add(  new SizedBox(
       width: 200.0,
       height: 50.0,child:RaisedButton(color: Theme.of(context).accentColor,child:Row(children:[ Text("Próximo", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.white, fontSize:15) ),SizedBox(width: 60,), Icon(Icons.arrow_forward, color: Colors.white,)]),onPressed:(){ 
                          
             switch(china)
             {
               case true:
               this.widget.answers.add("Viagem:China:SIM");
               break;

               case false:
               this.widget.answers.add("Viagem:China:NÃO");
               break;
             }

             switch(eua)
             {
               case true:
               this.widget.answers.add("Viagem:EUA:SIM");
               break;

               case false:
               this.widget.answers.add("Viagem:EUA:NÃO");
               break;
             }

             switch(espanha)
             {
               case true:
               this.widget.answers.add("Viagem:Espanha:SIM");
               break;

               case false:
               this.widget.answers.add("Viagem:Espanha:NÃO");
               break;
             }

               switch(italia)
              {
               case true:
               this.widget.answers.add("Viagem:Italia:SIM");
               break;

               case false:
               this.widget.answers.add("Viagem:Italia:NÃO");
               break;
              }

               for(int i = 0; i < this.widget.respostas.length; i++)
                {  
                  if(this.widget.respostas[i] == "Viagem")
                  {
                    this.widget.respostas[i] = "";
                  }

                } 


                  Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => FatoresDeRiscoQuest(iduser: this.widget.iduser,respostas: this.widget.respostas,answers: this.widget.answers,)),
                              );

              
              

            },)));

  return w;
}

chinaButton(){
    setState(() {
    china = !china;

    });
  }

   euaButton(){
    setState(() {
    eua = !eua;

    });
  }

  espanhaButton(){
    setState(() {
    espanha = !espanha;

    });
  }

  italiaButton(){
    setState(() {
    italia = !italia;

    });
  }
  

}