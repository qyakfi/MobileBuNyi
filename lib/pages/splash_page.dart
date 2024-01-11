import 'package:bunyicake/pages/katalog.dart';
import 'package:flutter/material.dart';
import 'package:bunyicake/constant/color_constants.dart';
import 'package:bunyicake/providers/auth_provider.dart';
import 'package:provider/provider.dart';

import 'pages.dart';

class SplashPage extends StatefulWidget {
  SplashPage({super.key});

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      // just delay for showing this slash page clearer because it too fast
      checkSignedIn();
    });
  }

  void checkSignedIn() async {
    AuthProvider authProvider = context.read<AuthProvider>();
    bool isLoggedIn = await authProvider.isLoggedIn();
    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => KatPage()),
      );
      return;
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.themeColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "aset/img/logo.png",
              width: 300,
              height: 300,
            ),
            SizedBox(height: 20),
            Container(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(color: ColorConstants.themeColor),
            ),
          ],
        ),
      ),
    );
  }
}