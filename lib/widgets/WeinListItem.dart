import 'package:flutter/material.dart';
import 'package:weindb/theme/WeinFarbenUIColor.dart';
import 'package:weindb/widgets/pages/WeinPage.dart';
// import 'package:animations/animations.dart';

import '../models/models.dart';
import 'MyListItem.dart';

class WeinListItem extends StatelessWidget {
  WeinListItem(this.weinModel, {Key? key, this.onTap})
      : super(key: key);

  /// If supplied, tapping on the ListTile will call this method. It not, tapping will open the WeinPage for the relevant wine (with an animation).
  final void Function()? onTap;

  final WeinModel weinModel;
  @override
  Widget build(BuildContext context) {
    final isEnabled = weinModel.available;

    return MyListItem(
      onTap: onTap,
      openBuilder: onTap == null ? (context, close) => Scaffold(
        body: Center(
          child: WeinPage(weinModel: weinModel),
        ),
      ) : null,
      subtitle: weinModel.weinbauer.toString(),
      title: weinModel.toString(),
      color: WeinFarbenUIColor.getColor(
        weinModel.sorte.farbe,
      ),
      enabled: isEnabled,
      chips: [
        if (weinModel.jahr != null)
          Tooltip(
            message: 'Jahrgang',
            child: Chip(
              label: Text(weinModel.jahr!.toString()),
              avatar: Icon(Icons.calendar_today),
            ),
          ),
        Tooltip(
          message: 'Anzahl',
          child: Chip(
            label: Text(
              weinModel.anzahl.toString(),
            ),
            avatar: Icon(Icons.tag),
          ),
        )
      ],
    );

    // return Padding(
    //   padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
    //   child: OpenContainer(
    //     closedShape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.all(Radius.circular(10))),
    //     closedColor: Theme.of(context).cardColor,
    //     // closedColor: Colors.transparent,
    //     openColor: Theme.of(context).scaffoldBackgroundColor,
    //     openBuilder: (context, close) => Scaffold(
    //       body: Center(
    //         child: Text('hi'),
    //       ),
    //     ),
    //     closedBuilder: (context, open) => IntrinsicHeight(
    //       child: Row(
    //         crossAxisAlignment: CrossAxisAlignment.stretch,
    //         mainAxisAlignment: MainAxisAlignment.start,
    //         mainAxisSize: MainAxisSize.min,
    //         children: [
    //           Container(
    //             width: 10,
    //             height: 0,
    //             color: WeinFarbenUIColor.getColor(weinModel.sorte.farbe),
    //           ),
    //           Expanded(
    //             child: ListTile(
    //               title: Text(weinModel.toString()),
    //               enabled: weinModel.available,
    //               onTap: () {
    //                 open();
    //               },
    //               style: ListTileStyle.list,
    //               subtitle: Text(weinModel.weinbauer.toString()),
    //               trailing: Container(
    //                 constraints: BoxConstraints(maxWidth: 200),
    //                 child: Wrap(
    //                   children: [
    //                     if (weinModel.jahr != null)
    //                       Tooltip(
    //                         message: 'Jahrgang',
    //                         child: Chip(
    //                           label: Text(weinModel.jahr!.toString()),
    //                           avatar: Icon(Icons.calendar_today),
    //                         ),
    //                       ),
    //                     Tooltip(
    //                       message: 'Anzahl',
    //                       child: Chip(
    //                         label: Text(
    //                           weinModel.anzahl.toString(),
    //                         ),
    //                         avatar: Icon(Icons.tag),
    //                       ),
    //                     )
    //                   ],
    //                   spacing: 10,
    //                 ),
    //               ),

    //               // trailing: Container(color: Colors.red),

    //               // ein älterer Kommentar:
    //               // nichtmehrTODO: hier weitermachen
    //               // Kommentar für später:
    //               // Ich hab jetzt hier begonnen, zu konzipieren, wie ein Wein aussieht
    //               // Ich wollte links diese Liste in der der Weinsorte entsprechenden Farbe machen
    //               // Damit diese dinger jetzt gleich hoch sind, muss man irgendeine weirde sache verwenden

    //               // natürlich muss ich noch die tatsächliche Farbe des Weins bekommen

    //               // rechts wollte ich jetzt mit einigen Icons, je nachdem wie viele hinpassen, noch weitere Informationen anzeigen

    //               // an zukunfts-ich: geh schlafen, wenn es schon später als 22:10 ist :)

    //               // leading: Container(color: Colors.red, height: 10, width: 10),
    //               // enabled: weinModel.,
    //               // subtitle: Text(weinModel.bewertung),
    //               // leading: Image.network(weinModel.imageUrl),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
