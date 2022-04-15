import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sms_spam_detection/presentation/MatColor.dart';
import 'package:sms_spam_detection/presentation/styles.dart';
import 'package:sms_spam_detection/utils/SharedPrefrences.dart';

class Splashscreen extends StatefulWidget {
  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  String route;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  bool hasCalled = false;

  void getNextScreen() async {
    bool isMessageImported = await SharedPref.isMessageImported();
    bool isOnboardGone = await SharedPref.isOnBoardedGone();
    bool isUserLoggedIn = await SharedPref.isUserLoggedIn();

    // if (!isOnboardGone) {
    //   route = '/onboard';
    //   Navigator.of(context).pushReplacementNamed(route);
    //   return;
    // }

    if (!isUserLoggedIn) {
      route = '/onboard';
      Navigator.of(context).pushReplacementNamed(route);
      return;
    }

    route = '/import';
    Navigator.of(context).pushReplacementNamed(route);
  }

  @override
  Widget build(BuildContext context) {
    if (!hasCalled) {
      hasCalled = true;
      getNextScreen();
    }

    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(color: MatColor.primaryColor),
          child: Padding(
            padding: EdgeInsets.only(top: 40.0, bottom: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Center(
                  child: Image(
                    image: AssetImage(
                      'assets/images/app_icon.png',
                    ),
                    height: 200.0,
                    width: 200.0,
                  ),
                ),
                SizedBox(height: 50.0),
                Center(
                  child: Text(
                    'Spam SMS \nDETECTION',
                    style: onBoardTitleStyle,
                  ),
                ),
                SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
