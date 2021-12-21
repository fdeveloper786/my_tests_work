// ignore_for_file: unused_field, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:contact_picker/contact_picker.dart';
import 'package:tests_app/const/Methods.dart';
import 'package:tests_app/const/customWidgets.dart';
import 'package:tests_app/const/facebookLogin.dart';

import 'currentLocation.dart';
import 'googleLogin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  CommonAppList()//GoogleLogin()//MyLocation(),//MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class CommonAppList extends StatefulWidget {
  const CommonAppList({Key? key}) : super(key: key);

  @override
  _CommonAppListState createState() => _CommonAppListState();
}

class _CommonAppListState extends State<CommonAppList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Common App List'),
      ),
      body: Container(
        color:Colors.greenAccent.withOpacity(0.5),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 20.0,),
              // Contact
              MyCustomButton(
                btnTxt: 'Contact Picker',
                size: 20.0,
                color: Colors.white,
                methods: (){
                  Methods.pageNavigate(context,MyHomePage());
                },
              ),
              // My Location
              MyCustomButton(
                btnTxt: 'Current Location',
                size: 20.0,
                color: Colors.white,
                methods: (){
                  Methods.pageNavigate(context,MyLocation());
                  //MyHomePage(title: "Contact Picker App",);
                },
              ),
              // Google Login
              MyCustomButton(
                btnTxt: 'Google Login',
                size: 20.0,
                color: Colors.white,
                methods: (){
                  Methods.pageNavigate(context,GoogleLogin());
                  //MyHomePage(title: "Contact Picker App",);
                },
              ),
              // Facebook login
              MyCustomButton(
                btnTxt: 'Facebook Login',
                size: 20.0,
                color: Colors.white,
                methods: (){
                  Methods.pageNavigate(context,FacebookLogin());
                  //MyHomePage(title: "Contact Picker App",);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  final ContactPicker _contactPicker = ContactPicker();
   Contact? _contact;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        return Methods.pageNavigate(context,CommonAppList());
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              MaterialButton(
                color: Colors.blue,
                child: Text("CLICK ME"),
                onPressed: () async {
                  Contact contact = await _contactPicker.selectContact();
                  setState(() {
                    _contact = contact;
                  });
                },
              ),
              Text(
                _contact == null ? 'No contact selected.' : _contact.toString(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
