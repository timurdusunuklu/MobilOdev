import 'package:flutter/material.dart';

class OyModel extends ChangeNotifier{
  late var value;

  valRead(){
    return value;
  }

  void valChange(var val){
    value = val;
    notifyListeners();
  }
}