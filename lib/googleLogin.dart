// ignore_for_file: file_names, prefer_const_constructors, unused_field, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'const/Methods.dart';
import 'const/customWidgets.dart';
import 'main.dart';




class GoogleLogin extends StatefulWidget {
  const GoogleLogin({Key? key}) : super(key: key);

  @override
  _GoogleLoginState createState() => _GoogleLoginState();
}

class _GoogleLoginState extends State<GoogleLogin> {

  bool _isLoggedIn = false;
  //final Map _userObj = {};
  late GoogleSignInAccount _userObj;
  GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        return Methods.pageNavigate(context,CommonAppList());
      },
      child: Scaffold(
        body: Container(
          child:Center(
            child: _isLoggedIn ?
            Column(
              children:[
                SizedBox(height:100),
                Image.network(_userObj.photoUrl.toString()),
                Text(_userObj.displayName.toString()),
                Text(_userObj.email),
                MyCustomButton(
                  color: Colors.white,
                  size: 20.0,
                   btnTxt: 'Log Out',
                  methods: (){
                    print('google sign in');
                    _googleSignIn.signOut().then((value){
                      setState(() {
                        _isLoggedIn = false;
                      });
                    }).catchError((e) {
                    });
                  },
                ),
              ]
            )
                :
            Center(
              child:MyCustomButton(
                color: Colors.white,
                size: 20.0,
                btnTxt: 'Login With Google',
                methods: (){
                  print('google sign in');
                  _googleSignIn.signIn().then((userData){
                    setState(() {
                      _isLoggedIn = true;
                      _userObj = userData!;
                    });
                  } ).catchError((e) {
                    print(e);
                  });
                },
              ),
            ),
          )
        ),
      ),
    );
  }
}
