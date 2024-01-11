import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:bunyicake/constant/constant.dart';
import 'package:bunyicake/models/models.dart';
import 'package:bunyicake/providers/providers.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../widgets/widgets.dart';
import 'pages.dart';

class ProdPage extends StatefulWidget {
  const ProdPage({super.key, required this.prods});

  final ProdPageArguments prods;

  @override
  ProdPageState createState() => ProdPageState();
}

class ProdPageArguments {
  final String peerIdK;
  final String peerNama;
  final String peerHarga;
  final String peerGambar;

  ProdPageArguments({required this.peerIdK, required this.peerNama, required this.peerHarga, required this.peerGambar});
}

class ProdPageState extends State<ProdPage> {
  late final String currentUserId;

  File? imageFile;
  bool isLoading = false;
  String imageUrl = "";

  late final KatProvider chatProvider = context.read<KatProvider>();
  late final AuthProvider authProvider = context.read<AuthProvider>();

  Widget buildItem(int index, DocumentSnapshot? document) {
    if (document != null) {
      MessageChat messageChat = MessageChat.fromDocument(document);
      if (messageChat.idFrom == currentUserId) {
        // Right (my message)
        return Row();
      } else {
        // Left (peer message)
        return Container(
          child: Column(),
          margin: EdgeInsets.only(bottom: 10),
        );
      }
    } else {
      return SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.themeColor,
        title: Text(
          this.widget.prods.peerNama,
          style: TextStyle(color: ColorConstants.primaryColor),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              // background image and bottom contents
              Center(child:
                Column(
                children: <Widget>[
                  Container(
                    height: 200.0,
                    color: Colors.white,
                    child: Material(
                      child: this.widget.prods.peerGambar.isNotEmpty
                          ? Image.network(
                        this.widget.prods.peerGambar,
                        fit: BoxFit.cover,
                        width: 70,
                        height: 70,
                        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            width: 70,
                            height: 70,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: ColorConstants.themeColor,
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            ),
                          );
                        },
                        errorBuilder: (context, object, stackTrace) {
                          return Icon(
                            Icons.image,
                            size: 70,
                            color: ColorConstants.greyColor,
                          );
                        },
                      )
                          : Icon(
                        Icons.image,
                        size: 70,
                        color: ColorConstants.greyColor,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      clipBehavior: Clip.hardEdge,
                    ),
                  ),
                  SizedBox(height: 70.0,),
                  Text(this.widget.prods.peerNama),
                  SizedBox(height: 10.0,),
                  Text(this.widget.prods.peerHarga,textAlign:
                  TextAlign.center,),
                  SizedBox(height: 10.0,),

                ],
              ),
              ),
              // Loading
              buildLoading()
            ],
          ),
        ),
    );
  }

  Widget buildLoading() {
    return Positioned(
      child: isLoading ? LoadingView() : SizedBox.shrink(),
    );
  }
}