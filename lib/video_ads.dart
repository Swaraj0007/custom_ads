import 'dart:async';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:url_launcher/url_launcher.dart';

import 'main.dart';
import 'welcome.dart';


class VideoAds extends StatefulWidget {
  const VideoAds({Key key}) : super(key: key);

  @override
  _VideoAdsState createState() => _VideoAdsState();
}

class _VideoAdsState extends State<VideoAds> {
  VideoPlayerController _controller;
  Timer timers;
  int _start = 5;

  @override
  void initState() {
    const oneSecond = const Duration(seconds: 1);
    timers = Timer.periodic(oneSecond, (Timer timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
    BackButtonInterceptor.add(myInterceptor);
    _controller = VideoPlayerController.asset("assets/myvideo.mp4")
      ..initialize().then((_) {
        setState(() {
          _controller.value.isInitialized
              ? _controller.play()
              : _controller.pause();
        });
      });
    super.initState();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    return true;
  }

  _launch(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        backgroundColor: Colors.black,
        brightness: Brightness.dark,
      ),
      backgroundColor: Colors.black,
      body: _controller.value.isInitialized ? Stack(
        children: [
          Positioned(
            top: ht * 300,
              child: Container(
                height: ht *300,
                width: wdt * 1000,
                child: VideoPlayer(_controller),
              ),
          ),
          Positioned(
            top: ht * 520,
            left: wdt * 720,
            child: OutlinedButton(
              onPressed: (){
                if(_start == 0){
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          Welcome(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return child;
                      },
                      transitionDuration: Duration(milliseconds: 2000),
                    ),
                  );
                }
              },
              child: _start==0?Row(
                children: [
                  Text(
                    "Skip Add",
                    style: TextStyle(
                      color: Colors.grey[50],
                    ),
                  ),
                  Icon(
                    Icons.skip_next,
                    color: Colors.grey[50],
                  ),
                ],
              ):Text(
                "Skip Ad in $_start",
                style: TextStyle(
                  color: Colors.grey[50],
                ),
              ),
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.transparent,
                side: BorderSide(
                  width: 1,
                  color: Colors.grey[100],
                  style: BorderStyle.solid,
                ),
              ),
            ),
          ),
          Positioned(
            top: ht * 620,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: ht * 60),
              child: Text(
                "Visit Our Website for furniture and accessories.",
                softWrap: true,
                style: TextStyle(
                  color: Colors.grey[50],
                ),
              ),
            ),
          ),
          Positioned(
            top: ht * 680,
            right: wdt * 200,
            left: wdt * 200,
            child: OutlinedButton(
              onPressed: (){
                Navigator.of(context).pop();
                _launch(
                    "https://play.google.com/store/apps/details?id=com.swaraj.AptiSoln");
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        Welcome(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return child;
                    },
                    transitionDuration: Duration(milliseconds: 2000),
                  ),
                );
              },
              child: Text(
                  "Buy Online",
                style: TextStyle(
                  color: Colors.grey[50],
                ),
              ),
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.blue[900],
                side: BorderSide(
                  width: 2,
                  color: Colors.blue[900],
                  style: BorderStyle.solid,
                ),
              ),
            ),
          ),
        ],
      ) : Container(),
    );
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    _controller.dispose();
    timers.cancel();
    super.dispose();
  }

}
