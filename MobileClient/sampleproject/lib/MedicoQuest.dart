

import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:sampleproject/Models/Paciente.dart';
import 'package:sampleproject/SintomasQuest.dart';
import 'package:sampleproject/Viagem.dart';
import 'package:sampleproject/FatoresDeRiscoQuest.dart';

class MedicoQuest extends StatefulWidget {

List<String> respostas;
int iduser;
List<String> answers;
MedicoQuest({Key key,@required this.respostas, @required this.iduser,@required this.answers}) : super(key: key);
  
  @override
  _MedicoQuestState createState() => _MedicoQuestState();

   
}


class _MedicoQuestState extends State<MedicoQuest> {

String estado = "";
bool medicacao = false;


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
  List<Widget> w = [Center(child:Text("QUESTIONÁRIO MÉDICO", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.red, fontSize:24) )),
        SizedBox(height: 20),Text("Qual o estado em que o médico o colocou?", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.red, fontSize:10) ),SizedBox(height: 20),Row(children: [ SizedBox(width: 50,),
        FlatButton(

                onPressed: () => estadoButton("Infetado"),
                color: estado == "Infetado" ? Colors.green : Colors.red,
                padding: EdgeInsets.all(10.0),
                child: Column( 
                  children: <Widget>[

                    Image.asset("images/Infetado.PNG",height: 75, width: 75),

                    Text("Infetado", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.white, fontSize:15) ),
 
                  ],
                )),


                SizedBox(width: 75,),

                
        FlatButton(
                onPressed: () => estadoButton("Risco"),
                color: estado == "Risco" ? Colors.green : Colors.red,
                padding: EdgeInsets.all(10.0),
                child: Column( // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                   
                    Image.asset("images/Risco.PNG",height: 75, width: 75),
                     Text("Risco", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.white, fontSize:15) ),
                  ],
                )),]),

                

                SizedBox(height: 100,),

              Row(children: [ SizedBox(width: 50,),
        FlatButton(
                onPressed: () => estadoButton("Não infetado"),
                color: estado == "Não infetado" ? Colors.green : Colors.red,
                padding: EdgeInsets.all(10.0),
                child: Column( 
                  children: <Widget>[
                   
                    Image.asset("images/NaoInfetado.PNG",height: 75, width: 75),

                    Text("Não infetado", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.white, fontSize:15) ),
                  ],
                )),


                SizedBox(width: 70,),


        FlatButton(
                onPressed: () => estadoButton("Imune"),
                color:  estado == "Imune" ? Colors.green : Colors.red,
                padding: EdgeInsets.all(10.0),
                child: Column( // Replace with a Row for horizontal icon + text
                  children: <Widget>[

                    Image.asset("images/Imune.PNG",height: 75, width: 75),

                    Text("Imune", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.white, fontSize:15) ),
                  ],
                )),]), SizedBox(height: 70,),
                 Row(children:[SizedBox(width: 130,),new LinearPercentIndicator(
                width: 140.0,
                lineHeight: 20.0,
                percent: 0.9,
                backgroundColor: Colors.grey,
                progressColor: Colors.green,
                center: new Text(
                  "20 %"
              )),]),

        SizedBox(height: 30),
        Text("Foi-lhe receitada alguma medicação?", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.black, fontSize:14)),
        Row(children:[SizedBox(width: 100,),
        FlatButton(
                onPressed: () => medicacaoButton(),
                color: medicacao ? Colors.green : Colors.grey,
                padding: EdgeInsets.all(10.0),
                child: Column( // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                    Icon(Icons.check, color: Colors.white,),
                  ],
                )), FlatButton(
                onPressed: () => medicacaoButton(),
                color: medicacao ? Colors.grey : Colors.red,
                padding: EdgeInsets.all(10.0),
                child: Column( // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                    Icon(Icons.clear, color: Colors.white,),
                  ],
                ))

                ],),


        
        ];
 
        w.add(SizedBox(height: 5,));

      w.add(  new SizedBox(
       width: 200.0,
       height: 50.0,child:RaisedButton(color: Theme.of(context).accentColor,child:Row(children:[ Text("Próximo", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.white, fontSize:15) ),SizedBox(width: 60,), Icon(Icons.arrow_forward, color: Colors.white,)]),onPressed:(){
        Paciente user = new Paciente();

         for(int i = 0; i < this.widget.respostas.length; i++)
                {  
                  if(this.widget.respostas[i] == "Medico")
                  {
                    this.widget.respostas[i] = "";
                  }

                } 

         

         switch(estado)
         {
           case "Infetado":

           user.updatePaciente(this.widget.iduser,"Infetado").then((int sc){

             if(sc == 200)
             {
               if(medicacao)
                {
                  this.widget.answers.add("Medicacao");

                }
               


                if(this.widget.respostas.where((l)=>l == "Sintomas").length != 0)
                {
                   Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SintomasQuest(respostas: this.widget.respostas,iduser: this.widget.iduser,answers: this.widget.answers,)),
                              );

                }
                else if(this.widget.respostas.where((l)=>l == "Viagem").length != 0)
                {
                   Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Viagem(respostas: this.widget.respostas,answers: this.widget.answers,iduser: this.widget.iduser,)),
                              );
                  
                }
                else
                {
                   Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => FatoresDeRiscoQuest(iduser: this.widget.iduser,respostas: this.widget.respostas,answers: this.widget.answers,)),
                              );
                  
                }
              }

           });

           break;

           case "Risco":

           user.updatePaciente(this.widget.iduser, "Risco").then((int sc){

             if(sc == 200)
             {
               if(medicacao)
                {
                  this.widget.answers.add("Medicacao:SIM");

                }
                else
                {
                  this.widget.answers.add("Medicacao:NÃO");
                }


                if(this.widget.respostas.where((l)=>l == "Sintomas").length != 0)
                {
                   Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SintomasQuest(respostas: this.widget.respostas,iduser: this.widget.iduser,answers: this.widget.answers,)),
                              );
                }
                else if(this.widget.respostas.where((l)=>l == "Viagem").length != 0)
                {
                   Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Viagem(respostas: this.widget.respostas,answers: this.widget.answers,iduser: this.widget.iduser,)),
                              );
                }
                else
                {
                   Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => FatoresDeRiscoQuest(iduser: this.widget.iduser,respostas: this.widget.respostas,answers: this.widget.answers,)),
                              );
                }
              }

           });

           break;

           case "Não infetado":

           user.updatePaciente(this.widget.iduser, "Não infetado").then((int sc){

             if(sc == 200)
             {
               if(medicacao)
                {
                  this.widget.answers.add("Medicacao: SIM");

                }
                else
                {
                  this.widget.answers.add("Medicacao: NÃO");
                }


                if(this.widget.respostas.where((l)=>l == "Sintomas").length != 0)
                {
                   Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SintomasQuest(respostas: this.widget.respostas,iduser: this.widget.iduser,answers: this.widget.answers,)),
                              );
                }
                else if(this.widget.respostas.where((l)=>l == "Viagem").length != 0)
                {
                   Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Viagem(respostas: this.widget.respostas,answers: this.widget.answers,iduser: this.widget.iduser,)),
                              );
                }
                else
                {
                   Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => FatoresDeRiscoQuest(iduser: this.widget.iduser,respostas: this.widget.respostas,answers: this.widget.answers,)),
                              );
                }
              }

           });

           break;

           case "Imune":

            user.updatePaciente(this.widget.iduser,  "Imune").then((int sc){

             if(sc == 200)
             {
               if(medicacao)
                {
                  this.widget.answers.add("Medicacao: SIM");

                }
                else
                {
                  this.widget.answers.add("Medicacao: NÃO");
                }


                if(this.widget.respostas.where((l)=>l == "Sintomas").length != 0)
                {
                   Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SintomasQuest(respostas: this.widget.respostas,iduser: this.widget.iduser,answers: this.widget.answers,)),
                              );
                 
                }
                else if(this.widget.respostas.where((l)=>l == "Viagem").length != 0)
                {
                 Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Viagem(respostas: this.widget.respostas,answers: this.widget.answers,iduser: this.widget.iduser,)),
                              );
                }
                else
                {
                  Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => FatoresDeRiscoQuest(iduser: this.widget.iduser,respostas: this.widget.respostas,answers: this.widget.answers,)),
                              );
                }
              }

           });


           break;
         }
             
         },)));

  return w;
}

estadoButton(String v){
     setState(() {
   estado = v;

    });
  }

  medicacaoButton(){
     setState(() {
   medicacao = !medicacao;

    });
  }
  

}