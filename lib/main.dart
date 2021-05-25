import 'package:custom_ads/inline_ads.dart';
import 'package:custom_ads/video_ads.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import 'full_page_ads.dart';
import 'welcome.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Create Custom Advertisement',
      debugShowCheckedModeBanner: false,
      home: Start(),
    );
  }
}

double ht, wdt = 0.0;

class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  @override
  Widget build(BuildContext context) {
    ht = MediaQuery.of(context).size.height / 1000;
    wdt = MediaQuery.of(context).size.width / 1000;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        title: Text(
          "Create Custom Advertisement",
          style: TextStyle(
            color: Colors.grey[900],
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                routes(context, FullPageAds());
              },
              child: Text("Full Page Ads"),
            ),
            SizedBox(height: ht * 30),
            ElevatedButton(
              onPressed: () {
                routes(context, VideoAds());
              },
              child: Text("Video Ads"),
            ),
            SizedBox(height: ht * 30),
            ElevatedButton(
              onPressed: () {
                routes(context, InlineAds());
              },
              child: Text("Inline Ads"),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Container(
            height: ht * 130,
            width: wdt * 1000,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/ads_three.jpg"),
                // You can add Network Image as well
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  left: wdt * 20, top: ht * 15, right: wdt * 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: wdt * 5, vertical: ht * 2),
                          decoration: BoxDecoration(
                            color: Colors.yellow[600],
                            borderRadius: BorderRadius.all(
                              (Radius.circular(3)),
                            ),
                          ),
                          child: Text(
                            "Ad",
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: ht * 2),
                        child: Text(
                          "Approtechs",
                          style: TextStyle(
                            letterSpacing: 0.3,
                            color: Colors.grey[200],
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: ht * 5),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: wdt * 7),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Aptitude Solutions - AptiSoln",
                          style: TextStyle(color: Colors.grey[200]),
                        ),
                        OutlinedButton(
                          onPressed: () {
                            // You can add your website or app link
                            _launch(
                                "https://play.google.com/store/apps/details?id=com.swaraj.AptiSoln");
                            routes(context, Welcome());
                          },
                          child: Text(
                            "Install",
                            style: TextStyle(
                              color: Colors.grey[200],
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: Colors.grey[200],
                              style: BorderStyle.solid,
                            )
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
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

  routes(context, classes) {
    return Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => classes,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child;
        },
        transitionDuration: Duration(milliseconds: 2000),
      ),
    );
  }
}
