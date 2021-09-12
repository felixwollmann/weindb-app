import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
import 'package:weindb/classes/classes.dart';
import 'package:weindb/theme/colors.dart';

// import 'package:weindb/theme/components/TextListItem.dart';
// import 'package:weindb/theme/components/IconListItem.dart';
// import 'package:weindb/theme/components/CountListItem.dart';
// import 'package:weindb/theme/components/DescriptionListItem.dart';

import 'package:weindb/theme/components/AllComponents.dart';

const String appBarName = 'Wein';

class DetailsChildren extends StatelessWidget {
  final int weinId;
  const DetailsChildren(this.weinId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Wein wein = Provider.of<Weine>(context)[weinId]!;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        IconListItem(
          icon: Icons.local_offer,
          text: wein.name,
        ),
        IconListItem(
          icon: Icons.category,
          text: wein.sorte.name,
          onTap: () {
            SortenPage.tapped(wein.sorte, context);
          },
        ),
        if (wein.weinbauer != null)
          IconListItem(
              icon: Icons.agriculture,
              text: wein.weinbauer!.name,
              onTap: () {
                WeinbauernPage.tapped(wein.weinbauer!, context);
              }),
        CountListItem({
          'Vorhanden': wein.anzahl,
          'Getrunken': wein.getrunken,
          if (wein.fach != null) 'Fach': wein.fach!,
        }),
        if (wein.jahr != null)
          TextListItem(name: 'Jahrgang', value: wein.jahr.toString()),
        if (wein.inhalt != null)
          TextListItem(name: 'Inhalt', value: '${wein.inhalt}l'),
        if (wein.preis != null)
          TextListItem(name: 'Preis', value: '${wein.preis}€'),
        if (wein.gekauft !=
            null) // Echt kein Bock mich mit i18n herumzuschlagen also einfach das schirche aber funktionale da
          TextListItem(
            name: 'Gekauft',
            value:
                '${wein.gekauft!.day}.${wein.gekauft!.month}.${wein.gekauft!.year}',
          ),
        if (wein.beschreibung != null) DescriptionItem(wein.beschreibung!),
      ],
    );
  }
}

// @deprecated
List<Widget> detailsChildren(Wein wein, BuildContext context) {
  return <Widget>[
    IconListItem(
      icon: Icons.local_offer,
      text: wein.name,
    ),
    IconListItem(
      icon: Icons.category,
      text: wein.sorte.name,
      onTap: () {
        SortenPage.tapped(wein.sorte, context);
      },
    ),
    if (wein.weinbauer != null)
      IconListItem(
          icon: Icons.agriculture,
          text: wein.weinbauer!.name,
          onTap: () {
            WeinbauernPage.tapped(wein.weinbauer!, context);
          }),
    CountListItem({
      'Vorhanden': wein.anzahl,
      'Getrunken': wein.getrunken,
      if (wein.fach != null) 'Fach': wein.fach!,
    }),
    if (wein.jahr != null)
      TextListItem(name: 'Jahrgang', value: wein.jahr.toString()),
    if (wein.inhalt != null)
      TextListItem(name: 'Inhalt', value: '${wein.inhalt}l'),
    if (wein.preis != null)
      TextListItem(name: 'Preis', value: '${wein.preis}€'),
    if (wein.gekauft !=
        null) // Echt kein Bock mich mit i18n herumzuschlagen also einfach das schirche aber funktionale da
      TextListItem(
        name: 'Gekauft',
        value:
            '${wein.gekauft!.day}.${wein.gekauft!.month}.${wein.gekauft!.year}',
      ),
    if (wein.beschreibung != null) DescriptionItem(wein.beschreibung!),
  ];
}

Widget listItem(
    Wein wein, void Function(Wein, BuildContext) tapped, BuildContext context) {
  return ListTile(
    // contentPadding: EdgeInsets.symmetric(vertical: 10, ),
    title: Text(
      '${wein.sorte.name} ${wein.name}',
      maxLines: 1,
    ),
    leading: Container(
      width: 25,
      alignment: Alignment.center,
      child: Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.wein(wein.sorte.farbenName),
        ),
      ),
    ),

    subtitle: (wein.weinbauer != null)
        ? Text(
            (wein.weinbauer!.name),
            maxLines: 1,
          )
        : null,
    // tileColor: Theme.of(context).colorScheme.wein(wein.sorte.farbenName),
    trailing: (wein.jahr != null) ? Text('${wein.jahr!}') : null,

    onTap: () {
      tapped(wein, context);
    },
  );
}

final IconData icon = Icons.wine_bar;

        // Row(
        //   children: [
        //     Container(
        //       padding: EdgeInsets.symmetric(vertical: 4, horizontal: 5),
        //       decoration: BoxDecoration(
        //         color: Theme.of(context).colorScheme.wein(wein.sorte.farbenName),
        //         borderRadius: BorderRadius.circular(4),
        //       ),
        //       child: Text(
        //         '${wein.sorte.name} ${wein.name}',
        //         style: TextStyle(
        //           color:
        //               Theme.of(context).colorScheme.onWein(wein.sorte.farbenName),
        //         ),
        //       ),
        //     ),
        //     Expanded(child: SizedBox())
        //   ],
        // ),
