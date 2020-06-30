import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/core/viewmodel/indexed_view_model.dart';
import 'package:travel/ui/widgets/webview.dart';

class GLMineContent extends StatefulWidget {
  @override
  _GLMineContentState createState() => _GLMineContentState();
}

class _GLMineContentState extends State<GLMineContent> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GLIndexedViewModel>(
      builder: (ctx, indexedVM, child) {
//        return Offstage(
//          offstage: indexedVM.currentIndex != 3,
//          child: child,
//        );
        return Visibility(
          visible: indexedVM.currentIndex == 3,
          child: child
        );
      },
      child: GLWebView(
        url: 'https://m.ctrip.com/webapp/myctrip',
        hideAppBar: true,
        backForbid: true,
        statusBarColor: '4c5bca',
      ),
    );
  }
}
