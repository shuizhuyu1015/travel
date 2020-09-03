import 'package:flutter/material.dart';
import 'package:travel/core/model/trailer_model.dart';
import 'package:travel/core/services/trailer_request.dart';
import 'package:travel/core/utils/event_bus_manager.dart';
import 'package:travel/ui/pages/travel/travel_content_item.dart';

class GLTravelContent extends StatefulWidget {
  @override
  _GLTravelContentState createState() => _GLTravelContentState();
}

class _GLTravelContentState extends State<GLTravelContent> with SingleTickerProviderStateMixin {
  TabController _controller;
  List<GLTrailerModel> _trailers = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GLTrailerRequest.getTrailers().then((value) {
      _controller = TabController(length: value.length, vsync: this)
        ..addListener(() {
          EventBusManager.fire(VideoTabBarViewInEvent(_controller.index));
        });
      setState(() {
        _trailers = value;
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
    if(_trailers.length == 0) return Center(child: CircularProgressIndicator());
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
            tabs: _trailers.map((GLTrailerModel model) {
              return Tab(
                child: Container(
                  alignment: Alignment.center,
                  constraints: BoxConstraints(
                    maxWidth: 150
                  ),
                  child: Text(
                    model.name,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              );
            }).toList()
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _controller,
            children: List.generate(_trailers.length, (index) {
              return GLTravelContentItem(_trailers[index], index);
            })
          ),
        )
      ],
    );
  }
}
