import 'package:flutter/material.dart';
import 'travel_content.dart';

class GLTravelPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('旅拍'),
      ),
      body: GLTravelContent(),
    );
  }
}
