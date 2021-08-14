import 'package:flutter/material.dart';
import 'package:weindb/theme/components/AllComponents.dart';
import 'package:weindb/classes/classes.dart';

import 'package:weindb/theme/colors.dart';

const String appBarName = 'Sorten';

List<Widget> detailsChildren(Sorte sorte, BuildContext context) {
  return <Widget>[
    IconListItem(
      icon: Icons.local_offer,
      text: sorte.name,
    ),
    TextListItem(name: 'Farbe', value: sorte.humanFarbenName)
  ];
}

Widget listItem(Sorte sorte, void Function(Sorte, BuildContext) tapped,
    BuildContext context) {
  return ListTile(
    title: Text(sorte.name),
    subtitle: Text(sorte.humanFarbenName),
    leading: Container(
      width: 25,
      alignment: Alignment.center,
      child: Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.wein(sorte.farbenName),
        ),
      ),
    ),
    onTap: () {
      tapped(sorte, context);
    },
  );
}

final IconData icon = Icons.category;
