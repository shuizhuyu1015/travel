import 'package:flutter/material.dart';
import 'package:travel/core/model/travel_tab_model.dart';
import 'package:travel/core/services/travel_tab_request.dart';
import 'package:travel/ui/pages/travel/travel_content_item.dart';

class GLTravelContent extends StatefulWidget {
  @override
  _GLTravelContentState createState() => _GLTravelContentState();
}

class _GLTravelContentState extends State<GLTravelContent> with SingleTickerProviderStateMixin {
  final List<GLTravelTabModel> _tabs = [];
  TabController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GLTravelTabRequest.getTabData().then((value) {
      _controller = TabController(length: value.length, vsync: this);
      setState(() {
        _tabs.addAll(value);
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(_tabs.length == 0) return Center(child: CircularProgressIndicator());
    return Column(
      children: <Widget>[
        Container(
          color: Colors.white,
          child: TabBar(
            controller: _controller,
            isScrollable: true,
            labelColor: Colors.black,
            labelStyle: Theme.of(context).textTheme.headline3,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(color: Color(0xff009dff), width: 3),
            ),
            tabs: _tabs.map((GLTravelTabModel model) {
              return Tab(text: model.labelName);
            }).toList()
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _controller,
            children: _tabs.map((GLTravelTabModel model) {
              return GLTravelContentItem(model.groupChannelCode);
            }).toList()
          ),
        )
      ],
    );
  }
}
