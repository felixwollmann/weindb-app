import 'package:flutter/material.dart';

import '../../models/models.dart';
import '../SmallCard.dart';

class WeinPage extends StatelessWidget {
  const WeinPage({Key? key, required this.weinModel}) : super(key: key);

  final WeinModel weinModel;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var cardColor = theme.cardColor;
    var textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(weinModel.toString()),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Text(
                weinModel.toString(),
                style: Theme.of(context).textTheme.headline3,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: cardColor,
              ),
            ),
          ),
          Wrap(
            runAlignment: WrapAlignment.spaceBetween,
            alignment: WrapAlignment.start,
            children: [
              SmallCard(
                  title: weinModel.anzahl.toString(), subtitle: 'Vorhanden'),
              SmallCard(
                title: weinModel.fach.toString(),
                subtitle: 'Fach',
              ),
              // SmallCard(
              //     title: weinModel.anzahl.toString(), subtitle: 'Vorhanden'),
              SmallCard(
                title: weinModel.fach.toString(),
                subtitle: 'Fach',
              ),
              SmallCard(
                  title: weinModel.anzahl.toString(), subtitle: 'Vorhanden'),
              SmallCard(
                title: weinModel.fach.toString(),
                subtitle: 'Fach',
              ),
              SmallCard(
                  title: weinModel.anzahl.toString(), subtitle: 'Vorhanden'),
              SmallCard(
                title: weinModel.fach.toString(),
                subtitle: 'Fach',
              ),
              // Expanded(
              //   child: Container(
              //     child: Text(weinModel.anzahl.toString()),
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(8),
              //       color: cardColor,
              //     ),
              //   ),
              // ),
            ],
          )
        ],
      ),
    );
  }
}
