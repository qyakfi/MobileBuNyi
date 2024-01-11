import 'package:bunyicake/pages/katalog.dart';
import 'package:flutter/material.dart';
import 'package:bunyicake/constant/color_constants.dart';
import 'package:bunyicake/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constant/app_constants.dart';
import '../widgets/bot_bar.dart';
import 'pages.dart';

class Profile extends StatelessWidget {
  String url = 'https://wa.me/c/6287827858814';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.themeColor,
        title: Text(
          AppConstants.appTitle,
          style: TextStyle(color: ColorConstants.primaryColor),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar:BotBar(),
      body: Center(
            child:
              // background image and bottom contents
              Column(
                children: <Widget>[
                  SizedBox(height: 50.0,),
                  Container(
                    height: 200.0,
                    width: 200.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.contain,
                            // image: AssetImage("assets/images/cover.jpg")
                            image: AssetImage("aset/img/logo.png"
                            )
                        )
                    ),
                  ),
                  SizedBox(height: 15.0,),
                  Text('BuNyi Cake'),
                  SizedBox(height: 10.0,),
                  Text('BuNyi Cake adalah sebuah usaha rumahan yang menghadirkan kelezatan dalam setiap produknya. '
                      'Dengan dedikasi tinggi dan kualitas yang terjamin, kami menyajikan berbagai jenis kue dan pastry yang dibuat dengan sepenuh hati untuk memenuhi selera Anda.'
                    ,textAlign: TextAlign.center,),
                  SizedBox(height: 10.0,),
                  Text('Alamat : Dusun Jl. Cibalamoha, RT.03/RW.03, Cisarua, Kec. Cisarua, Kabupaten Sumedang, Jawa Barat 45355',textAlign:
                  TextAlign.center,),
                  Text('Mitra : Jl. Raya Tanjungsiang terminal No.39, Tanjungsiang, Kec. Tanjungsiang, Kabupaten Subang, Jawa Barat 41284',textAlign:
                  TextAlign.center,),
                  TextButton(onPressed: (){_launchURL(url);},
                      child: Text('Hubungi via Whatsapp'))
                ],
              ),
              // Profile image
          ),
        );
  }
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      throw 'Could not launch $url';
    }
  }
}