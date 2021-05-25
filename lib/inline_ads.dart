import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'main.dart';
import 'welcome.dart';

class InlineAds extends StatefulWidget {
  const InlineAds({Key key}) : super(key: key);

  @override
  _InlineAdsState createState() => _InlineAdsState();
}

class _InlineAdsState extends State<InlineAds> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        backgroundColor: Colors.grey[50],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            cards("assets/ads_one.jpg"),
            cards("assets/ads_two.jpg"),
            inlineAds(),
            cards("assets/ads_four.jpg"),
            cards("assets/ads_five.jpg"),
            cards("assets/ads_one.jpg"),
            cards("assets/ads_two.jpg"),
          ],
        ),
      ),
    );
  }

  Widget cards(img) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Container(
        height: ht * 280,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(img),
          ),
        ),
      ),
    );
  }

  Widget inlineAds() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Container(
        height: ht * 130,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage("assets/ads_three.jpg"),
          ),
        ),
        child: Padding(
          padding:
              EdgeInsets.only(left: wdt * 20, top: ht * 15, right: wdt * 20),
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
                        Navigator.of(context).pop();
                        // You can add your website or app link
                        _launch(
                          "https://play.google.com/store/apps/details?id=com.swaraj.AptiSoln",
                        );
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
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
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

  _launch(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
