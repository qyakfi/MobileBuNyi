import 'package:bunyicake/pages/katalog.dart';
import 'package:flutter/material.dart';
import 'package:bunyicake/constant/app_constants.dart';
import 'package:bunyicake/constant/color_constants.dart';
import 'package:bunyicake/providers/auth_provider.dart';
import 'package:bunyicake/pages/ad_in.dart';
//import 'package:bunyicake/auth/auth_login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../widgets/widgets.dart';
import 'pages.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();

}

class LoginPageState extends State<LoginPage> {

    @override
    Widget build(BuildContext context) {
      AuthProvider authProvider = Provider.of<AuthProvider>(context);
      switch (authProvider.status) {
        case Status.authenticateError:
          Fluttertoast.showToast(msg: "Gagal Masuk");
          break;
        case Status.authenticateCanceled:
          Fluttertoast.showToast(msg: "Dibatalkan");
          break;
        case Status.authenticated:
          Fluttertoast.showToast(msg: "Berhasil Masuk");
          break;
        default:
          break;
      }
      return Scaffold(
          appBar: AppBar(
            backgroundColor: ColorConstants.themeColor,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'aset/img/logo.png',
                  scale: 20,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'BuNyi Cake',
                  style: TextStyle(color: ColorConstants.greyColor),
                ),
              ],
            ),
            centerTitle: true,
          ),
          body:  Stack(
        children: <Widget>[
          SingleChildScrollView(
          scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                height: 170.0,
                ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Silahkan Login Terlebih Dahulu',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextButton(
                onPressed: () async {
                  authProvider.handleSignIn().then((isSuccess) {
                    if (isSuccess) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => KatPage(),
                        ),
                      );
                    }
                  }).catchError((error, stackTrace) {
                    Fluttertoast.showToast(msg: error.toString());
                    authProvider.handleException();
                  });
                },
                child: Text(
                  'Masuk dengan Google',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed))
                        return Color(0xffdd4b39).withOpacity(0.8);
                      return Color(0xffdd4b39);
                    },
                  ),
                  splashFactory: NoSplash.splashFactory,
                  padding: MaterialStateProperty.all<EdgeInsets>(
                    EdgeInsets.fromLTRB(30, 15, 30, 15),
                  ),
                ),
              ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  '-- atau --',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextButton(
              onPressed: () async {Navigator.push(context,
                MaterialPageRoute(builder: (context) => admin(),
                      ),
                    );
                  },
              child: Text(
                'Masuk sebagai Admin',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).primaryColor),
                    splashFactory: NoSplash.splashFactory,
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.fromLTRB(30, 15, 30, 15),)
                  ),
                ),

            ])),
          // Loading
          Positioned(
            child: authProvider.status == Status.authenticating
                ? LoadingView()
                : SizedBox.shrink(),
          ),
        ],
      ));
    }
  }