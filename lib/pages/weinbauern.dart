import 'package:flutter/material.dart';
import 'package:weindb/theme/components/AllComponents.dart';
import 'package:weindb/classes/classes.dart';

const String appBarName = 'Weinbauern';

List<Widget> detailsChildren(Weinbauer weinbauer, BuildContext context) {
  return <Widget>[
    IconListItem(
      icon: Icons.local_offer,
      text: weinbauer.name,
    ),
    if (weinbauer.region != null)
      IconListItem(
        icon: Icons.map,
        text: weinbauer.region!.name,
        onTap: () {RegionenPage.tapped(weinbauer.region!, context);}
      ),
    if (weinbauer.beschreibung != null)
      DescriptionItem(
        weinbauer.beschreibung!,
      ),

  ];
}

Widget listItem(Weinbauer weinbauer, void Function(Weinbauer, BuildContext) tapped,
    BuildContext context) {
  return ListTile(
    title: Text(weinbauer.name),
    subtitle: weinbauer.region != null ? Text(weinbauer.region!.name) : null,
    onTap: () {
      tapped(weinbauer, context);
    },
  );
}

final IconData icon = Icons.agriculture;
