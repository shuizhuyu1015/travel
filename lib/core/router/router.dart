import 'package:flutter/material.dart';
import 'package:travel/core/model/home_model.dart';
import 'package:travel/ui/pages/main/main.dart';
import 'package:travel/ui/widgets/webview.dart';

class GLRouter {
  static final initialRoute = GLMainPage.routeName;

  static final Map<String, WidgetBuilder> routes = {
    GLMainPage.routeName: (ctx) => GLMainPage()
  };

  static final RouteFactory generateRoute = (setting) {
    if(setting.name == GLWebView.routeName) {
      GLHomeBaseModel localModel = setting.arguments;
      return MaterialPageRoute(builder: (ctx) => GLWebView(
        title: localModel.title,
        url: localModel.url,
        statusBarColor: localModel.statusBarColor,
        hideAppBar: localModel.hideAppBar,
      ));
    }
    return null;
  };

  static final RouteFactory unknownRoute = (setting) {
    return null;
  };
}