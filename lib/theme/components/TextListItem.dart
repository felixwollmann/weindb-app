import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextListItem extends StatelessWidget {
  final String name;
  final String value;
  TextListItem({
    required this.name,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextStyle nameStyle = GoogleFonts.quicksand(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: theme.colorScheme.onPrimary,
    );
    TextStyle valueStyle = TextStyle(
      fontSize: 20,
      color: theme.colorScheme.onPrimary,
    );
    return Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        height: 65,
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryVariant,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Text(name, style: nameStyle),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 5),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerRight,
                  child: Text(
                    value,
                    style: valueStyle,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}