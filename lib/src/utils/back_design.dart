import 'package:flutter/material.dart';
import 'dart:math';

class BackDesign extends StatelessWidget {  
  @override
  Widget build(BuildContext context) {
    final gradiente = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromRGBO(213, 239, 250, 1.0),
            Color.fromRGBO(101, 154, 176, 1.0)
          ]
        )
      ),
    );

    final cajaRosa = Transform.rotate(
      angle: -pi / 5.0,
      child: Container(
        height: 360.0,
        width: 360.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(80.0),
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(83, 123, 139, 1.0),
              Color.fromRGBO(74, 110, 125, 1.0)
            ]
          )
        ),
      ),
    );

    return Stack(
      children: [
        gradiente,
        Positioned(
          top: -100,
          child: cajaRosa
        )
      ],
    );
  }
}