
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:sampleproject/Models/Paciente.dart';
import 'package:sampleproject/Models/RelSin.dart';
import 'package:sampleproject/Models/Utilizador.dart';
import 'package:sampleproject/MedicoQuest.dart';
import 'package:sampleproject/Viagem.dart';
import 'package:sampleproject/FatoresDeRiscoQuest.dart';
class SintomasQuest extends StatefulWidget {

List<String> respostas;
int iduser;
List<String> answers;
SintomasQuest({Key key,@required this.respostas, @required this.iduser,@required this.answers}) : super(key: key);
  
  @override
  _SintomasQuestState createState() => _SintomasQuestState();

   
}


class _SintomasQuestState extends State<SintomasQuest> {

bool corrimento = false;
bool cansaco = false;
bool diarreia = false;
bool cnasal = false;
bool contacto = false;

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
  List<Widget> w = new List<Widget>();

        w = [Text("Contacto direto?", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.black, fontSize:14)),

        FlatButton(
                onPressed: () => contactoButton(),
                color: contacto ? Colors.green : Colors.grey,
                padding: EdgeInsets.all(10.0),
                child: Column( // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                    Icon(Icons.check, color: Colors.white,),
                  ],
                )), FlatButton(
                onPressed: () => contactoButton(),
                color: contacto ? Colors.grey : Colors.red,
                padding: EdgeInsets.all(10.0),
                child: Column( // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                    Icon(Icons.clear, color: Colors.white,),
                  ],
                )),
        SizedBox(height: 20),
        Text("Possui algum destes sintomas?", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.red, fontSize:10) ),SizedBox(height: 20),Row(children: [ SizedBox(width: 50,),
        
        FlatButton(
                onPressed: () => corrimentoButton(),
                color: corrimento ? Colors.green : Colors.red,
                padding: EdgeInsets.all(10.0),
                child: Column( 
                  children: <Widget>[
                  
                    Image.asset("images/Corrnasal.PNG",height: 75, width: 75),
                    Text("Corrimento nasal", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.white, fontSize:15) ),
 
                  ],
                )),


                SizedBox(width: 50,),
                
        FlatButton(
                onPressed: () => cansacoButton(),
                color: cansaco ? Colors.green : Colors.red,
                padding: EdgeInsets.all(10.0),
                child: Column( // Replace with a Row for horizontal icon + text
                  children: <Widget>[
                   
                    Image.asset("images/Cansaco.PNG",height: 75, width: 75),
                     Text("Cansaco", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.white, fontSize:15) ),
                  ],
                )),]),

                

                SizedBox(height: 50,),

              Row(children: [ SizedBox(width: 50,),
        FlatButton(
                onPressed: () => diarreiaButton(),
                color: diarreia ? Colors.green : Colors.red,
                padding: EdgeInsets.all(10.0),
                child: Column( 
                  children: <Widget>[
                   
                    Image.asset("images/Diarreia.PNG",height: 50, width: 50),
                    Text("Diarreia", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.white, fontSize:15) ),
                  ],
                )),


                SizedBox(width: 50,),


        FlatButton(
                onPressed: () => cnasalButton(),
                color: cnasal ? Colors.green : Colors.red,
                padding: EdgeInsets.all(10.0),
                child: Column( // Replace with a Row for horizontal icon + text
                  children: <Widget>[

                    Image.asset("images/Cnasal.PNG",height: 50, width: 50),
                    Text("Congestionamento\nnasal", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.white, fontSize:15) ),
                  ],
                )),]),
                
          SizedBox(height: 40,),
          
          Row(children:[SizedBox(width: 130,),new LinearPercentIndicator(
                width: 140.0,
                lineHeight: 20.0,
                percent: 0.6,
                backgroundColor: Colors.grey,
                progressColor: Colors.green,
                center: new Text(
                  "60 %"
              )),]),

        SizedBox(height: 20),];

      w.add(  new SizedBox(
       width: 200.0,
       height: 50.0,child:RaisedButton(color: Theme.of(context).accentColor,child:Row(children:[ Text("Próximo", style: TextStyle( fontWeight: FontWeight.bold, color: Colors.white, fontSize:15) ), SizedBox(width: 60,),Icon(Icons.arrow_forward,color: Colors.white,)]),onPressed:(){ 

          List<RelSin> relsins = new List<RelSin>();

          RelSin relSin = new RelSin();

              switch(corrimento)
              {
                case true:

                this.widget.answers.add("Sintomas:Corriento:SIM");

                relSin.datasintoma = DateTime.now();
                relSin.idp = this.widget.iduser;
                relSin.ids = 1;

                relsins.add(relSin);

                break;

                case false:

                this.widget.answers.add("Sintomas:Corriento:NÃO");

                break;
              }

              switch(cansaco)
              {
                case true:
                this.widget.answers.add("Sintomas:Cansaço:SIM");

                relSin.datasintoma = DateTime.now();
                relSin.idp = this.widget.iduser;
                relSin.ids = 2;

                relsins.add(relSin);

                break;

                case false:
                this.widget.answers.add("Sintomas:Cansaço:NÃO");
                break;
              }

               switch(diarreia)
              {
                case true:
                this.widget.answers.add("Sintomas:Diarreia:SIM");

                relSin.datasintoma = DateTime.now();
                relSin.idp = this.widget.iduser;
                relSin.ids = 3;

                relsins.add(relSin);


                break;

                case false:
                this.widget.answers.add("Sintomas:Diarreia:NÃO");


                break;
              }

               switch(cnasal)
              {
                case true:
                this.widget.answers.add("Sintomas:Congestão:SIM");

                relSin.datasintoma = DateTime.now();
                relSin.idp = this.widget.iduser;
                relSin.ids = 4;

                relsins.add(relSin);

                break;

                case false:
                this.widget.answers.add("Sintomas:Congestão:NÃO");
                break;
              }

               switch(contacto)
              {
                case true:
                this.widget.answers.add("Sintomas:Contacto:Direto");

                relSin.datasintoma = DateTime.now();
                relSin.idp = this.widget.iduser;
                relSin.ids = 5;

                relsins.add(relSin);

                break;

                case false:
                this.widget.answers.add("Sintomas:Contacto:Indireto");


                break;
              }

               for(int i = 0; i < this.widget.respostas.length; i++)
                {  
                  if(this.widget.respostas[i] == "Sintomas")
                  {
                    this.widget.respostas[i] = "";
                  }

                } 


               if(this.widget.respostas.where((l)=>l == "Medico").length != 0)
                {
                  Future<int> relsinq = relSin.createRelSin(relsins).then((int sc){

                    if(sc == 1)
                    {

                        Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => MedicoQuest(respostas: this.widget.respostas,iduser: this.widget.iduser,answers: this.widget.answers,)),
                              );

                    }

                  
                  });
                   
                }
                else if(this.widget.respostas.where((l)=>l == "Viagem").length != 0)
                {
                   Future<int> relsinq = relSin.createRelSin(relsins).then((int sc){

                    if(sc == 1)
                    {

                        Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Viagem(respostas: this.widget.respostas,iduser: this.widget.iduser,answers: this.widget.answers,)),
                              );

                    }

                  
                  });
                }
                else
                {
                  Future<int> relsinq = relSin.createRelSin(relsins).then((int sc){

                    if(sc == 1)
                    {

                        Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => FatoresDeRiscoQuest(iduser: this.widget.iduser,respostas: this.widget.respostas,answers: this.widget.answers,)),
                              );

                    }

                  
                  });
                }

             },)));

  return w;
}

  contactoButton(){
     setState(() {
   contacto = !contacto;

    });
  }
  
  corrimentoButton(){
     setState(() {
   corrimento = !corrimento;

    });
  }

  cansacoButton(){
     setState(() {
   cansaco = !cansaco;

    });
  }

  diarreiaButton(){
     setState(() {
   diarreia = !diarreia;

    });
  }

  cnasalButton(){
     setState(() {
   cnasal = !cnasal;

    });
  }

}