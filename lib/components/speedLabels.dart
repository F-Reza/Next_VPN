import 'package:flutter/material.dart';

import '../constants/palette.dart';

Text showLabel(String label, double speed, String unit) {
  String displaySpeed = speed.toStringAsFixed(2);
  return Text(
    '$label Speed: $displaySpeed $unit',
    style: TextStyle(
      color: txtCol,
      fontWeight: FontWeight.bold,
      fontSize: 16,
    ),
  );
}
