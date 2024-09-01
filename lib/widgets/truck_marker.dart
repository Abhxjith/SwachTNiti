// lib/widgets/truck_marker.dart

import 'package:flutter/material.dart';

class TruckMarker extends StatelessWidget {
  final Color color;
  final double size;

  TruckMarker({this.color = Colors.red, this.size = 40});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Icon(Icons.local_shipping, color: color, size: size),
    );
  }
}
