import 'package:bunyicake/pages/katalog.dart';
import 'package:flutter/material.dart';
import 'package:bunyicake/constant/app_constants.dart';
import 'package:bunyicake/constant/color_constants.dart';
import 'package:bunyicake/providers/auth_provider.dart';
//import 'package:bunyicake/auth/auth_login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../widgets/widgets.dart';
import 'pages.dart';

class admin extends StatefulWidget{
  const admin({super.key});


  @override
  _adminState createState() => _adminState();
}

class _adminState extends State<admin> {
  final usnKontrol = TextEditingController();
  final pasKontrol = TextEditingController();
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
    return SafeArea(
        child: Scaffold(
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
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 100.0,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'Silahkan Login Terlebih Dahulu',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 40.0,
                ),
                Form(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Theme(
                          data: new ThemeData(
                            primaryColor: Color.fromRGBO(84, 87, 90, 0.5),
                            primaryColorDark: Color.fromRGBO(84, 87, 90, 0.5),
                            hintColor:
                            Color.fromRGBO(84, 87, 90, 0.5), //placeholder color
                          ),
                          child: TextFormField(
                            controller: usnKontrol,
                            decoration: InputDecoration(
                              focusedBorder: new OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(84, 87, 90, 0.5),
                                  style: BorderStyle.solid,
                                ),
                              ),
                              enabledBorder: new OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(84, 87, 90, 0.5),
                                  style: BorderStyle.solid,
                                ),
                              ),
                              errorBorder: new OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 1.0,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              labelText: 'Masukan Email',
                              prefixIcon: const Icon(
                                Icons.person,
                                color: Color.fromRGBO(84, 87, 90, 0.5),
                              ),
                              border: new OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(84, 87, 90, 0.5),
                                  style: BorderStyle.solid,
                                ),
                              ),
                              hintText: 'Email',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Mohon Isi Email';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Theme(
                          data: new ThemeData(
                            primaryColor: Color.fromRGBO(84, 87, 90, 0.5),
                            primaryColorDark: Color.fromRGBO(84, 87, 90, 0.5),
                            hintColor:
                            Color.fromRGBO(84, 87, 90, 0.5), //placeholder color
                          ),
                          child: TextFormField(
                            controller: pasKontrol,
                            obscureText: true,
                            decoration: InputDecoration(
                              focusedBorder: new OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(84, 87, 90, 0.5),
                                  style: BorderStyle.solid,
                                ),
                              ),
                              enabledBorder: new OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(84, 87, 90, 0.5),
                                  style: BorderStyle.solid,
                                ),
                              ),
                              errorBorder: new OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 1.0,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              border: new OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromRGBO(84, 87, 90, 0.5),
                                  style: BorderStyle.solid,
                                ),
                              ),
                              labelText: 'Masukan Password',
                              prefixIcon: const Icon(
                                Icons.lock,
                                color: Color.fromRGBO(84, 87, 90, 0.5),
                              ),
                              hintText: 'Password',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Mohon Isi Password';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextButton(
                          onPressed: () async {
                            authProvider.handleAdmin(usnKontrol.text, pasKontrol.text).then((isSuccess) {
                              if (isSuccess) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomePage(),
                                  ),
                                );
                              }
                            }).catchError((error, stackTrace) {
                              Fluttertoast.showToast(msg: error.toString());
                              authProvider.handleException();
                            });
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}