import 'package:flutter/material.dart';
import 'package:travel/core/plugin/asr_plugin.dart';

class GLSearchContent extends StatefulWidget {
  @override
  _GLSearchContentState createState() => _GLSearchContentState();
}

class _GLSearchContentState extends State<GLSearchContent> {
  String asrContent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 40),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(asrContent ?? '百度AI语音识别', style: TextStyle(fontSize: 17),),
          GestureDetector(
            onTapDown: (details) {
              print('按下');
              GLASRPlugin.start().then((value) {
                print(value);
              });
            },
            onTapUp: (details) {
              print('抬起');
              GLASRPlugin.stop().then((value) {
                print(value);
              });
            },
            onTapCancel: () {
              print('取消');
              GLASRPlugin.cancel().then((value) {
                print(value);
              });
            },
            child: Column(
              children: <Widget>[
                Text('长按说话'),
                SizedBox(height: 5,),
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    color: Colors.lightBlue,
                    boxShadow: [
                      BoxShadow(color: Colors.lightBlueAccent, blurRadius: 15, spreadRadius: 1)
                    ]
                  ),
                  child: Icon(Icons.mic, size: 50, color: Colors.white,),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
