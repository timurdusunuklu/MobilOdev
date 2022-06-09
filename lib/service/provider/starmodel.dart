import 'package:flutter/material.dart';

class StarModel extends ChangeNotifier{
  late double value = 0.0;

  double valRead(){
    return value;
  }

  void valChange(double val){
    value = val;
    notifyListeners();
  }
}