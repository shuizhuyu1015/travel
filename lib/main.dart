import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/core/router/router.dart';
import 'package:travel/core/viewmodel/indexed_view_model.dart';
import 'package:travel/ui/shared/app_theme.dart';
import 'package:travel/ui/shared/size_fit.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (ctx) => GLIndexedViewModel(),
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    GLSizeFit.initialize();
    return MaterialApp(
      title: '爱旅拍',
      theme: GLAppTheme.norTheme,
      routes: GLRouter.routes,
      initialRoute: GLRouter.initialRoute,
      onGenerateRoute: GLRouter.generateRoute,
      onUnknownRoute: GLRouter.unknownRoute,
    );
  }
}
