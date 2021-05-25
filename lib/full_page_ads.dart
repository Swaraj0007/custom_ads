import 'package:custom_ads/welcome.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';

import 'main.dart';

class FullPageAds extends StatefulWidget {
  const FullPageAds({Key key}) : super(key: key);

  @override
  _FullPageAdsState createState() => _FullPageAdsState();
}

class _FullPageAdsState extends State<FullPageAds> {

  @override
  void initState() {
    BackButtonInterceptor.add(myInterceptor);
    super.initState();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info){
    return true;
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: ht * 200),
          GestureDetector(
            child: Icon(
              Icons.cancel_outlined,
              color: Colors.grey[50],
            ),
            onTap: () {
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
            },
          ),
          SizedBox(height: ht * 50),
          Container(
            height: ht * 400,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage(
                "assets/home.jpg",
              ),
            )),
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: wdt * 15, vertical: ht * 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        height: ht * 60,
                        width: ht * 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          image: DecorationImage(
                            image: AssetImage(
                              "assets/ads_one.jpg",
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      SizedBox(width: wdt * 20),
                      Text(
                        "My Bungalow",
                        style: TextStyle(
                          color: Colors.grey[50],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ht * 230,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          _launch(
                            "https://play.google.com/store/apps/details?id=com.swaraj.AptiSoln",
                          );
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      Welcome(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return child;
                              },
                              transitionDuration: Duration(milliseconds: 2000),
                            ),
                          );
                        },
                        child: Text(
                          "Visit Or Website",
                          style: TextStyle(
                            color: Colors.blue[50],
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.blue[900],
                          side: BorderSide(
                            width: 2,
                            color: Colors.blue[900],
                            style: BorderStyle.solid,
                          )
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _launch(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }
}
