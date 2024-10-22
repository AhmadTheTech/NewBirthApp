import 'dart:convert';
import 'package:chewie/chewie.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_birth/apis/new_birth.dart';
import 'package:video_player/video_player.dart';
import '../apis/sunday.dart';
import '../widget/drawer.dart';

class NewBirthBreakThroughPage extends StatefulWidget {
  const NewBirthBreakThroughPage({super.key});

  @override
  State<NewBirthBreakThroughPage> createState() =>
      _NewBirthBreakThroughPageState();
}

class _NewBirthBreakThroughPageState extends State<NewBirthBreakThroughPage> {
  bool isLoading = false;
  List<NewBirthBreakThrough> newBirthBreakThroughData = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
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
            )),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color(0xff5f0cfb),
            Color(0xff982aea),
          ], begin: Alignment.bottomRight, end: Alignment.topLeft)),
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
          "New Birth Break Through",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 25,
          ),
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.separated(
              itemCount: newBirthBreakThroughData.length,
              itemBuilder: (BuildContext context, int index) {
                final newBirthData = newBirthBreakThroughData[index];
                return Column(
                  children: [
                    SizedBox(
                      height: 04,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      NewBirthBreakThroughDetail(
                                        title: newBirthData.title,
                                        description: newBirthData.description,
                                        videoUrl: newBirthData.videoUrl,
                                        date: newBirthData.date,
                                        image: newBirthData.image,
                                      )));
                        },
                        child: Container(
                          height: 220,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: NetworkImage(newBirthData.image),
                                  fit: BoxFit.cover,
                                  opacity: 0.5)),
                          child: Center(
                            child: Text(
                              newBirthData.title,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontSize: 26,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 0,
                );
              },
            ),
    );
  }

  Future<void> getData() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse(
          'https://devsline.tech/new-birth/wp-json/announcements/v2/all'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          newBirthBreakThroughData =
              data.map((json) => NewBirthBreakThrough.fromJson(json)).toList();
          isLoading = false;
          print("RESPONSE = ${response.body}");
        });
      } else {
        throw Exception(
            'Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching Events items: $e');
    }
  }
}

class NewBirthBreakThroughDetail extends StatefulWidget {
  final String title;
  final String image;
  final String date;
  final String videoUrl;
  final String description;
  const NewBirthBreakThroughDetail(
      {super.key,
      required this.title,
      required this.date,
      required this.videoUrl,
      required this.description,
      required this.image});

  @override
  State<NewBirthBreakThroughDetail> createState() =>
      _NewBirthBreakThroughDetailState();
}

class _NewBirthBreakThroughDetailState
    extends State<NewBirthBreakThroughDetail> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;
  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    _chewieController = ChewieController(
        allowFullScreen: true,
        allowMuting: true,
        looping: true,
        aspectRatio: 17 / 9,
        autoPlay: true,
        zoomAndPan: true,
        placeholder: Container(
          color: Colors.grey,
        ),
        videoPlayerController: _controller);
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
            )),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color(0xff5f0cfb),
            Color(0xff982aea),
          ], begin: Alignment.bottomRight, end: Alignment.topLeft)),
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
          widget.title,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 25,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 220,
            child: Chewie(controller: _chewieController),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 08,
                ),
                Text(
                  widget.description,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
