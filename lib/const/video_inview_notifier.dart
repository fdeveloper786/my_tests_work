import 'package:flutter/material.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:tests_app/const/video_widget.dart';

class AutoplayVideo extends StatefulWidget {
  AutoplayVideo({Key? key}) : super(key: key);

  @override
  _AutoplayVideoState createState() => _AutoplayVideoState();
}

class _AutoplayVideoState extends State<AutoplayVideo> {
  String videoUrl =
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Inview Notifier List Example'),
        ),
        body: Container(child: VideoList()));
  }
}

class VideoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        InViewNotifierList(
          scrollDirection: Axis.vertical,
          initialInViewIds: ['0'],
          isInViewPortCondition:
              (double deltaTop, double deltaBottom, double viewPortDimension) {
            return deltaTop < (0.5 * viewPortDimension) &&
                deltaBottom > (0.5 * viewPortDimension);
          },
          itemCount: 10,
          builder: (BuildContext context, int index) {
            return Container(
              width: double.infinity,
              height: 300.0,
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(vertical: 50.0),
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return InViewNotifierWidget(
                    id: '$index',
                    builder:
                        (BuildContext context, bool isInView, Widget? child) {
                      return VideoWidget(
                          play: isInView,
                          url:
                              'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4');
                    },
                  );
                },
              ),
            );
          },
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            height: 1.0,
            color: Colors.transparent,
          ),
        )
      ],
    );
  }
}
