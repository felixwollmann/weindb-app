import 'package:flutter/material.dart';

import '../models/models.dart';

class WeinListItem extends StatelessWidget {
  const WeinListItem(this.weinModel, {Key? key}) : super(key: key);

  final WeinModel weinModel;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 10,
            height: 0,
            color: Color.fromRGBO(212, 18, 125, 1), // TODO: hier die richtige Farbe bekommen
          ),
          Expanded(
            child: ListTile(
              title: Text(weinModel.toString()),
              enabled: weinModel.available,
              onTap: () {
                // Navigator.pushNamed(context, '/wein', arguments: weinModel);
              },
              style: ListTileStyle.list,
              subtitle: Text(weinModel.weinbauer.toString()),
              trailing: Wrap(
                children: [
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
                spacing: 10,
              ),
              // trailing: Container(color: Colors.red),


              // ein älterer Kommentar:
              // nichtmehrTODO: hier weitermachen
              // Kommentar für später:
              // Ich hab jetzt hier begonnen, zu konzipieren, wie ein Wein aussieht
              // Ich wollte links diese Liste in der der Weinsorte entsprechenden Farbe machen
              // Damit diese dinger jetzt gleich hoch sind, muss man irgendeine weirde sache verwenden

              // natürlich muss ich noch die tatsächliche Farbe des Weins bekommen

              // rechts wollte ich jetzt mit einigen Icons, je nachdem wie viele hinpassen, noch weitere Informationen anzeigen

              // an zukunfts-ich: geh schlafen, wenn es schon später als 22:10 ist :)

              // leading: Container(color: Colors.red, height: 10, width: 10),
              // enabled: weinModel.,
              // subtitle: Text(weinModel.bewertung),
              // leading: Image.network(weinModel.imageUrl),
            ),
          ),
        ],
      ),
    );
  }
}
