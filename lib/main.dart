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
      theme: _ticTheam,
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
          child: Text('Tic Tac Toe',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Color(0xFFC5032B), fontSize: 60)),
          flex: 20,
        ),
        ExpandedBox(5),
        Expanded(
          child: FloatingActionButton(
            child: Icon(Icons.play_arrow, size: 50),
            foregroundColor: Color(0xFFC5032B),
            backgroundColor: Color(0xFFFEEAE6),
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
                foregroundColor: Color(0xFFC5032B),
                backgroundColor: Color(0xFFFEEAE6),
                heroTag: 'info',
                onPressed: () {
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
    ));
  }
}

final ThemeData _ticTheam = _buildTicTheam();

ThemeData _buildTicTheam() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    accentColor: ticColor300,
    primaryColor: ticColor100,
    buttonTheme: base.buttonTheme.copyWith(
      buttonColor: ticColor400,
      // textTheme: ButtonTextTheme.normal,
    ),
    scaffoldBackgroundColor: ticBackgroundWhite,
    cardColor: ticBackgroundWhite,
    textSelectionColor: ticColor,
    errorColor: ticErrorRed,
  );
}
