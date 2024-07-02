import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Header extends StatelessWidget {
  final String headerTitle;
  const Header({super.key, required this.headerTitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            headerTitle,
            style: GoogleFonts.roboto(
              color: Colors.grey[800],
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          // insert widget here like refresh page button, see all tabs button
        ],
      ),

    );

  }
}