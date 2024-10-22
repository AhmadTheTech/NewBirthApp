import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:new_birth/screens/videopage.dart';

import '../apis/live.dart';
import '../widget/drawer.dart';

class WatchPage extends StatefulWidget {
  const WatchPage({super.key});

  @override
  State<WatchPage> createState() => _WatchPageState();
}

class _WatchPageState extends State<WatchPage> {
  bool isLoading = false;
  List<WatchLive> liveList = [];
  @override
  void initState() {
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
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color(0xff5f0cfb),
            Color(0xff982aea),
          ], begin: Alignment.bottomRight, end: Alignment.topLeft)),
        ),
        toolbarHeight: 60,
        title: Text(
          "Live",
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
          : liveList.isEmpty
              ? Center(
                  child: Text("No Data Available"),
                )
              : ListView.builder(
                  itemCount: liveList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final live = liveList[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LiveVideoPage(
                                          videoUrl: live.facebookVideoUrl,
                                          title: live.title,
                                        )));
                          },
                          child: Container(
                            height: 230,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                image: DecorationImage(
                                    image: NetworkImage(live.image),
                                    fit: BoxFit.cover)),
                            child: const Center(
                              child: Icon(
                                Icons.play_circle,
                                color: Colors.white,
                                size: 55,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 05,
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          live.title,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ],
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
      final response = await http.get(
          Uri.parse('https://devsline.tech/new-birth/wp-json/page/v2/live'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          liveList =
              data.map<WatchLive>((json) => WatchLive.fromJson(json)).toList();
          isLoading = false;
          print("Data Load Success: ${response.body}");
        });
      } else {
        throw Exception(
            'Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching Live items: $e');
    }
  }
}
