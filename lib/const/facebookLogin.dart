// ignore_for_file: file_names, prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

import '../main.dart';
import 'Methods.dart';




class FacebookLogin extends StatefulWidget {
  FacebookLogin({Key? key}) : super(key: key);

  @override
  _FacebookLoginState createState() => _FacebookLoginState();
}

class _FacebookLoginState extends State<FacebookLogin> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: (){
          return Methods.pageNavigate(context,CommonAppList());
        },
        child: Scaffold(
          body:Container(
            color:Colors.blue,
            child:Center(
              child:Text('facebook login')
            )
          )
        )
    );
  }
}
