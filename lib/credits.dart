import 'package:flutter/material.dart';

class Credits extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Credits'),
      ),
        body:Container(
        alignment: Alignment.center,
        child: Text(
          'Made by\n\nMaria Elena Hernandez Payan',
          style: Theme.of(context).textTheme.title,
          textAlign: TextAlign.center,
        ),
      ),
    );

  }
}