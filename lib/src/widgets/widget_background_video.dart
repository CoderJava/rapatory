import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class WidgetBackgroundVideo extends StatefulWidget {
  @override
  _WidgetBackgroundVideoState createState() => _WidgetBackgroundVideoState();
}

class _WidgetBackgroundVideoState extends State<WidgetBackgroundVideo> {
  VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController =
    VideoPlayerController.asset('assets/videos/video_sunrise.mp4')
      ..initialize().then((_) {
        _videoPlayerController.play();
        _videoPlayerController.setLooping(true);
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SizedBox.expand(
          child: FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: _videoPlayerController.value.size?.width ?? 0,
              height: _videoPlayerController.value.size?.height ?? 0,
              child: VideoPlayer(_videoPlayerController),
            ),
          ),
        ),
        _buildWidgetOverlay(),
      ],
    );
  }

  Widget _buildWidgetOverlay() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0x00000000),
            Color(0xFF000000),
          ],
          stops: [
            0.4,
            0.9,
          ],
        ),
      ),
    );
  }
}