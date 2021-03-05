import 'package:covid_app/config/palette.dart';
import 'package:flutter/material.dart';
import 'package:covid_app/data/data.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoScreen extends StatefulWidget {
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Palette.primaryColor,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                info,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            ),
            SizedBox(height: 50),
            Divider(
              height: 3,
              color: Colors.white,
            ),
            SizedBox(height: 50),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Follow me on :',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.amber,
                    decoration: TextDecoration.underline,
                  ),
                ),
                GestureDetector(
                  onTap: () => _launchURL('https://github.com/MSdevv/'),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: screenHeight * 0.05, left: screenWidth * 0.20),
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          'assets/images/github.png',
                          height: 30,
                        ),
                        SizedBox(width: 30),
                        Text(
                          'GitHub',
                          style: TextStyle(color: Colors.amber, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () =>
                      _launchURL('https://www.linkedin.com/in/mserhane/'),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: screenHeight * 0.03, left: screenWidth * 0.20),
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          'assets/images/linkedin.png',
                          height: 30,
                        ),
                        SizedBox(width: 30),
                        Text(
                          'LinkedIn',
                          style: TextStyle(color: Colors.amber, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () =>
                      _launchURL('https://www.instagram.com/majidsrh/'),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: screenHeight * 0.03, left: screenWidth * 0.20),
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          'assets/images/instagram.png',
                          height: 33,
                        ),
                        SizedBox(width: 30),
                        Text(
                          'Instagram',
                          style: TextStyle(color: Colors.amber, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      launch(url);
    } else {
      throw ('Could not launch $url');
    }
  }
}
