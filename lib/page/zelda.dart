// ignore_for_file: avoid_unnecessary_containers, unnecessary_brace_in_string_interps, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class ZeldaWalk extends StatelessWidget {
  final bool isZeldaWalk;
  final String direction;
  ZeldaWalk({required this.isZeldaWalk, required this.direction});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        isZeldaWalk
            ? "assets/zelda/${direction}-1.png"
            : "assets/zelda/${direction}-2.png",
        fit: BoxFit.contain,
      ),
    );
  }
}
