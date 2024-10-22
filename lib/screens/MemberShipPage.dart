import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_birth/widget/textfield.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../apis/newbirthlinks.dart';
import '../widget/drawer.dart';

class MemberShipPage extends StatefulWidget {
  const MemberShipPage({super.key});

  @override
  State<MemberShipPage> createState() => _MemberShipPageState();
}

class _MemberShipPageState extends State<MemberShipPage> {
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
          "Membership",
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
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 240,
                      width: double.infinity,
                      child: Image(
                        image: AssetImage('assets/images/6.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15, top: 10, right: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Membership',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 22,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Membership is the first step to becoming a part of the New Birth family, Our membership classes are designed to introduce you to the ministry, our visionary, vision, values and what we believe. Steps I and II are the prerequisites for servinq in a minist,-y.",
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Step I — New Birth Orientation',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 22,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Open to all who would like to build stability in his or her Christian life through understanding he basic foundational stones, as well, as becoming acclimated to your New Birth Family Values.",
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 14, right: 20),
                            child: ButtonWidget(
                                color: LinearGradient(
                                    colors: [
                                      Color(0xff5f0cfb),
                                      Color(0xff982aea),
                                    ],
                                    begin: Alignment.bottomRight,
                                    end: Alignment.topLeft),
                                title: 'Register',
                                borderRadius: 10,
                                textColor: Colors.white,
                                onTap: _launchUrlMemberShip1),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Step II — Discovering You',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 22,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'This class is designed to assist you in "Discovering You". Come learn your spiritual gifts, your ministry passions and personal style for strategic placement in the body,',
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 14, right: 20),
                            child: ButtonWidget(
                                color: LinearGradient(
                                    colors: [
                                      Color(0xff5f0cfb),
                                      Color(0xff982aea),
                                    ],
                                    begin: Alignment.bottomRight,
                                    end: Alignment.topLeft),
                                title: 'Register',
                                borderRadius: 10,
                                textColor: Colors.white,
                                onTap: _launchUrlMemberShip2),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Baptism',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 22,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Baptism symbolizes the death of the old nature of sin (our carnal selves) and a resurrection to a new life in Christ Jesus (Romans 6:3-8). It also symbolizes the cleansing power of The Blood of Jesus and an outward testimony of our faith in the Lord Jesus.',
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 14, right: 20),
                            child: ButtonWidget(
                                color: LinearGradient(
                                    colors: [
                                      Color(0xff5f0cfb),
                                      Color(0xff982aea),
                                    ],
                                    begin: Alignment.bottomRight,
                                    end: Alignment.topLeft),
                                title: 'Register',
                                borderRadius: 10,
                                textColor: Colors.white,
                                onTap: _launchUrlMemberShip3),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    )
                  ],
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 0,
                );
              },
              itemCount: 1,
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
          print("Data ${response.body}");
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

  Future<void> _launchUrlMemberShip1() async {
    if (newBirthLinksData == null) return;

    final Uri launchUrlMemberShip =
        Uri.parse(newBirthLinksData!.membershipButton1);
    if (!await launchUrl(launchUrlMemberShip)) {
      print('$launchUrlMemberShip');
      throw Exception('Could not launch $launchUrlMemberShip');
    }
  }

  Future<void> _launchUrlMemberShip2() async {
    if (newBirthLinksData == null) return;

    final Uri launchUrlMemberShip =
        Uri.parse(newBirthLinksData!.membershipButton2);
    if (!await launchUrl(launchUrlMemberShip)) {
      print('$launchUrlMemberShip');
      throw Exception('Could not launch $launchUrlMemberShip');
    }
  }

  Future<void> _launchUrlMemberShip3() async {
    if (newBirthLinksData == null) return;

    final Uri launchUrlMemberShip =
        Uri.parse(newBirthLinksData!.membershipButton3);
    if (!await launchUrl(launchUrlMemberShip)) {
      print('$launchUrlMemberShip');
      throw Exception('Could not launch $launchUrlMemberShip');
    }
  }
}
