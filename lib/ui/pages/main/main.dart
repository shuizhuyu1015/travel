import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/core/viewmodel/indexed_view_model.dart';

import 'initialize_items.dart';

class GLMainPage extends StatefulWidget {
  static const String routeName = '/';

  @override
  _GLMainPageState createState() => _GLMainPageState();
}

class _GLMainPageState extends State<GLMainPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: Consumer<GLIndexedViewModel>(
        builder: (ctx, indexedVM, child) {
          return BottomNavigationBar(
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            items: barItems,
            onTap: (index) {
              indexedVM.currentIndex = index;
              setState(() {
                _currentIndex = index;
              });
            },
          );
        })
    );
  }
}
