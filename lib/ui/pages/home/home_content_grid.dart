import 'package:flutter/material.dart';
import 'package:travel/core/model/home_model.dart';
import 'package:travel/core/extension/num_extension.dart';
import 'package:travel/ui/widgets/webview.dart';

// 网格卡片
Widget buildGridNav(BuildContext context, GLHomeGridModel gridModel) {
  return Container(
    color: Colors.white,
    margin: EdgeInsets.fromLTRB(8.px, 0, 8.px, 6.px),
    child: ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(5.px)),
      child: Column(
        children: <Widget>[
          buildGridNavItem(context, gridModel.hotel, false),
          buildGridNavItem(context, gridModel.flight, false),
          buildGridNavItem(context, gridModel.travel, true)
        ],
      ),
    ),
  );
}

Widget buildGridNavItem(BuildContext context, GLHomeGridItemModel gridItemModel, bool isLast) {
  return Container(
    height: 88.px,
    margin: !isLast ? EdgeInsets.only(bottom: 2) : null,
    decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Color(int.parse('0xff' + gridItemModel.startColor)),
          Color(int.parse('0xff' + gridItemModel.endColor))
        ]
        )
    ),
    child: Row(
      children: <Widget>[
        Expanded(child: buildGridMainItem(context, gridItemModel.mainItem)),
        Expanded(child: buildGridDoubleItem(context, gridItemModel.item1, gridItemModel.item2, true)),
        Expanded(child: buildGridDoubleItem(context, gridItemModel.item3, gridItemModel.item4, false))
      ],
    ),
  );
}

Widget buildGridMainItem(BuildContext context, GLHomeBaseModel mainModel) {
  return GestureDetector(
    child: Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Image.network(
          mainModel.icon,
          height: 88.px,
          fit: BoxFit.contain,
          alignment: Alignment.bottomCenter,
        ),
        Positioned(
            top: 10.px,
            child: Text(mainModel.title, style: TextStyle(fontSize: 14.px, color: Colors.white),)
        )
      ],
    ),
    onTap: () {
      Navigator.of(context).pushNamed(GLWebView.routeName, arguments: mainModel);
    },
  );
}

Widget buildGridDoubleItem(BuildContext context, GLHomeBaseModel topItem, GLHomeBaseModel bottomItem, bool isCenter) {
  return Container(
    decoration: isCenter ? BoxDecoration(
        border: Border(
            left: BorderSide(color: Colors.white,),
            right: BorderSide(color: Colors.white)
        )
    ) : null,
    child: Column(
      children: <Widget>[
        Expanded(child: buildGestureWidget(context, topItem, false)),
        Expanded(child: buildGestureWidget(context, bottomItem, true))
      ],
    ),
  );
}

Widget buildGestureWidget(BuildContext context, GLHomeBaseModel itemModel, bool isLast) {
  return GestureDetector(
    child: Container(
      decoration: !isLast ? BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Colors.white,)
          )
      ) : null,
      child: Center(
        child: Text(itemModel.title, style:  TextStyle(fontSize: 14.px, color: Colors.white),),
      ),
    ),
    onTap: () {
      Navigator.of(context).pushNamed(GLWebView.routeName, arguments: itemModel);
    },
  );
}