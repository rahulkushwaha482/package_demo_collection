import 'package:flutter/material.dart';

class ColorContainer extends StatelessWidget {
  const ColorContainer(
      {Key? key, required this.childContainer, required this.colordContainer})
      : super(key: key);

  final Widget childContainer;
  final Color colordContainer;

  @override
  Widget build(BuildContext context) {
    return Center(
          child: Container(
        height: 50,
        width: 200,
        decoration: BoxDecoration(
            color: colordContainer ?? Colors.greenAccent,
            border: Border.all(width: 2, color: Colors.black)),
        child: Center(child: childContainer),
      )
    );
  }
}
