
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:dart_amqp/dart_amqp.dart';
import 'package:sampleproject/MainView.dart';
import 'package:sampleproject/Models/Paciente.dart';
import 'package:sampleproject/Models/RelFact.dart';
import 'package:sampleproject/Models/Utilizador.dart';
import 'package:sampleproject/Resultados.dart';

class FatoresDeRiscoQuest extends StatefulWidget {

List<String> respostas;
List<String> answers;
int iduser;
FatoresDeRiscoQuest({Key key,@required this.respostas, @required this.iduser,@required this.answers}) : super(key: key);
  
  @override
  _FatoresDeRiscoQuestState createState() => _FatoresDeRiscoQuestState();

   
}

  

class _FatoresDeRiscoQuestState extends State<FatoresDeRiscoQuest> {

bool tabagismo = false;
bool hiper = false;
bool diabetes = false;
bool colestrol = false;

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
  List<Widget> w = [Center(child:Text("FATORES DE RISCO", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.red, fontSize:24) )),
        SizedBox(height: 20),Text("Possui algum destes fatores de risco?", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.red, fontSize:10) ),SizedBox(height: 20),Row(children: [ SizedBox(width: 50,),
        FlatButton(
                onPressed: () => tabagismoButton(),
                color: tabagismo ? Colors.green : Colors.red,
                padding: EdgeInsets.all(10.0),
                child: Column( 
                  children: <Widget>[
                  
                    Icon(Icons.smoking_rooms, size: 100,),
                    Text("Tabagismo", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.white, fontSize:15) ),
 
                  ],
                )),


                SizedBox(width: 75,),

                
        FlatButton(
                onPressed: () => hiperButton(),
                color: hiper ? Colors.green : Colors.red,
                padding: EdgeInsets.all(10.0),
                child: Column( // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                   
                    Icon(Icons.favorite, size: 100,),
                     Text("Hipertensão", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.white, fontSize:15) ),
                  ],
                )),]),

                

                SizedBox(height: 100,),

              Row(children: [ SizedBox(width: 50,),
        FlatButton(
                onPressed: () => diabetesButton(),
                color: diabetes ? Colors.green : Colors.red,
                padding: EdgeInsets.all(10.0),
                child: Column( 
                  children: <Widget>[
                   
                    Icon(Icons.fastfood, size: 100,),
                    Text("Diabetes", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.white, fontSize:15) ),
                  ],
                )),


                SizedBox(width: 70,),


        FlatButton(
                onPressed: () => colestrolButton(),
                color: colestrol ? Colors.green : Colors.red,
                padding: EdgeInsets.all(10.0),
                child: Column( // Replace with a Row for horizontal icon + text
                  children: <Widget>[

                    Icon(Icons.fastfood, size: 100,),
                    Text("Colestrol", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.white, fontSize:15) ),
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
          
          List<RelFact> relfacts = new List<RelFact>();

          RelFact rf = new RelFact();

           switch(tabagismo)
           {
             case true:
              this.widget.answers.add("FR:Tabagismo:SIM");

              rf.idp = this.widget.iduser;
              rf.idf = 1;
              rf.tempo = DateTime.now().toString().split(' ')[0];

              relfacts.add(rf);

              break;

            case false:
              this.widget.answers.add("FR:Tabagismo:NÃO");
              break;
              
           }

           switch(hiper)
           {
             case true:
             this.widget.answers.add("FR:Hipertenção:SIM");
             rf.idp = this.widget.iduser;
              rf.idf = 2;
              rf.tempo = DateTime.now().toString().split(' ')[0];

              relfacts.add(rf);
              break;

              case false:
             this.widget.answers.add("FR:Hipertenção:NÃO");
              break;

           }

           switch(diabetes)
           {
             case true:
             this.widget.answers.add("FR:Diabetes:SIM");
             rf.idp = this.widget.iduser;
              rf.idf = 3;
              rf.tempo = DateTime.now().toString().split(' ')[0];

              relfacts.add(rf);
              break;

              case false:
             this.widget.answers.add("FR:Diabetes:NÃO");
              break;
           }

           switch(colestrol)
           {
             case true:
             this.widget.answers.add("FR:Colestrol/Triglicerideos:SIM");
             rf.idp = this.widget.iduser;
              rf.idf = 1;
              rf.tempo = DateTime.now().toString().split(' ')[0];

              relfacts.add(rf);
              break;

              case false:
             this.widget.answers.add("FR:Colestrol/Triglicerideos:NÃO");
              break;

           }

            Future<int> relfactreq = rf.createRelFact(relfacts).then((int sc){

              if(sc == 1)
              {
                  Utilizador user = new Utilizador();
                  Paciente pac = new Paciente();

                  Future<String> makeav = user.avaliarUtilizador(this.widget.answers).then((String estado){

                    Future<int> alterarestado = pac.updatePaciente(this.widget.iduser, estado).then((int sc){

                      if(sc == 200)
                      {
                        Future<Utilizador> userreq = user.getutilizador(this.widget.iduser).then((Utilizador loggeduser){

                          Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Resultados(loggeduser: loggeduser,answers: this.widget.answers,respostas: this.widget.respostas,estado: estado,)),
                              );
                        });
                          
                      }

                    });

                  });

              }

            });
             
       },)));

  return w;
}

tabagismoButton(){
    setState(() {
    tabagismo = !tabagismo;

    });
  }

   hiperButton(){
    setState(() {
    hiper = !hiper;

    });
  }

  diabetesButton(){
    setState(() {
    diabetes = !diabetes;

    });
  }

  colestrolButton(){
    setState(() {
    colestrol = !colestrol;

    });
  }
  

}