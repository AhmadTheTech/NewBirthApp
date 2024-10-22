import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_birth/widget/circlewidget.dart';
import 'package:new_birth/widget/drawer.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {
  ContactPage({Key? key}) : super(key: key);

  final Uri _mapUrl = Uri.parse(
      'https://www.google.com/maps/place/6400+Woodrow+Rd,+Stonecrest,+GA+30038,+USA/@33.6989844,-84.1364319,17z/data=!3m1!4b1!4m6!3m5!1s0x88f5ad06fc8548e9:0xea4ef5762d7eab3d!8m2!3d33.6989844!4d-84.1364319!16s%2Fg%2F11c3q3q37n?entry=ttu&g_ep=EgoyMDI0MTAxNi4wIKXMDSoASAFQAw%3D%3D');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: DrawerWidget(),
      appBar: _buildAppBar(context),
      backgroundColor: Colors.white,
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
      actions: [
        Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu, size: 30, color: Colors.white),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            );
          },
        ),
      ],
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff5f0cfb), Color(0xff982aea)],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
        ),
      ),
      toolbarHeight: 60,
      title: Text(
        "Contact Us",
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          color: Colors.white,
          fontSize: 25,
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Center(
            child: CircleWidget(
              image: AssetImage("assets/images/new_logo_black.png") ,
              height: 210,
              width: 210,
            ),
          ),
          SizedBox(height: 60),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildContactItem(
                  "Phone: (770)696-9600",
                  onTap: () => _makePhoneCall("7706969600"),
                ),
                _buildContactItem(
                  "Address: 6400 Woodrow Rd\nLithonia, GA 30038",
                  onTap: _launchMapUrl,
                ),
                _buildContactItem("Office Hours: Tues-Fri 9AM-5PM"),
                _buildContactItem(
                    'Worship Times: Sunday 9:30 AM\nTuesday Group Therapy 7:30 PM'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(String text, {VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Future<void> _launchMapUrl() async {
    if (!await launchUrl(_mapUrl)) {
      throw Exception('Could not launch $_mapUrl');
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
}
