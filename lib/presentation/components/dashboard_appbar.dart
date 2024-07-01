import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardAppbar extends StatelessWidget implements PreferredSizeWidget {
  const DashboardAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Icon(Icons.people, color: Colors.grey[600]),
        ),
      ],
      backgroundColor: Colors.white,
      centerTitle: false,
      elevation: 0.0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Image.asset('assets/icon/drench.png'),
      ),
      title: Text(
        "DrenchMate",
        style: GoogleFonts.inconsolata(
          color: Colors.grey[800],
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
