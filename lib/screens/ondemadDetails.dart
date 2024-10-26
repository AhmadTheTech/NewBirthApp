import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vimeo_player_flutter/vimeo_player_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../widget/drawer.dart';

class OnDemadDetails extends StatefulWidget {
  final int id;
  final String duration;
  final String title;
  final String description;
  final String videoUrl;
  const OnDemadDetails(
      {super.key,
      required this.id,
      required this.duration,
      required this.videoUrl,
      required this.title,
      required this.description});

  @override
  State<OnDemadDetails> createState() => _OnDemadDetailsState();
}

class _OnDemadDetailsState extends State<OnDemadDetails> {
  late final String videoId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    videoId = widget.videoUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: DrawerWidget(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xff5f0cfb),
              Color(0xff982aea),
            ], begin: Alignment.bottomRight, end: Alignment.topLeft),
          ),
        ),
        actions: [
          Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(
                  Icons.menu,
                  size: 30,
                ),
                color: Colors.white,
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              );
            },
          ),
        ],
        toolbarHeight: 60,
        title: Text(
          textAlign: TextAlign.center,
          widget.title,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 25,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 250,
            child: VimeoPlayer(videoId: videoId),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: GoogleFonts.poppins(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 06,
                ),
                Text(
                  widget.description,
                  style: GoogleFonts.poppins(
                      fontSize: 17, fontWeight: FontWeight.w400),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
