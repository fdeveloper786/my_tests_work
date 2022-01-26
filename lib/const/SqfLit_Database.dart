// ignore_for_file: file_names, prefer_const_constructors, avoid_unnecessary_containers

import 'dart:async';
import 'dart:convert';

import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:tests_app/Models/Model_Comments.dart';
import 'package:tests_app/Models/Model_Photos.dart';
import '../main.dart';
import 'Methods.dart';
import 'package:http/http.dart' as http;

import 'customWidgets.dart';




class SqfLiteDatabase extends StatefulWidget {
  const SqfLiteDatabase({Key? key}) : super(key: key);

  @override
  _SqfLiteDatabaseState createState() => _SqfLiteDatabaseState();
}

class _SqfLiteDatabaseState extends State<SqfLiteDatabase> {
  String myApi = 'https://jsonplaceholder.typicode.com/photos';
  String commentsApi = 'https://jsonplaceholder.typicode.com/comments';
  bool load = false;
  List myPhotoList = [];
  List myCommentsList = [];
  Timer? timer;
  Future<List>? stream;

  getDataFromApi() async {
    
    var isCacheExist = await APICacheManager().isAPICacheKeyExist('API_Photos');

    if(!isCacheExist) {
      print('API HIT');
      http.Response response = await http.get(Uri.parse(myApi));
      var data = jsonDecode(response.body);
      if(response.statusCode == 200){
        APICacheDBModel cacheDBModel = new APICacheDBModel(
          key : "API_Photos",
          syncData : response.body,
        );
        await APICacheManager().addCacheData(cacheDBModel);

        var modelPhoto = data.map((element) =>Model_Photo.fromJson(element)).toList();
        print('model ${modelPhoto[0].title}');
        setState(() {
          load = true;
          myPhotoList = modelPhoto;
        });
        print('api data ${myPhotoList[2].id}');
      }
    }else {
      print('Cache HIT');
      var cacheData = await APICacheManager().getCacheData("API_Photos");
      var data = jsonDecode(cacheData.syncData);
      var modelPhoto = data.map((element) =>Model_Photo.fromJson(element)).toList();
      setState(() {
        load = true;
      });
      myPhotoList = modelPhoto;
      debugPrint('cache data ${myPhotoList.length}');
    }

  }

  getComments() async {
    var isCacheExist = await APICacheManager().isAPICacheKeyExist('API_Comments');
    if(!isCacheExist) {
      print('API HIT');
      http.Response response = await http.get(Uri.parse(commentsApi));
      var data = jsonDecode(response.body);
      if(response.statusCode == 200){
        APICacheDBModel cacheDBModel = new APICacheDBModel(
          key : "API_Comments",
          syncData : response.body,
        );
        await APICacheManager().addCacheData(cacheDBModel);

        var modelComments = data.map((element) =>Model_Comments.fromJson(element)).toList();
        print('model ${modelComments[0].email}');
        setState(() {
          load = true;
          myCommentsList = modelComments;
        });
        print('api data ${myCommentsList[2].postId}');
      }
    }else {
      print('Cache HIT');
      var cacheData = await APICacheManager().getCacheData("API_Comments");
      var data = jsonDecode(cacheData.syncData);
      var modelComments = data.map((element) =>Model_Comments.fromJson(element)).toList();
      setState(() {
        load = true;
      });
      myCommentsList = modelComments;
      debugPrint('cache data ${myCommentsList.length}');
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getComments();
    //stream = getComments();
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        return Methods.pageNavigate(context,CommonAppList());
      },
      child: Scaffold(
        appBar: AppBar(
          title:Text('Local Database'),
          automaticallyImplyLeading: true,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Center(
            child:Column(
              children: [
                Text('Local Database'),
                SizedBox(height:20.0),
                Row(
                  children: [
                    //deleteCache(keyName)
                    Expanded(
                      flex: 2,
                      child: MyCustomButton(
                        btnTxt: 'Get Data from API',
                        size: 15.0,
                        color: Colors.white,
                        methods: (){
                          //getDataFromApi();
                          getComments();
                        },
                      ),
                    ),
                    SizedBox(width: 10.0,),
                    Expanded(
                      child: MyCustomButton(
                        btnTxt: 'Delete Cache',
                        size: 10.0,
                        color: Colors.white,
                        methods: (){

                          APICacheManager().deleteCache('API_Comments');
                          print('delete cache called');
                        },
                      ),
                    ),
                    SizedBox(width: 10.0,),
                    Expanded(
                      child: MyCustomButton(
                        btnTxt: 'Empty Cache',
                        size: 10.0,
                        color: Colors.white,
                        methods: (){
                          APICacheManager().emptyCache();
                          print('empty cached called');
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height:10.0),
                myCommentsList != null ? listFromApi() : CircularProgressIndicator()
                //streamList()
              ],
            )
          ),
        ),
      ),
    );
  }


  Widget listFromApi(){
    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: myCommentsList == null ? 0 : myCommentsList.length,
      itemBuilder: (context,index) {
        return Card(
          elevation: 5.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Post Id : ${myCommentsList[index].postId.toString()}'),
                SizedBox(height:10.0),
                Text('Name : ${myCommentsList[index].name}'),
                SizedBox(height:10.0),
                Text('Email : ${myCommentsList[index].email.toString()}'),
                SizedBox(height:10.0),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget streamList(){
    return StreamBuilder(
      stream: Stream.periodic(
        Duration(seconds:10)).asyncMap((event){
          getComments();
          print('event is $event');
      }),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        debugPrint('has data ${snapshot.hasData}');
        if (snapshot.data != null) {
          return Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                print('snapshot data ${snapshot.data}');
                return ListTile(
                  title: Text(snapshot.data[index]),
                  onTap: () {
                    print('tapped');
                    //Navigator.of(context).push(DetailScreenDart(snapshot.data[index]));
                  },
                );
              },
            ),
          );
        }
        else {
          return CircularProgressIndicator();
        }
      }
    );
  }

}





