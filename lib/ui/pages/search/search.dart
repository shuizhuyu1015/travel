import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:travel/core/plugin/share_plugin.dart';
import 'search_content.dart';

class GLSearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('搜索'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.share), onPressed: () {
            _showShare();
          })
        ],
      ),
      body: GLSearchContent(),
    );
  }

  void _showShare() {
    GLSharePlugin.showShare().then((value) {
      if(value){
        Fluttertoast.showToast(
          msg: '分享成功',
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.black45
        );
      }
    });
  }
}
