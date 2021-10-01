import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CountListItem extends StatelessWidget {
  final Map<String, int> values;
  CountListItem(this.values);
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextStyle textStyle =
        TextStyle(color: theme.colorScheme.onPrimary, fontSize: 17);
    TextStyle numberTextStyle = GoogleFonts.quicksand(
      textStyle: TextStyle(
        color: theme.colorScheme.onPrimary,
        fontSize: 40,
        fontWeight: FontWeight.bold,
      ),
    );
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryVariant,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          for (int i = 0; i < values.length; i++) 
            Expanded(
              child: Container(
                alignment: Alignment.center,
                // padding: EdgeInsets.only(right: i < values.length - 1 ? 10 : 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FittedBox(
                      child: Text(
                        values.keys.toList()[i],
                        style: textStyle,
                      ),
                    ),
                    FittedBox(
                      child: Text(
                        values.values.toList()[i].toString(),
                        style: numberTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ),

        ],
      ),
    );
  }
}
