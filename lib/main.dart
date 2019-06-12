import 'package:flutter/material.dart';

import 'game.dart';
import 'credits.dart';
import './widgets/expandedbox.dart';

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
      body: Flex(
        direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ExpandedBox(20),
          Expanded(
            child: Text('Tic Tac Toe'),
            flex: 20,
          ),
          ExpandedBox(5),
          Expanded(
            child: FloatingActionButton(
              child: Icon(Icons.play_arrow),
              heroTag: 'play',
              onPressed:(){
                Navigator.pushNamed(context, '/game');
              },
            ),
            flex: 20,
          ),
          ExpandedBox(10),
          Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              ExpandedBox(85),
              Expanded(
                child: FloatingActionButton(
                  child: Icon(Icons.info),
                  heroTag: 'info',
                  onPressed:(){
                    Navigator.pushNamed(context, '/credits');
                  },
                ),
                flex: 10,
              ),
              ExpandedBox(5)
            ],
          ),
          ExpandedBox(5)
        ],
      )
    );
  }
}