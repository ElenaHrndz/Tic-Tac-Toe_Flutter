import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State<StatefulWidget> {
  List<String> strings = new List<String>(9);
  bool isX = true;

  void printSomething(int number){
    if(strings[number] == ''){
      if(isX){
        strings[number] = 'x';
      }
      else
      {
        strings[number] = 'o';
      }
      isX = !isX;
      print(strings[number]);
      setState(() {
        
      });
    }

  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for(int i = 0; i < 9;i++){
      strings[i] = '';
    }
  }

  Widget gameButton(int numberToSet){
    return RaisedButton(
      onPressed: ()=>printSomething(numberToSet),
      child: Text(
        strings[numberToSet]
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Tic-Tac-Toe'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  gameButton(0),
                  gameButton(1),
                  gameButton(2)
                ],
              ),
              Row(
                children: <Widget>[
                  gameButton(3),
                  gameButton(4),
                  gameButton(5)
                ],
              ),
              Row(
                children: <Widget>[
                  gameButton(6),
                  gameButton(7),
                  gameButton(8)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
