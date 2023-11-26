import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Video extends StatefulWidget {
  final String trailer;
  final String name;
  final String title;

  const Video({required this.trailer, required this.name, required this.title});

  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
  late VideoPlayerController _controller;
  late VideoPlayerController _controller2;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller2 = VideoPlayerController.network(
        "https://drive.google.com/uc?id=1BuSNdJdC3nLDPxxCfBZ8QCcUSGjPd2MJ")
      ..initialize().then((_) {
        setState(() {});
      });
    _controller = VideoPlayerController.network(widget.trailer)
      ..initialize().then((_) {
        setState(() {});
      });

    _controller.addListener(() {
      if (!_controller.value.isPlaying &&
          _controller.value.position == _controller.value.duration) {
        // Video has ended
        setState(() {
          _isPlaying = false;
        });
      }
    });
  }

  void _restartVideo() {
    _controller.seekTo(Duration.zero);
    _controller.play();
    setState(() {
      _isPlaying = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          _controller.value.isInitialized
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        VideoPlayer(_controller),
                        _PlayPauseOverlay(controller: _controller),
                        _SkipButtons(controller: _controller),
                      ],
                    ),
                  ),
                )
              : Center(child: CircularProgressIndicator()),
            Container(
              padding: EdgeInsets.only(top: 3,left: 6),
              child: Row(
                children: [
                  Text(
                      widget.name,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
            ),

          Container(
            padding: EdgeInsets.only(top: 10,bottom: 5,left: 10,right: 10),
            child:Row(
              
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.comment,color:Color.fromARGB(255, 117, 50, 50)),
                Icon(Icons.share,color:Color.fromARGB(255, 232, 94, 250)),
                Icon(Icons.download,color:Color.fromARGB(255, 94, 183, 250)),
                Icon(Icons.save_as,color:Color.fromARGB(255, 36, 227, 179))
              ],
            )
          ),

          Container(
            padding: EdgeInsets.all(6),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        widget.title,
                        style: TextStyle(fontSize: 17, color: Colors.black),
                        maxLines: 4,
                      ),
                    ),
                  ),
                ),
                _controller2.value.isInitialized
                    ? Align(
                        alignment: Alignment.topLeft,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(22.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.42,
                            height: MediaQuery.of(context).size.height * 0.14,
                            child: AspectRatio(
                              aspectRatio: _controller2.value.aspectRatio,
                              child: Stack(
                                alignment: Alignment.topCenter,
                                children: [
                                  VideoPlayer(_controller2),
                                  _PlayPauseOverlay(controller: _controller2),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    : Center(child: CircularProgressIndicator()),

                    
                    
                if (!_isPlaying)
                  ElevatedButton(
                    onPressed: _restartVideo,
                    
                    child: Icon(Icons.restart_alt,color: Colors.white),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _PlayPauseOverlay extends StatelessWidget {
  final VideoPlayerController controller;

  const _PlayPauseOverlay({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Duration position = controller.value.position;
    Duration duration = controller.value.duration;

    String elapsedTime = _formatDuration(position);
    String remainingTime = _formatDuration(duration - position);

    return Stack(
      children: [
        AnimatedSwitcher(
          duration: Duration(milliseconds: 50),
          reverseDuration: Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? SizedBox.shrink()
              : Container(
                  color: Colors.black26,
                  child: Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100.0,
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            if (controller.value.isPlaying) {
              controller.pause();
            } else {
              controller.play();
            }
          },
        ),
        Positioned(
          bottom: 8,
          left: 8,
          right: 8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                elapsedTime,
                style: TextStyle(color: Colors.white),
              ),
              Text(
                remainingTime,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '$twoDigitMinutes:$twoDigitSeconds';
  }
}

class _SkipButtons extends StatelessWidget {
  final VideoPlayerController controller;

  const _SkipButtons({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 48,
      left: 8,
      right: 8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {
              _skipBackward(controller);
            },
            icon: Icon(Icons.skip_previous, color: Colors.white),
          ),
          IconButton(
            onPressed: () {
              _skipForward(controller);
            },
            icon: Icon(Icons.skip_next, color: Colors.white),
          ),
        ],
      ),
    );
  }

  void _skipBackward(VideoPlayerController controller) {
    Duration currentPosition = controller.value.position;
    Duration newPosition = currentPosition - Duration(seconds: 5);
    controller.seekTo(newPosition);
  }

  void _skipForward(VideoPlayerController controller) {
    Duration currentPosition = controller.value.position;
    Duration newPosition = currentPosition + Duration(seconds: 5);
    controller.seekTo(newPosition);
  }
}
