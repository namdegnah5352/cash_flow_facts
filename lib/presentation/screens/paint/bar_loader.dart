import 'package:flutter/material.dart';

class BarLoader{
  double height;
  double value; //can this be null?
  String label; // can this be null?

  BarLoader({ 
    required this.height,
    required this.value,
    required this.label,
  });
}