import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class RoundedButton extends StatelessWidget {
  const RoundedButton({super.key,
    required this.title,
    required this.color,
    required this.onPressed
  });

  final Color color;
  final String title;

  final void Function()? onPressed;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 50.0,
          child: Text(
            title,
            style: GoogleFonts.lobster(
              color: Colors.white,
              fontSize: 21,
              fontWeight: FontWeight.w100,

            ),
          ),
        ),
      ),
    );
  }
}