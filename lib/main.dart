import 'package:flutter/material.dart';

import './widgets/colors.dart';
import 'game.dart';
import 'credits.dart';
import './widgets/expandedbox.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, WidgetBuilder>{
        '/game': (BuildContext context) => new MyGame(),
        '/credits': (BuildContext context) => new Credits()
      },
      home: TicTacToeGame(),
      theme: buildTicTheme(),
    );
  }

  ThemeData buildTicTheme() {
    final ThemeData base = ThemeData.light();
    var theme = selectTheme(0);
    return base.copyWith(
      primaryColor: theme.primary,
      accentColor: theme.accent,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: theme.fbColor,
        foregroundColor: theme.ffColor
      ),
      buttonColor: theme.ffColor,
      textTheme: base.textTheme.copyWith(
        title: TextStyle(
          color: theme.primary,
          fontWeight: FontWeight.bold,
          fontSize: 60,
        ),
        subtitle: TextStyle(
          fontWeight: FontWeight.bold,
          color: theme.stColor,
          fontSize: 50
        ),
        display1: TextStyle(
          fontSize: 25,
          color: theme.accent
        )
      ),
      scaffoldBackgroundColor: theme.backgroud,
    );
  }
}

class TicTacToeGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Flex(
      direction: Axis.vertical,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        ExpandedBox(20),
        Expanded(
          child: Text(
            'Tic Tac Toe',
            style: Theme.of(context).textTheme.title,
          ),
          flex: 20,
        ),
        ExpandedBox(5),
        Expanded(
          child: FloatingActionButton(
            child: Icon(
              Icons.play_arrow, 
              size: 50,
            ),
            foregroundColor: Theme.of(context).accentColor,
            backgroundColor: Theme.of(context).floatingActionButtonTheme.foregroundColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0))),
            heroTag: 'play',
            onPressed: () {
              Navigator.pushNamed(context, '/game');
            },
          ),
          flex: 15,
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
                onPressed: () {
                  Navigator.pushNamed(context, '/credits');
                },
              ),
              flex: 10,
            ),
            ExpandedBox(5),
          ],
        ),
        ExpandedBox(5)
      ],
    ));
  }
}


