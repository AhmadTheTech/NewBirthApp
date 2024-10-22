import 'package:flutter/material.dart';

class CircleWidget extends StatelessWidget {
  final  AssetImage image;
  final  double? height;
  final  double? width;
  const CircleWidget({super.key, required this.image, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 200,
      width: width ?? 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10000),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey,
                blurRadius: 2,
                spreadRadius: 1
            )
          ]
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Image(
            image: image,
          ),
        ),
      ),
    );
  }
}
