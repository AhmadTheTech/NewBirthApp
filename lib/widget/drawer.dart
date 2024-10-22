import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_birth/bottomnav.dart';
import 'package:http/http.dart' as http;
import 'package:new_birth/screens/notes.dart';
import '../apis/draweritems.dart';
import 'package:new_birth/screens/about_page2.dart';
import '../screens/contact.dart';
import 'package:url_launcher/url_launcher.dart';
import '../screens/draweritemsdetails.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final Uri _facebook = Uri.parse('https://www.facebook.com/NewBirthMBC1');
  final Uri _instagram = Uri.parse('https://www.instagram.com/NewBirthMBC/');
  final Uri _youtube = Uri.parse('https://www.youtube.com/NewBirthMBC1');
  final Uri _twitter = Uri.parse('https://www.twitter.com/NewBirthMBC');
  DrawerItems? drawerItemsData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : _buildDrawerContent(),
      ),
    );
  }

  // Widget _buildLoadingShimmer() {
  //   return ListView.builder(
  //     shrinkWrap: true,
  //     itemBuilder: (BuildContext context, int index) {
  //       return Padding(
  //         padding: const EdgeInsets.all(18.0),
  //         child: Shimmer.fromColors(
  //           baseColor: Colors.grey[300]!,
  //           highlightColor: Colors.grey[100]!,
  //           child: Container(
  //             height: 50,
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(10),
  //               color: Colors.white,
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  Widget _buildDrawerContent() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDrawerItem("Home", () => _navigateTo(BottomNav())),
          _buildDrawerItem("About", () => _navigateTo(AboutPage2())),
          ...drawerItemsData!.links.map((item) =>
              _buildDrawerItem(item.title, () => _launchURL(item.url , item.title))),
          _buildDrawerItem("Contact", () => _navigateTo( ContactPage())),
          _buildDrawerItem(
              "Sermons Notes", () => _navigateTo(const SermonsNotes())),
          const SizedBox(height: 20),
          _buildSocialMediaSection(),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          title,
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
    );
  }

  Widget _buildSocialMediaSection() {
    return Column(
      children: [
        Text(
          "Follow NewBirth",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _launchUrlFacebook,
                child: _buildSocialIcon(FontAwesomeIcons.facebook)),
            GestureDetector(
              onTap: _launchUrlInstagram,
                child: _buildSocialIcon(FontAwesomeIcons.instagram)),
            GestureDetector(
              onTap: _launchUrlTwitter,
                child: _buildSocialIcon(FontAwesomeIcons.twitter)),
            GestureDetector(
              onTap: _launchUrlYoutube,
                child: _buildSocialIcon(FontAwesomeIcons.youtube)),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Icon(icon, color: Colors.grey, size: 30),
    );
  }

  void _navigateTo(Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  void _launchURL(String url , String title) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => DrawerItemsDetail(url: url, title: title,)));
    print('Launching URL: $url');
  }

  Future<void> getData() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse(
          'https://devsline.tech/new-birth/wp-json/page/v2/sidebar_links'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          drawerItemsData = DrawerItems.fromJson(data);
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
  Future<void> _launchUrlFacebook() async {
    if (!await launchUrl(_facebook)) {
      print('$_facebook');
      throw Exception('Could not launch $_facebook');
    }
  }
  Future<void> _launchUrlInstagram() async {
    if (!await launchUrl(_instagram)) {
      print('$_instagram');
      throw Exception('Could not launch $_facebook');
    }
  }
  Future<void> _launchUrlYoutube() async {
    if (!await launchUrl(_youtube)) {
      print('$_youtube');
      throw Exception('Could not launch $_youtube');
    }
  }
  Future<void> _launchUrlTwitter() async {
    if (!await launchUrl(_twitter)) {
      print('$_twitter');
      throw Exception('Could not launch $_twitter');
    }
  }
}

