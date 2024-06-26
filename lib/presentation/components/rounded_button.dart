import 'package:flutter/material.dart';

// example usage: RoundedButton(title: 'Log In', colour: Colors.lightBlueAccent, onPressed: () {
// Navigator.pushNamed(context, LoginScreen.id);
// },
// );

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
          height: 42.0,
          child: Text(
            title,
          ),
        ),
      ),
    );
  }
}