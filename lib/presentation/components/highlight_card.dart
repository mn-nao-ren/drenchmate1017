// highlight_card.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HighlightCard extends StatelessWidget {
  final Color color;
  final String icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const HighlightCard({
    required this.color,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipOval(child: Image.asset(icon, height: 40, width: 40)),
            const SizedBox(height: 5),
            Text(
              title,
              style: GoogleFonts.epilogue(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              subtitle,
              style: GoogleFonts.epilogue(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w400),
            ),
            // add a small button later on, eg Button(),
          ],
        ),
      ),
    );
  }
}
