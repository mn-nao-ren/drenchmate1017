// highlight_card.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HighlightCard extends StatelessWidget {
  final Color color;
  final String icon;
  final String title;
  final String subtitle;
  final String buttonText;
//  final VoidCallback onTap;
  final VoidCallback onButtonPressed;

  const HighlightCard({
    super.key,
    required this.color,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    // required this.onTap,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: const EdgeInsets.all(11.0),
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
            const SizedBox(height: 14),

            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(7),
                  backgroundColor: Colors.lightBlue.withOpacity(0.6),
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(fontSize: 12),
                ),
                onPressed: () {},
                child: Text(buttonText),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
