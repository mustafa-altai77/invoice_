import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';

class MySplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // SvgPicture.asset(
            //   'assets/images/tweety-logo.svg',
            //   color: Theme.of(context).primaryColor,
            //   height: 60.0,
            // ),
            // Image(
            //   image: AssetImage('assets/images/logo.png'),
            // )
                            Text(
                            tr('app_name'),
                            style: TextStyle(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            fontSize: 25.0,
                            fontWeight: FontWeight.w900,
                            fontFamily: ArabicFonts.Cairo,
                            package: 'google_fonts_arabic',
                        ),
                      ),            
          ],
        ),
      ),
    );
  }
}
