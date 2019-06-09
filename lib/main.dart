import 'package:flutter/material.dart';

import 'game.dart';
import 'credits.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        buttonColor: Colors.green,
        backgroundColor: Colors.blue,
        primaryColor: Colors.black,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.green
        )
      ),
      routes: <String, WidgetBuilder>{
        '/game': (BuildContext context) => new MyGame(),
        '/credits': (BuildContext context)=> new Credits()
      },
      home: TicTacToeGame(),
    );
  }
}

class TicTacToeGame extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
            SizedBox(
              height: 150.0,
            ),
            Text(
              'Tic-Tac-Toe',
              style: TextStyle(
                fontSize: 80
              ),
            ),
            SizedBox(
              height: 100.0,
            ),
            RaisedButton(
              child: Icon(
                Icons.play_arrow,
                size: 60,
              ),
              onPressed:(){
                Navigator.pushNamed(context, '/game');
              },
            ),
            SizedBox(
              height: 100.0,
            ),
            Align(
              child:FloatingActionButton(
                child: Icon(
                  Icons.info
                ),
                onPressed: (){
                  Navigator.pushNamed(context, '/credits');
                },
              ),
              alignment: Alignment.bottomRight,
            )

          ],
        ),
      )
    );
  }
}