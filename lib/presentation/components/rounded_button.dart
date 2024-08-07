import 'package:flutter/material.dart';



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
          minWidth: 100.0,
          height: 14.0,
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600,

            ),
          ),
        ),
      ),
    );
  }
}