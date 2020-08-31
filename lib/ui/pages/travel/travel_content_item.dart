import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:travel/core/model/trailer_model.dart';
import 'package:video_player/video_player.dart';

class GLTravelContentItem extends StatefulWidget {
  final GLTrailerModel trailerModel;
  GLTravelContentItem(this.trailerModel);

  @override
  _GLTravelContentItemState createState() => _GLTravelContentItemState();
}

class _GLTravelContentItemState extends State<GLTravelContentItem> with AutomaticKeepAliveClientMixin {

  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.trailerModel.trailer);
    _videoPlayerController = VideoPlayerController.network(widget.trailerModel.trailer)
      ..initialize().then((_) {
        setState(() {

        });
      });
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 3/2,
      placeholder: Container(color: Colors.grey,)
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      padding: EdgeInsets.all(15),
      child: Card(
        child: Center(
          child: Chewie(controller: _chewieController,)
        ),
      ),
    );
  }
}
