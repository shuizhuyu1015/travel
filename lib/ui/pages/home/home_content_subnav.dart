import 'package:flutter/material.dart';
import 'package:travel/core/model/home_model.dart';
import 'package:travel/core/extension/num_extension.dart';
import 'package:travel/ui/widgets/webview.dart';

// 活动入口
Widget buildSubNav(BuildContext context, List<GLHomeBaseModel> subNavList) {
  if(subNavList.length == 0) return null;
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 8.px),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5.px)),
    child: GridView.builder(
        padding: EdgeInsets.only(top: 8.px),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            childAspectRatio: 1.6
        ),
        itemCount: subNavList.length,
        itemBuilder: (ctx, index) {
          return FlatButton(
            padding: EdgeInsets.zero,
            child: Column(
              children: <Widget>[
                Image.network(subNavList[index].icon, width: 22.px, height: 22.px,),
                Text(subNavList[index].title, style: TextStyle(fontSize: 12),)
              ],
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(GLWebView.routeName, arguments: subNavList[index]);
            },
          );
        }
    ),
  );
}