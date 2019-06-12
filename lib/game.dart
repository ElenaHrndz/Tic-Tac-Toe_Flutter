import 'package:flutter/material.dart';

import './widgets/expandedbox.dart';

class MyGame extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyGameState();
  }
}

class _MyGameState extends State<StatefulWidget> {
  Map<String, String> positions = new Map<String, String>();
  List<String> strings = new List<String>(9);
  bool isX = true;
  bool hasAWinner = false;
  bool itsGameFinish = false;

  void printSomething(String coordenates) {
    if (positions[coordenates] == '') {
      if (isX) {
        positions[coordenates] = 'x';
      } else {
        positions[coordenates] = 'o';
      }
      isX = !isX;
      hasAWinner = theresAMatch(coordenates);
      if(!positions.containsValue('') || hasAWinner){
        itsGameFinish = true;
      }
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    clearField();
  }

  void clearField() {
    positions.clear();
    hasAWinner = false;
    itsGameFinish = false;
    for (int i = 0; i < 3; i++) {
      for(int j = 0; j < 3;j++){
        int x = i;
        int y = j;
        String s = '$x,$y';
        positions[s] = '';
      }
    }
    setState(() {});
  }

  bool theresAMatch(String coordenateString){
    if(hasAVerticalMatch(coordenateString)){
      return true;
    }
    if(hasAHorizontalMatch(coordenateString)){
      return true;
    }
    if(hasADiagonalMatch(coordenateString)){
      return true;
    }
    return false;
  }

  bool hasADiagonalMatch(String coordenateString){
    var value = positions[coordenateString];

    bool hasCondition = true;

    for(int i = 0; i< 3;i++){
      if(positions['$i,$i'] != value){
        hasCondition = false;
      }
    }
    if(!hasCondition){
      hasCondition = true;
      for(int i=0; i< 3;i++){
        int yValue = 2-i;
        if(positions['$i,$yValue'] != value){
          return false;
        }
      }
    }

    return hasCondition;
  }


  bool hasAVerticalMatch(String coordenateString){
    var coordenates = coordenateString.split(',');
    var value = positions[coordenateString];

    for(int i = 0; i < 3; i++){
      if(positions['${coordenates[0]},$i'] != value){
        return false;
      }
    }
    return true;
  }

  bool hasAHorizontalMatch(String coordenateString){
    var coordenates = coordenateString.split(',');
    var value = positions[coordenateString];
    for(int i = 0; i < 3; i++){
      if(positions['$i,${coordenates[1]}'] != value){
        return false;
      }
    }
    return true;
  }

  IconData iconToSet(String sign){
    return sign == 'x'?Icons.brightness_5:Icons.brightness_3;
  }

  ///This is the button you press to set a value
  Widget gameButton(int numberOfRow, int numberOfColum) {
    String coordenates = '$numberOfColum,$numberOfRow';
    return Expanded(
      flex: 35,
      child: Container(
        height: MediaQuery.of(context).size.height/5.5,
        child: FlatButton(
          onPressed: () => printSomething(coordenates),
          child: positions[coordenates] != ''
              ? Icon(iconToSet(positions[coordenates]))
              : Icon(null),
          color: Colors.green,
          textColor: Colors.yellow,
        ),
      )
    );
  }
  
  Widget gameRow(int numberOfRow){
    return Expanded(
      flex: 30,
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[gameButton(numberOfRow, 0), ExpandedBox(12), gameButton(numberOfRow, 1), ExpandedBox(12),gameButton(numberOfRow, 2)],
      )
    );
  }

  List<Widget> winObjects(){
    return <Widget> [
      Text('The winer is:'),
      ExpandedBox(5),
      Icon(isX? Icons.brightness_3:Icons.brightness_5)
    ];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic-Tac-Toe'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.replay),
            tooltip: 'Replay',
            onPressed: clearField,
          ),
        ],
      ),
      body:  Center(
        child: !itsGameFinish ? Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            gameRow(2),
            gameRow(1),
            gameRow(0)
          ],
        ): Flex(
          direction: Axis.vertical,
          children: hasAWinner?winObjects():<Widget>[
            Text('its a tie')
          ],
        )
      ),
    );
  }
}
