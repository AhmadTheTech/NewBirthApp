import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_birth/apis/draweritems.dart';
import 'package:new_birth/apis/newbirthlinks.dart';
import 'package:new_birth/widget/circlewidget.dart';
import 'package:new_birth/widget/drawer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class GivePage extends StatefulWidget {
  const GivePage({super.key});

  @override
  State<GivePage> createState() => _GivePageState();
}

class _GivePageState extends State<GivePage> {
  bool isLoading = false;
  NewBirthLinks? newBirthLinksData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          "Give",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 25,
          ),
        ),
      ),
      body: Center(
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.separated(
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 18,
                      ),
                      GestureDetector(
                          onTap: _launchUrlNewbirth,
                          child: CircleWidget(
                              image: AssetImage("assets/images/newbirth.png"))),
                      SizedBox(
                        height: 18,
                      ),
                      GestureDetector(
                          onTap: _launchUrlGivelify,
                          child: CircleWidget(
                              image: AssetImage("assets/images/givelify.png"))),
                      SizedBox(
                        height: 18,
                      ),
                      GestureDetector(
                          onTap: _launchUrlPushpay,
                          child: CircleWidget(
                              image: AssetImage("assets/images/pushpay.png"))),
                    ],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 0,
                  );
                },
              ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 0,
        child: Text(
          "You may also text nbgive to 77977 to contribute",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 19,
          ),
        ),
      ),
    );
  }

  Future<void> getData() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse(
          'https://devsline.tech/new-birth/wp-json/page/v2/nb_external_links'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          newBirthLinksData = NewBirthLinks.fromJson(data);
          isLoading = false;
        });
      } else {
        throw Exception(
            'Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching drawer items: $e');
    }
  }

  Future<void> _launchUrlGivelify() async {
    if (newBirthLinksData == null) return;

    final Uri launchUrlGivelify = Uri.parse(newBirthLinksData!.giveLink2);
    if (!await launchUrl(launchUrlGivelify)) {
      print('$launchUrlGivelify');
      throw Exception('Could not launch $launchUrlGivelify');
    }
  }

  Future<void> _launchUrlPushpay() async {
    if (newBirthLinksData == null) return;

    final Uri launchUrlPushpay = Uri.parse(newBirthLinksData!.giveLink3);
    if (!await launchUrl(launchUrlPushpay)) {
      print('$launchUrlPushpay');
      throw Exception('Could not launch $launchUrlPushpay');
    }
  }

  Future<void> _launchUrlNewbirth() async {
    if (newBirthLinksData == null) return;

    final Uri newBirth = Uri.parse(newBirthLinksData!.giveLink1);
    if (!await launchUrl(newBirth)) {
      print(newBirth);
      throw Exception("Could not launch $newBirth");
    }
  }
}
