// ignore_for_file: file_names, prefer_const_constructors


import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'const/Methods.dart';
import 'main.dart';

class MyLocation extends StatefulWidget {
   MyLocation({Key? key}) : super(key: key);

  @override
  _MyLocationState createState() => _MyLocationState();
}

class _MyLocationState extends State<MyLocation> {
  final List<_PositionItem> _positionItems = <_PositionItem>[];
  StreamSubscription<Position>? _positionStreamSubscription;

/*
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }
    return await Geolocator.getCurrentPosition();
  }
*/


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        return Methods.pageNavigate(context,CommonAppList());
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: ListView.builder(
          itemCount: _positionItems.length,
          itemBuilder: (context, index) {
            final positionItem = _positionItems[index];

            if (positionItem.type == _PositionItemType.permission) {
              return ListTile(
                title: Text(positionItem.displayValue,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )),
              );
            } else {
              return Card(
                child: ListTile(
                  tileColor: Colors.green,
                  title: Text(
                    positionItem.displayValue,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
            }
          },
        ),
        floatingActionButton: Stack(
          children: <Widget>[
            Positioned(
              bottom: 80.0,
              right: 10.0,
              child: FloatingActionButton.extended(
                onPressed: () async {
                  await Geolocator.getLastKnownPosition().then((value) => {
                    _positionItems.add(_PositionItem(
                        _PositionItemType.position, value.toString()))
                  });

                  setState(
                        () {},
                  );
                },
                label: Text("getLastKnownPosition"),
              ),
            ),
            Positioned(
              bottom: 10.0,
              right: 10.0,
              child: FloatingActionButton.extended(
                  onPressed: () async {
                    await Geolocator.getCurrentPosition().then((value) => {
                      _positionItems.add(_PositionItem(
                          _PositionItemType.position, value.toString()))
                    });

                    setState(
                          () {},
                    );
                  },
                  label: Text("getCurrentPosition")),
            ),
            Positioned(
              bottom: 150.0,
              right: 10.0,
              child: FloatingActionButton.extended(
                onPressed: _toggleListening,
                label: Text(() {
                  if (_positionStreamSubscription == null) {
                    return "getPositionStream = null";
                  } else {
                    return "getPositionStream ="
                        " ${_positionStreamSubscription!.isPaused ? "off" : "on"}";
                  }
                }()),
                backgroundColor: _determineButtonColor(),
              ),
            ),
            Positioned(
              bottom: 220.0,
              right: 10.0,
              child: FloatingActionButton.extended(
                onPressed: () => setState(_positionItems.clear),
                label: Text("clear positions"),
              ),
            ),
            Positioned(
              bottom: 290.0,
              right: 10.0,
              child: FloatingActionButton.extended(
                onPressed: () async {
                  await Geolocator.checkPermission().then((value) => {
                    _positionItems.add(_PositionItem(
                        _PositionItemType.permission, value.toString()))
                  });
                  setState(() {});
                },
                label: Text("getPermissionStatus"),
              ),
            ),
          ],
        ),
      ),
    );
  }
  bool _isListening() => !(_positionStreamSubscription == null ||
      _positionStreamSubscription!.isPaused);

  Color _determineButtonColor() {
    return _isListening() ? Colors.green : Colors.red;
  }
  void _toggleListening() {
    if (_positionStreamSubscription == null) {
      final positionStream = Geolocator.getPositionStream();
      _positionStreamSubscription = positionStream.handleError((error) {
        _positionStreamSubscription?.cancel();
        _positionStreamSubscription = null;
      }).listen((position) => setState(() => _positionItems.add(
          _PositionItem(_PositionItemType.position, position.toString()))));
      _positionStreamSubscription?.pause();
    }

    setState(() {
      if (_positionStreamSubscription!.isPaused) {
        _positionStreamSubscription?.resume();
      } else {
        _positionStreamSubscription?.pause();
      }
    });
  }

  @override
  void dispose() {
    if (_positionStreamSubscription != null) {
      _positionStreamSubscription?.cancel();
      _positionStreamSubscription = null;
    }

    super.dispose();
  }
}
enum _PositionItemType {
  permission,
  position,
}

class _PositionItem {
  _PositionItem(this.type, this.displayValue);

  final _PositionItemType type;
  final String displayValue;
}
