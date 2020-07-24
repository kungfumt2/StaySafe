
import 'package:flutter/material.dart';
import 'package:sampleproject/Models/FatoresDeRisco.dart';
import 'package:sampleproject/MedicoQuest.dart';
import 'package:sampleproject/SintomasQuest.dart';
import 'package:sampleproject/Models/Utilizador.dart';
import 'package:sampleproject/Viagem.dart';
import 'package:string_validator/string_validator.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:sampleproject/FatoresDeRiscoQuest.dart';

class IntroQuestionario extends StatefulWidget {

int iduser;

  IntroQuestionario({Key key,@required this.iduser}) : super(key: key);
  
  @override
  _IntroQuestionarioState createState() => _IntroQuestionarioState();
}

  

class _IntroQuestionarioState extends State<IntroQuestionario> {
 
 
bool medico = false;
bool sintomas = false;
bool viagem = false;  

  @override
  Widget build(BuildContext context) {
    
    List<Widget> w = new List<Widget>();
    List<String> respostas = new List<String>();

    w.add(SizedBox(height: 20),);
    


        w.add(SizedBox(height: 20),);

          w.add( Row(children:[SizedBox(width: 50,), FlatButton(
                onPressed:() => medicoButton(),
                color: medico ? Colors.green : Colors.red,
                padding: EdgeInsets.all(10.0),
                child: Column(children:[
                 
                  Icon(Icons.local_hospital, size: 100,),
                 
          ])), SizedBox(width: 30,), Text("Já consultou um médico?", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.black, fontSize:17) )]));

                w.add(SizedBox(height: 10),);


             w.add(Row(children:[SizedBox(width: 50,), FlatButton(
                onPressed:() => contactoButton(),
                color: sintomas ? Colors.green : Colors.red,
                padding: EdgeInsets.all(10.0),
                child: Column( // Replace with a Row for horizontal icon + text
                  children: <Widget>[

                   Icon(Icons.people, size: 100,),
                  ],
                )),SizedBox(width: 30,), Text("Teve contacto com \n infetados ou suspeitos?", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.black, fontSize:17) )]));

                w.add(SizedBox(height: 10),);


             w.add(Row(children:[SizedBox(width: 50,),FlatButton(
                onPressed:() => viagemButton(),
                color: viagem? Colors.green : Colors.red,
                padding: EdgeInsets.all(10.0),
                child: Column( // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                    Icon(Icons.airplanemode_active, size: 100,),
                  ],
                )),SizedBox(width: 30,), Text("Viajou para regiões\n de risco?", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.black, fontSize:17) ),]));

                  
                  w.add(SizedBox(height: 20),);

      

      

       w.add(Row(children:[SizedBox(width: 130,),new LinearPercentIndicator(
                width: 140.0,
                lineHeight: 20.0,
                percent: 0.0,
                backgroundColor: Colors.grey,
                progressColor: Colors.green,
                center: new Text(
                  "0 %"
              )),]));

        w.add(SizedBox(height: 40),);


       
      w.add(new SizedBox(
       width: 200.0,
       height: 50.0,child: RaisedButton(color: Theme.of(context).accentColor,child: Row(children:[ Text("Confirmar", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.white, fontSize:15),),SizedBox(width: 60,),Icon(Icons.arrow_forward, color: Colors.white,)]),onPressed:(){ 
        
        List<String> answers = new List<String>();

        answers.add(this.widget.iduser.toString());

         switch(medico)
         {
           case true:
           respostas.add("Medico");
           break;

           case false:
           break;

         }

         switch(sintomas)
         {
           case true:
           respostas.add("Sintomas");
           break;

           case false:
           break;
         }

          switch(viagem)
         {
           case true:
           respostas.add("Viagem");
           break;

           case false:
           break;
         }



         if(respostas[0] == "Medico")
         {
            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => MedicoQuest(respostas: respostas,iduser:this.widget.iduser,answers: answers,)),
                              );

         }
         else if(respostas[0] == "Sintomas")
         {
            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SintomasQuest(respostas:respostas ,iduser: this.widget.iduser,answers: answers,)),
                              );
           
         }
         else if(respostas[0] == "Viagem")
         {
            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Viagem(respostas: respostas,iduser: this.widget.iduser,answers:answers,)),
                              );

           
         }
         else
         {
           Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => FatoresDeRiscoQuest(iduser: this.widget.iduser,respostas: respostas,answers: answers,)),
                              );

          
         }
         
            },)));





    

    return Scaffold(
      appBar: AppBar(
        title: Text('StaySafe IS'),
        backgroundColor: Colors.green,
      ),

      body:Column(children: w
      )
      
            
    );


   
    
  }
   List<Widget> getWidgets()
    {
      List<Widget> w =  new List<Widget>();


       


      return w;
    
      }
    

    medicoButton(){
    setState(() {
    medico = !medico;

    });
    }

    contactoButton(){
    setState(() {
    sintomas = !sintomas;

    });
    }

    viagemButton(){
    setState(() {
    viagem = !viagem;

    });

  }
 }