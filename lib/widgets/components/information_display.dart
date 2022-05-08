import 'package:flutter/material.dart';
import 'package:weindb/theme/constants.dart';

/// At the time of writing this doc-comment, I don't know what this class is for.
class InformationDisplay extends StatelessWidget {
  const InformationDisplay({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(right: kDefaultPadding, left: kDefaultPadding),
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(kBorderRadius),
        ),
        height: 50,
        child: Row(
          children: [
            Icon(Icons.label)
          ],
        ),
      ),
    );
  }
}