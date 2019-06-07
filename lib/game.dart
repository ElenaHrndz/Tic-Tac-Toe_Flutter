import 'package:flutter/material.dart';

class MyGame extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyGameState();
  }
}

class _MyGameState extends State<StatefulWidget> {
  List<String> strings = new List<String>(9);
  bool isX = true;

  void printSomething(int number) {
    if (strings[number] == '') {
      if (isX) {
        strings[number] = 'x';
      } else {
        strings[number] = 'o';
      }
      isX = !isX;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    clearField();
  }

  void clearField() {
    for (int i = 0; i < 9; i++) {
      strings[i] = '';
    }
    setState(() {});
  }

  Widget gameButton(int numberToSet) {
    return FlatButton(
      onPressed: () => printSomething(numberToSet),
      child: strings[numberToSet] != ''
          ? Icon(strings[numberToSet] == 'x'
              ? Icons.brightness_5
              : Icons.brightness_3)
          : Icon(null),
      color: Color(0xFF84A2AF),
      textColor: Colors.blue,
      padding: EdgeInsets.all(50.0),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[gameButton(0), gameButton(1), gameButton(2)],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[gameButton(3), gameButton(4), gameButton(5)],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[gameButton(6), gameButton(7), gameButton(8)],
            )
          ],
        ),
      ),
      /*bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              title: Text('Business'),
            )
          ],
          // currentIndex: _selectedIndex,
          // selectedItemColor: Colors.amber[800],
          // onTap: _onItemTapped,
        ),*/
    );
  }
}
