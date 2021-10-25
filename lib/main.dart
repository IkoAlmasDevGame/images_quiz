import 'dart:io';
import 'package:flutter/material.dart';
import 'model.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
        title: 'Quiz Images Flutter',
        home: QuizImage(),
    );
  }
}

class QuizImage extends StatefulWidget {
  @override
  QuizImageState createState()=> QuizImageState();
}

class QuizImageState extends State<QuizImage>{
  List qList = [
    QuizImages("1.Ini Gambar Apa ?", "lib/images/Bola.JPG", "A.Bola", "B. Hockey", true),
    QuizImages("2.Ini Gambar Apa ?", "lib/images/Apel.JPG", "A.Mangga", "B.Apel", false),
    QuizImages("3.Gambar Apakah ini ?", "lib/images/Kepala.JPG", "A.Kepala", "B.Rambut", true),
    QuizImages("4.Gambar Apakah ini ?", "lib/images/Mulut.JPG", "A.Lidah", "B.Mulut", false),
    QuizImages("5.Gambar Apakah ini ?", "lib/images/Tangan.JPG", "A.Tangan", "B.Siku", true),
  ];

  var counter = 0;
  var score = 0;

  checkWin(bool userChoice, BuildContext context){
    if(userChoice==qList[counter].isCorrect){
      print("Correct");
      score = score+20;
      final snackbar = SnackBar(
        duration: Duration(milliseconds: 200),
        backgroundColor: Colors.green,
        content: Text("Correct!"),
      );
      Scaffold.of(context).showSnackBar(snackbar);
    }else{
      print("false");
      score = score+0;
      final snackbar = SnackBar(
        duration: Duration(milliseconds : 200),
        backgroundColor: Colors.red,
        content: Text("Incorrect!"),
      );
      Scaffold.of(context).showSnackBar(snackbar);
    }
    setState(() {
      if(counter < 4) {
        counter = counter + 1;
      }else if(counter < 4){
        counter = (counter >= 5) as int;
      }else{
        counter = (counter >= 5) as int;
      }
    });
  }
  reset()
  {
    setState(() {
      counter = 0;
      score =0;
    });
  }

  Future<void> _showDialog() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Dilanjutkan Lagi atau tidak permainan game ini ?"),
            content: SingleChildScrollView(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  TextButton(onPressed: (){
                    reset();
                    Navigator.of(context).pop();
                  },
                    child: Text("IYA"),
                  ),
                  Padding(padding: const EdgeInsets.only(left: 2.5)),
                  TextButton(onPressed: (){
                    Navigator.of(context).pop();
                  },
                    child: Text("TIDAK"),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  Future<void> _showDialogScore() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.transparent,
        builder: (BuildContext context){
          return AlertDialog(
            title: const Text("Hasil Nilai Anda"),
            backgroundColor: Color.fromRGBO(85, 100, 75, 1),
            content: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 245,
                    height: 65,
                    decoration: BoxDecoration(
                      border: Border.all(width: 2.0, color: Colors.black87, style: BorderStyle.solid),
                    ),
                    child: Text("\n   Hasil Nilai Latihan Anda : $score", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                  ),
                  Padding(padding: const EdgeInsets.only(bottom: 10.0),),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                        child: Text("OKE", style: TextStyle(fontSize: 14.0),),
                        color: Colors.black87,
                        colorBrightness: Brightness.dark,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz Image Flutter", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, fontFamily: "ARIAL")),
        centerTitle: true,
        backgroundColor: Colors.blue[400],
      ),
      backgroundColor: Colors.yellow[700],
      body: Builder(
        builder: (BuildContext context)=> Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                  border: Border.all(width: 1.2, color: Colors.black87, style: BorderStyle.solid),
                ),
                child: Image.asset(qList[counter].Gambar, width: 300, height: 300, fit: BoxFit.cover,),
              ),
              Padding(padding: EdgeInsets.only(top: 30)),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    InkWell(
                      child: Text("Hasil Score", style: TextStyle(fontSize: 18,color: Colors.redAccent,fontWeight: FontWeight.bold),),
                      onTap: _showDialogScore,
                    ),
                    InkWell(
                      child: Text("Reset Game",style: TextStyle(fontSize: 18,color: Colors.redAccent,fontWeight: FontWeight.bold),),
                      onTap: _showDialog,
                    )
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 30)),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: Color(0xFFF7C229))
                ),
                height: 90.0,
                width: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FittedBox(child: Text(qList[counter].Exercise,style: TextStyle(fontSize: 18.0,)),)
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 30)),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  RaisedButton(onPressed:()=> checkWin(true, context),
                    padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    child: Text(qList[counter].JawabanA,style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                    color:  Color.fromRGBO(47, 79, 79, 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                ],
              ),
              Padding(padding: const EdgeInsets.only(bottom: 2.5)),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  RaisedButton(onPressed: ()=> checkWin(false,context),
                    padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    child: Text(qList[counter].JawabanB,style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                    color: Color.fromRGBO(105, 105, 105, 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            ListTile(
              title: Text("Exit Game"),
              trailing: Icon(Icons.exit_to_app),
              selected: false,
              onTap: ()=> exit(0),
            ),
          ],
        ),
      ),
    );
  }
}