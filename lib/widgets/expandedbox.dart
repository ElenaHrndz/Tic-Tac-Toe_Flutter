import 'package:flutter/material.dart';

class ExpandedBox extends StatelessWidget{
  final int flexSize;

  ExpandedBox(this.flexSize);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
      ),
      flex: flexSize,
    );
  }
}