// ignore_for_file: file_names, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';



class MyCustomButton extends StatelessWidget {
  final btnTxt,methods,color,size;

  const MyCustomButton({Key? key, this.btnTxt, this.methods, this.color, this.size}) : super(key: key);
  //const MyCustomButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: methods,
        child: Text(btnTxt,style: TextStyle(color:color,fontSize: size),),
    );
  }
}
