import 'package:flutter/material.dart';
import 'package:travel/core/model/home_model.dart';
import 'package:travel/core/extension/num_extension.dart';
import 'package:travel/ui/widgets/webview.dart';

// 底部图文卡片
Widget buildSalesBox(BuildContext context, GLHomeSalesModel salesModel) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 8.px, vertical: 6.px),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(5.px),
      child: Column(
        children: <Widget>[
          buildSalesTitle(context, salesModel.icon, salesModel.moreUrl),
          buildCard(context, salesModel.bigCard1, salesModel.bigCard2, true, false),
          buildCard(context, salesModel.smallCard1, salesModel.smallCard2, false, false),
          buildCard(context, salesModel.smallCard3, salesModel.smallCard4, false, true),
        ],
      ),
    ),
  );
}

Widget buildSalesTitle(BuildContext context, String iconUrl, String moreUrl) {
  return Container(
    height: 44.px,
    padding: EdgeInsets.symmetric(horizontal: 8.px),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border(bottom: BorderSide(color: Color(0xffe2e2e2)))
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Image.network(iconUrl, height: 15.px, fit: BoxFit.fill,),
        wrapGesture(context, GLHomeBaseModel.fromJson({'url': moreUrl}), Container(
          padding: EdgeInsets.symmetric(vertical: 1.px, horizontal: 8.px),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.px),
              gradient: LinearGradient(colors: [Color(0xffff4e63), Color(0xffff6cc9)])
          ),
          child: Text('获取更多福利>', style:  TextStyle(fontSize: 12.px, color: Colors.white),),
        ))
      ],
    ),
  );
}

Widget buildCard(BuildContext context, GLHomeBaseModel card1, GLHomeBaseModel card2, bool isBig, bool isLast) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border(bottom: !isLast ? BorderSide(color: Color(0xffe2e2e2)) : BorderSide.none)
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: wrapGesture(context, card1, Container(
            decoration: BoxDecoration(
                border: Border(right: BorderSide(color: Color(0xffe2e2e2)))
            ),
            child: Image.network(card1.icon, fit: BoxFit.fill, height: isBig ? 130.px : 80.px,)
          ))
        ),
        Expanded(
          child: wrapGesture(context, card2,
            Image.network(card2.icon, fit: BoxFit.fill, height: isBig ? 130.px : 80.px,))
        ),
      ],
    ),
  );
}

Widget wrapGesture(BuildContext context, GLHomeBaseModel cardModel, Widget child) {
  return GestureDetector(
    child: child,
    onTap: () {
      Navigator.of(context).pushNamed(GLWebView.routeName, arguments: cardModel);
    },
  );
}