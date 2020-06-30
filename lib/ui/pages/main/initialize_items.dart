import 'package:flutter/material.dart';

import '../home/home.dart';
import '../search/search.dart';
import '../travel/travel.dart';
import '../mine/mine.dart';

final List<Widget> pages = [
  GLHomePage(),
  GLSearchPage(),
  GLTravelPage(),
  GLMinePage()
];

final List<BottomNavigationBarItem> barItems = [
  BottomNavigationBarItem(
    title: Text('首页'),
    icon: Icon(Icons.home)
  ),
  BottomNavigationBarItem(
    title: Text('搜索'),
    icon: Icon(Icons.search)
  ),
  BottomNavigationBarItem(
    title: Text('旅拍'),
    icon: Icon(Icons.camera)
  ),
  BottomNavigationBarItem(
    title: Text('我的'),
    icon: Icon(Icons.perm_identity)
  )
] ;