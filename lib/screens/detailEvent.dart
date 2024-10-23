import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_birth/widget/card.dart';
import 'package:new_birth/widget/drawer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EventDetailPage extends StatefulWidget {
  final String title;
  final String description;
  final String fullDate;
  final String time;
  final String address;
  final String phone;
  final String webViewUrl;
  final String year;
  final String image;
  const EventDetailPage({super.key, required this.title, required this.description, required this.fullDate, required this.time, required this.address, required this.phone, required this.image, required this.webViewUrl, required this.year});

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  bool isLoading = false;
  late WebViewController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            if (mounted) {
              setState(() => isLoading = true);
            }
          },
          onPageFinished: (String url) {
            if (mounted) {
              setState(() => isLoading = false);
            }
          },
          onWebResourceError: (WebResourceError error) {
            if (mounted) {
              setState(() {
                isLoading = false;
              });
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.webViewUrl));
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
      body: isLoading ? Center(child: CircularProgressIndicator(),) : WebViewWidget(controller: controller),
    );
  }
}
