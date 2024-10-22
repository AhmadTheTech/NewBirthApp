import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputFields extends StatelessWidget {
  final String title;
  final double borderRadius;
  final double? contentPadding;
  final TextEditingController? controller;
  final bool isPass;

  const InputFields({
    super.key,
    required this.title,
    required this.borderRadius,
    this.controller,
    required this.isPass,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPass,
      decoration: InputDecoration(
        suffixIcon: isPass ? const Icon(Icons.visibility) : null,
        contentPadding: EdgeInsets.symmetric(vertical: contentPadding ?? 17, horizontal: 14),
        hintText: title,
        hintStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        fillColor: Colors.transparent,
        filled: true,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(
            color: Colors.black,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(
            color: Colors.black,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}


class ButtonWidget extends StatelessWidget {
  final LinearGradient color;
  final double borderRadius;
  final String title;
  final Color textColor;
  final VoidCallback onTap;
  const ButtonWidget(
      {super.key,
        required this.color,
        required this.title,
        required this.borderRadius,
        required this.textColor,
        required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width * 1,
        decoration: BoxDecoration(
        gradient: color,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Center(
          child: Text(
            title,
            style: GoogleFonts.notoSansArabic(
                fontSize: 21, fontWeight: FontWeight.bold, color: textColor),
          ),
        ),
      ),
    );
  }
}
