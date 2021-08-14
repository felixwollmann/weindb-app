import 'package:flutter/material.dart';
import 'package:weindb/theme/components/AllComponents.dart';
import 'package:weindb/classes/classes.dart';

const String appBarName = 'Regionen';

List<Widget> detailsChildren(Region region, BuildContext context) {
  return <Widget>[
    IconListItem(
      icon: Icons.local_offer,
      text: region.name,
    ),
    TextListItem(name: 'Land', value: region.land),
    if (region.beschreibung != null) DescriptionItem(region.beschreibung!),
  ];
}

Widget listItem(Region region, void Function(Region, BuildContext) tapped,
    BuildContext context) {
  return ListTile(
    title: Text(region.name),
    subtitle: Text(region.land),
    onTap: () {
      tapped(region, context);
    },
  );
}

final IconData icon = Icons.map;