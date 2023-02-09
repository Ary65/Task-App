// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';
import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:task_app/constants/colors.dart';

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
  late CachedVideoPlayerController _controller;
  bool isMusicOn = true;

  @override
  void initState() {
    super.initState();
    _controller = CachedVideoPlayerController.network(widget.uri)
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
            top: h * .07,
            left: w * .02,
            right: w * .02,
            bottom: h * .009,
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: SizedBox(
                      height: h * 35,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: CachedVideoPlayer(
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
            top: h * .09,
            left: w * .04,
            right: w * .04,
            bottom: h * .01,
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
                size: w * .15,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: h * .35,
            bottom: h * .009,
            left: w * .02,
            right: w * .02,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(w * .02),
                  bottomRight: Radius.circular(
                    w * .02,
                  )),
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
                          children: [
                            Image(
                              image:
                                  const AssetImage('assets/icons/comment.png'),
                              width: w * .08,
                              color: Colors.white,
                            ),
                            SizedBox(width: w * .017),
                            Text(
                              '10',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: w * .06,
                              ),
                            ),
                            SizedBox(width: w * .025),
                            Image(
                              image: const AssetImage(
                                  'assets/icons/love-hand-drawn-heart-symbol-outline.png'),
                              width: w * .065,
                              color: Colors.white,
                            ),
                            SizedBox(width: w * .015),
                            Text(
                              '122',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: w * .06,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Image(
                              image: const AssetImage('assets/icons/send.png'),
                              width: w * .06,
                              color: Colors.white,
                            ),
                            SizedBox(width: w * .03),
                            Image(
                              image:
                                  const AssetImage('assets/icons/bookmark.png'),
                              width: w * .06,
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
