import 'package:flutter/material.dart';


class Methods {
  static pageNavigate(context,page) {
    Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context)=> page));
  }
}