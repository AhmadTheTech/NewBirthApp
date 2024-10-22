import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_birth/widget/card.dart';
import 'package:new_birth/widget/drawer.dart';

class EventDetailPage extends StatefulWidget {
  final String title;
  final String description;
  final String fullDate;
  final String time;
  final String address;
  final String phone;
  final String fax;
  final String email;
  final String image;
  const EventDetailPage({super.key, required this.title, required this.description, required this.fullDate, required this.time, required this.address, required this.phone, required this.fax, required this.email, required this.image});

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
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
          "Event Detail",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 25,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Color(0xfff0f0f0),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 230,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  image: DecorationImage(
                    image: NetworkImage(widget.image),
                    fit: BoxFit.cover,
                  ),
                ),
                // child: Container(
                //   color: Colors.black54,
                //   alignment: Alignment.center,
                //   child: Text(
                //     "Upcoming Event!",
                //     style: GoogleFonts.poppins(
                //       color: Colors.white,
                //       fontSize: 26,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CardWidget(
                      icon: Icons.label,
                      title: 'Title',
                      info: widget.title,
                    ),
                    CardWidget(
                      icon: Icons.description,
                      title: 'Description',
                      info: widget.description,
                    ),
                    CardWidget(
                      icon: Icons.today,
                      title: 'Full Date',
                      info: widget.fullDate,
                    ),
                    CardWidget(
                      icon: Icons.access_time_filled,
                      title: 'Time',
                      info: widget.time,
                    ),
                    CardWidget(
                      icon: Icons.pin_drop_sharp,
                      title: 'Address',
                      info: widget.address,
                    ),
                    CardWidget(
                      icon: Icons.phone,
                      title: 'Phone',
                      info: widget.phone,
                    ),
                    CardWidget(
                      icon: Icons.print,
                      title: 'Fax',
                      info: widget.fax,
                    ),
                    CardWidget(
                      icon: Icons.mail,
                      title: 'Email',
                      info: widget.email,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
