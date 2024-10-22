import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_birth/screens/eventspage.dart';
import 'package:new_birth/screens/give.dart';
import 'package:new_birth/screens/newbirthBreakThrough.dart';
import 'package:new_birth/screens/watchpage.dart';
import 'package:new_birth/widget/drawer.dart';

import '../bottomnav.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final sectionHeight = screenHeight * 0.20;

    return Scaffold(
      endDrawer: DrawerWidget(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color(0xff5f0cfb),
            Color(0xff982aea),
          ], begin: Alignment.bottomRight, end: Alignment.topLeft)),
        ),
        toolbarHeight: 70,
        title: const Image(
          image: AssetImage('assets/images/new_logo.png'),
          width: 170,
          height: 170,
        ),
        actions: [
          Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
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
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            opacity: 0.6,
              image: AssetImage('assets/images/background_2.jpg'),
              fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  _buildSection(
                    height: sectionHeight,
                    title: "Watch Live",
                    backgroundColor: Colors.black.withOpacity(0.2),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const WatchPage()),
                    ),
                  ),
                  _buildSection(
                    height: sectionHeight,
                    title: "Events",
                    backgroundColor: const Color(0xffc0a357).withOpacity(0.3),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EventPage()),
                    ),
                  ),
                  _buildSection(
                    height: sectionHeight,
                    title: "New Birth Breakthroughs",
                    backgroundColor: Colors.black.withOpacity(0.3),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NewBirthBreakThroughPage()),
                    ),
                  ),
                  _buildSection(
                    height: sectionHeight,
                    title: "Give",
                    backgroundColor: const Color(0xff724dc1).withOpacity(0.3),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GivePage()),
                    ),
                    fontSize: 30, // Larger font size for "Give" section
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSection({
    required double height,
    required String title,
    required Color backgroundColor,
    required VoidCallback onTap,
    double fontSize = 25,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: backgroundColor,
        ),
        child: Center(
          child: Text(
            title,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              decorationColor: Colors.white,
              color: Colors.white,
              decorationThickness: 2,
              fontSize: fontSize,
            ),
          ),
        ),
      ),
    );
  }
}
