import 'package:flutter/material.dart';

class SmallCard extends StatelessWidget {
  const SmallCard({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var cardColor = theme.cardColor;
    var textTheme = theme.textTheme;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 16, 10, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.displayLarge!.copyWith(
                color: theme.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 30,
                height: 1,
              ),
            ),
            Container(
              constraints: BoxConstraints(
                maxHeight: 30,
              ),
              child: FittedBox(
                child: Text(
                  subtitle,
                  maxLines: 1,
                  style: textTheme.displayMedium!.copyWith(
                    // color: theme.textTheme.,
                    // fontWeight: FontWeight.w900,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: cardColor,
        ),
      ),
    );
  }
}
