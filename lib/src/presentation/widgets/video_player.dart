import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/src/presentation/widgets/custom_chewie_material_controls.dart';
import 'package:video_player/video_player.dart';

enum VideoPlayerType { asset, network }

class VideoPlayer extends StatefulWidget {
  final VideoPlayerType type;
  final String videoUrl;

  VideoPlayer({
    Key key,
    this.type,
    this.videoUrl,
  }) : super(key: key);

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;

  @override
  void initState() {
    _videoPlayerController = widget.type == VideoPlayerType.network
        ? VideoPlayerController.network(widget.videoUrl)
        : VideoPlayerController.asset(widget.videoUrl);

    _chewieController = _makeChewieController(context, _videoPlayerController);
    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Chewie(controller: _chewieController));
  }

  _makeChewieController(
      BuildContext context, VideoPlayerController _videoPlayerController) {
    return ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 16 / 9,
      autoPlay: false,
      autoInitialize: true,
      customControls: CustomChewieMaterialControls(),
    );
  }
}
