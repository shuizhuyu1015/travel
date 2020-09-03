import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:travel/core/model/trailer_model.dart';
import 'package:travel/core/utils/event_bus_manager.dart';
import 'package:video_player/video_player.dart';

class GLTravelContentItem extends StatefulWidget {
  final GLTrailerModel trailerModel;
  final int index;
  GLTravelContentItem(this.trailerModel, this.index);

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
    _videoPlayerController = VideoPlayerController.network(widget.trailerModel.trailer);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoInitialize: true,
      aspectRatio: 3/2,
      placeholder: Container(color: Colors.grey,)
    );

    EventBusManager.on<VideoTabBarViewInEvent>((event) {
      if(event.currentIndex != widget.index && _videoPlayerController.value.isPlaying) {
        print('暂停播放 ${widget.trailerModel.name}');
        _chewieController.pause();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _videoPlayerController.dispose();
    _chewieController.dispose();
    EventBusManager.off<VideoTabBarViewInEvent>();
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
