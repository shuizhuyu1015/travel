import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:travel/core/services/config.dart';

class GLWebView extends StatefulWidget {
  static const String routeName = '/webview';

  final String title;
  final String url;
  final String statusBarColor;
  final bool hideAppBar;
  final bool backForbid;

  GLWebView({this.title, this.url, this.statusBarColor, this.hideAppBar = false, this.backForbid = false});

  @override
  _GLWebViewState createState() => _GLWebViewState();
}

class _GLWebViewState extends State<GLWebView> {
  final webViewReference = FlutterWebviewPlugin();
  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;
  StreamSubscription<WebViewHttpError> _onHttpError;

  bool _isExiting = false; // 防止重复退出

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    webViewReference.close();
    // 监听
    _onUrlChanged = webViewReference.onUrlChanged.listen((String url) {
//      print(url);
    });
    _onStateChanged = webViewReference.onStateChanged.listen((WebViewStateChanged state) {
      print('${state.type}, ${state.url}, ${state.navigationType}');
      switch(state.type) {
        case WebViewState.shouldStart:
          if(_isToMain(state.url) && !_isExiting) {
            if(widget.backForbid) {
              webViewReference.launch(widget.url);
            }else{
              Navigator.of(context).pop();
              _isExiting = true;
            }
          }
          break;
        default:
          break;
      }
    });
    _onHttpError = webViewReference.onHttpError.listen((WebViewHttpError error) {
      print(error);
    });
  }

  // 根据webview点返回时url的改变判断是否返回到了H5主页
  bool _isToMain(String url) {
    bool contain = false;
    for(var value in WebViewConfig.CATCH_URLS) {
      if(url?.endsWith(value) ?? false) {
        contain = true;
        break;
      }
    }
    return contain;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _onHttpError.cancel();
    _onStateChanged.cancel();
    _onUrlChanged.cancel();
    webViewReference.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String statusBarColorStr = widget.statusBarColor ?? 'ffffff';
    Color backBtnColor = Colors.white;
    if(statusBarColorStr == 'ffffff') {
      backBtnColor = Colors.black;
    }
    return Scaffold(
      body: Column(
        children: <Widget>[
          buildAppBar(context, Color(int.parse(statusBarColorStr, radix: 16) | 0xFF000000), backBtnColor),
          Expanded(
            child: WebviewScaffold(
              url: widget.url,
              withZoom: true,
              withLocalStorage: true,
              hidden: true,
              initialChild: Container(
                color: Colors.white,
                child: Center(child: CircularProgressIndicator()),
              ),
            )
          )
        ],
      ),
    );
  }

  Widget buildAppBar(BuildContext context, Color bgColor, Color backBtnColor) {
    final navHeight = MediaQueryData.fromWindow(window).padding.top;
    if(widget.hideAppBar ?? false) {
      return Container(
        color: bgColor,
        height: navHeight,
      );
    }
    return Container(
      height: navHeight,
      margin: EdgeInsets.only(top: navHeight),
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Stack(
          children: <Widget>[
            GestureDetector(
              child: Container(
                padding: EdgeInsets.only(left: 10),
                child: Icon(Icons.close, color: backBtnColor, size: 26,),
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            Positioned(
              left: 0,
              right: 0,
              child: Center(
                child: Text(widget.title ?? '', style: TextStyle(fontSize: 20, color: backBtnColor),),
              )
            )
          ],
        ),
      ),
    );
  }
}
