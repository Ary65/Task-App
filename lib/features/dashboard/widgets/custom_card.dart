// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:task_app/constants/colors.dart';
import 'package:video_player/video_player.dart';

class CustomCard extends StatefulWidget {
  final String title;
  final String time;
  final String uri;
  const CustomCard({
    Key? key,
    required this.title,
    required this.time,
    required this.uri,
  }) : super(key: key);

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  late VideoPlayerController _controller;
  bool isMusicOn = true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.uri)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  void soundToggle() {
    setState(() {
      isMusicOn == false
          ? _controller.setVolume(0.0)
          : _controller.setVolume(1.0);
      isMusicOn = !isMusicOn;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            width: w,
            height: h * .4,
            decoration: BoxDecoration(
              color: ConstantsColors.boxColor,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(widget.title),
                Text(widget.time),
              ],
            ),
          ),
          Positioned(
            top: 55,
            left: 8,
            right: 8,
            bottom: 5,
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: SizedBox(
                      height: h * 35,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: VideoPlayer(
                          _controller,
                        ),
                      ),
                    ),
                  )
                : Container(),
          ),
          Positioned(
            top: h * .067,
            left: w * .77,
            child: IconButton(
                onPressed: () {
                  soundToggle();
                },
                icon: Icon(
                  isMusicOn == true ? Icons.volume_up : Icons.volume_off,
                  color: Colors.white,
                )),
          ),
          Positioned(
            top: 100,
            left: 100,
            right: 100,
            bottom: 5,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _controller.value.isPlaying
                      ? _controller.pause()
                      : _controller.play();
                });
              },
              child: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                size: 70,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: 300,
            bottom: 5,
            left: 8,
            right: 8,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8)),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 5,
                  sigmaY: 5,
                ),
                child: Container(
                  color: Colors.black.withOpacity(0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Image(
                              image: AssetImage('assets/icons/comment.png'),
                              width: 30,
                              color: Colors.white,
                            ),
                            SizedBox(width: 8),
                            Text(
                              '10',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                              ),
                            ),
                            SizedBox(width: 8),
                            Image(
                              image: AssetImage(
                                  'assets/icons/love-hand-drawn-heart-symbol-outline.png'),
                              width: 25,
                              color: Colors.white,
                            ),
                            SizedBox(width: 8),
                            Text(
                              '122',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: const [
                            Image(
                              image: AssetImage('assets/icons/send.png'),
                              width: 25,
                              color: Colors.white,
                            ),
                            SizedBox(width: 12),
                            Image(
                              image: AssetImage('assets/icons/bookmark.png'),
                              width: 25,
                              color: Colors.white,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
