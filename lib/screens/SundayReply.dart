import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_birth/apis/sunday.dart';
import 'package:http/http.dart' as http;
import 'package:new_birth/widget/drawer.dart';

import 'ondemadDetails.dart';

class SundayReplyPage extends StatefulWidget {
  const SundayReplyPage({super.key});

  @override
  State<SundayReplyPage> createState() => _SundayReplyPageState();
}

class _SundayReplyPageState extends State<SundayReplyPage> {
  bool isLoading = false;
  List<SundayReply> sundayData = [];

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
          "Sunday Reply",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 25,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              itemCount: sundayData.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                  childAspectRatio: 1 / 1),
              itemBuilder: (context, index) {
                final sunday = sundayData[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OnDemadDetails(
                                  videoUrl: sunday.videoUrl,
                                  title: sunday.title,
                                  duration: sunday.duration,
                                  id: sunday.id,
                                  description: sunday.description,
                                )));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(7),
                    child: Stack(
                      children: [
                        Container(
                          height: 280,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: LinearGradient(
                                colors: [
                                  Color(0xff5f0cfb),
                                  Color(0xff982aea),
                                ],
                                begin: Alignment.bottomRight,
                                end: Alignment.topLeft),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.network(
                            sunday.image,
                            fit: BoxFit.cover,
                            height: 280,
                            width: double.infinity,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey,
                              );
                            },
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Colors.black.withOpacity(0.6),
                          ),
                          height: 280,
                          width: double.infinity,
                        ),
                        Positioned.fill(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Text(
                                  sunday.title,
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
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
          'https://devsline.tech/new-birth/wp-json/sermons/v2/sunday-reply'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          sundayData = data.map((json) => SundayReply.fromJson(json)).toList();
          isLoading = false;
          print('Data received: ${response.body},');
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
