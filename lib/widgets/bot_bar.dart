
import 'package:flutter/material.dart';
import 'package:bunyicake/constant/constant.dart';
import 'package:bunyicake/pages/home.dart';
import 'package:bunyicake/pages/katalog.dart';
import 'package:bunyicake/pages/tentang.dart';


class BotBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0,
      onTap: (index){
        switch(index){
          case 0:
            Navigator.push(context, MaterialPageRoute(builder: (context) => KatPage()));
            break;
          case 1:
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
            break;
          case 2:
            Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
            break;
        }
      },
      items: const<BottomNavigationBarItem> [
      BottomNavigationBarItem(icon: Icon(Icons.menu),label: "Katalog"),
      BottomNavigationBarItem(icon: Icon(Icons.message_outlined),label: "Obrolan"),
      BottomNavigationBarItem(icon: Icon(Icons.info_outline),label: "Tentang",),
    ],
      backgroundColor : ColorConstants.themeColor,
      selectedItemColor:Colors.black,
      unselectedItemColor: Colors.black,
    );
  }
}