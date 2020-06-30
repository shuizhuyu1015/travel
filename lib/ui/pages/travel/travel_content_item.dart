import 'package:flutter/material.dart';
import 'package:travel/core/services/travel_request.dart';

class GLTravelContentItem extends StatefulWidget {
  final String groupChannelCode;
  GLTravelContentItem(this.groupChannelCode);

  @override
  _GLTravelContentItemState createState() => _GLTravelContentItemState();
}

class _GLTravelContentItemState extends State<GLTravelContentItem> with AutomaticKeepAliveClientMixin {
  int _pageIndex = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GLTravelRequest.getData(widget.groupChannelCode, _pageIndex).then((value) {

    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Card(
        child: Center(
          child: Text(widget.groupChannelCode, style: Theme.of(context).textTheme.headline1,)
        ),
      ),
    );
  }
}
