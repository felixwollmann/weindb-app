import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DescriptionItem extends StatelessWidget {
  final String beschreibung;

  DescriptionItem(this.beschreibung);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    final TextStyle titleStyle = GoogleFonts.quicksand(
      fontWeight: FontWeight.bold,
      color: theme.colorScheme.onPrimary,
      fontSize: 20,
    );

    final TextStyle descriptionStyle = GoogleFonts.openSans(
      color: theme.colorScheme.onPrimary
    );

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryVariant,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              'Beschreibung',
              style: titleStyle,
            ),
          ),
          Text(
            beschreibung,
            style: descriptionStyle,
          )
        ],
      ),
    );
  }
}