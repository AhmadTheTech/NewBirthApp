import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widget/drawer.dart';

class OurPastor extends StatefulWidget {
  const OurPastor({super.key});

  @override
  State<OurPastor> createState() => _OurPastorState();
}

class _OurPastorState extends State<OurPastor> {
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
          "Our Pastors",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 25,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 240,
              width: double.infinity,
              child: Image(image: AssetImage('assets/images/1.jpg') , fit: BoxFit.cover,),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                top: 10,
                right: 07
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dr. Bryant',
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
                  Text("Dr. Bryant embodies the rare balance of spiritual gifts and practical educational experiences that connects pastoral leadership and discipledship teaching with prophetic preaching and courageous social action. Dr. Bryant is equipped and poised to initiate theological revival, decisive commitment and rededication to the teachings of Jesus the Christ as the foundation for personal living, family stability and community development." , style: GoogleFonts.roboto(
                    fontSize: 16,
                  ),),
                  SizedBox(
                    height: 20,
                  ),
                  Text(style: GoogleFonts.poppins(
                    fontSize: 16,
                  ),"Dr. Bryant is not only known as a riveting speaker but has earned a reputation as a social justice activist. Prior to pastoring, he served as the national youth and college director of the NAACP for six years, leading about 70,000 young people worldwide on non- violent campaigns."),
                  SizedBox(
                    height: 20,
                  ),
                  Text(style: GoogleFonts.poppins(
                    fontSize: 16,
                  ),"Dr. Bryant earned his Bachelor s Degree from Morehouse College and a Masters of Divinity from Duke University. He studied at Oxford  University in Great Britain and earned a doctorate from The Graduate Theological Foundation."),
                  SizedBox(
                    height: 20,
                  ),
                ],

              ),
            )
          ],
        ),
      ),
    );
  }
}
