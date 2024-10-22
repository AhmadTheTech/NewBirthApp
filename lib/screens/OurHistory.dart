import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:new_birth/apis/newbirthlinks.dart';
import 'package:new_birth/widget/drawer.dart';

class OurHistory extends StatefulWidget {
  const OurHistory({super.key});

  @override
  State<OurHistory> createState() => _OurHistoryState();
}

class _OurHistoryState extends State<OurHistory> {
  NewBirthLinks? newBirthLinksData;
  late final WebViewController controller;
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    try {
      await getData();
      if (newBirthLinksData != null) {
        _initializeWebView();
      }
    } catch (e) {
      setState(() {
        error = 'Failed to initialize the History. Please try again later.';
        isLoading = false;
      });
    }
  }

  void _initializeWebView() {
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
                this.error = 'Failed to load the history. Please check your connection.';
                isLoading = false;
              });
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(newBirthLinksData?.ourHistoryLink ?? ''));
  }

  Future<void> getData() async {
    try {
      final response = await http.get(
        Uri.parse('https://devsline.tech/new-birth/wp-json/page/v2/nb_external_links'),
      );

      if (!mounted) return;

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          newBirthLinksData = NewBirthLinks.fromJson(data);
          error = null;
        });
      } else {
        throw Exception('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        error = 'Failed to load store data. Please check your connection.';
        isLoading = false;
      });
      debugPrint('Error fetching store data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const DrawerWidget(),
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
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
        "Our History",
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          color: Colors.white,
          fontSize: 25,
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              error!,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _initializeData,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (newBirthLinksData == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Stack(
      children: [
        WebViewWidget(controller: controller),
        if (isLoading)
          const Center(child: CircularProgressIndicator()),
      ],
    );
  }
}