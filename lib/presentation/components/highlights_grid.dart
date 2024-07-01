import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:drenchmate_2024/presentation/components/rounded_button.dart';

class HighlightsGrid extends StatelessWidget {
  HighlightsGrid({super.key});

  final List<String> highlights = ['Mobs', 'Property', 'Drench'];
  final List<String> buttonText = ['Setup a Mob', 'Setup a Property', 'Setup a Drench'];
  final List<String> nextPage = [];
  final List<Color> colors =  [Colors.grey, Colors.green, Colors.blue];
  final List<Image> icons = [
    Image.asset('assets/icon/mob.png'),
    Image.asset('assets/icon/property.png'),
    Image.asset('assets/icon/drench.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GridView.builder(
        physics: const ScrollPhysics(),
        shrinkWrap: true,
        itemCount: highlights.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3,
          crossAxisSpacing: 6,
          mainAxisSpacing: 5,
        ),

        itemBuilder: (context, index) {
          return Container(
            height: 100.0,
            margin: const EdgeInsets.all(1.0),
            child: Card(
              color: colors[index],
              elevation: 8.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
              ),
              margin: const EdgeInsets.all(1.0),



                child: ListTile(
                  contentPadding: EdgeInsets.zero,

                  title: Text(
                    highlights[index],
                    style: GoogleFonts.dangrek(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w300,
                    ),
                  ),

                  trailing: Icon(
                    Icons.smart_display,
                    color: Colors.grey[800],
                  )
                )

            ),
          );
        },
      )
    );
  }
}