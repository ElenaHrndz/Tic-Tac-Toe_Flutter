import 'package:flutter/material.dart';

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

  ///This is the button you press to set a value
  Widget gameButton(int numberOfRow, int numberOfColum) {
    String coordenates = '$numberOfColum,$numberOfRow';
    return FlatButton(
      onPressed: () => printSomething(coordenates),
      child: positions[coordenates] != ''
          ? Icon(positions[coordenates] == 'x'
              ? Icons.brightness_5
              : Icons.brightness_3)
          : Icon(null),
      color: Colors.green,
      textColor: Colors.yellow,
  
      padding: EdgeInsets.all(45.0),
    );
  }
  
  Widget gameRow(int numberOfRow){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[gameButton(numberOfRow, 0), gameButton(numberOfRow, 1), gameButton(numberOfRow, 2)],
    );
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
      body: Center(
        child: !itsGameFinish ? Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            gameRow(2),
            gameRow(1),
            gameRow(0)
          ],
        ): Text(hasAWinner?"Some one win":"Its a tie")
      ),
    );
  }
}
