import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:drenchmate_2024/presentation/components/rounded_button.dart';

class HighlightsGrid extends StatelessWidget {
  HighlightsGrid({super.key});

  final List<String> highlights = ['Mobs', 'Property', 'Drench'];
  final List<String> buttonText = ['Setup a Mob', 'Setup a Property', 'Setup a Drench'];
  final List<String> nextPage = [];
  final List<Color> colors =  [Colors.grey, Colors.lightBlue, Colors.blue];
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
          return Card(
            color: colors[index],

            elevation: 8.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            margin: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  icons[index],
                  Text(
                    highlights[index],
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  // DataDisplaySection(),
                  RoundedButton(
                    title: buttonText[index],
                    color: Colors.blue,
                    onPressed: () async {
                      // navigate to individual pages
                    },
                  ),
                ],
              )
            )
          );
        },
      )
    );
  }
}