import 'package:flutter/material.dart';
import 'package:weindb/theme/constants.dart';
import 'package:weindb/widgets/InformationDisplay.dart';
import 'package:weindb/widgets/expandable_sorte.dart';
import 'package:weindb/widgets/expandable_weinbauer.dart';
import 'package:weindb/widgets/wein_availibility_display.dart';

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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(weinModel.toString()),
            floating: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${weinModel} 🍷',
                    style: textTheme.headline3,
                  ),
                ),
                Wrap(
                  runAlignment: WrapAlignment.spaceBetween,
                  alignment: WrapAlignment.start,
                  children: [
                    SmallCard(
                        title: weinModel.anzahl.toString(),
                        subtitle: 'Vorhanden'),
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
                        title: weinModel.anzahl.toString(),
                        subtitle: 'Vorhanden'),
                    SmallCard(
                      title: weinModel.fach.toString(),
                      subtitle: 'Fach',
                    ),
                    SmallCard(
                        title: weinModel.anzahl.toString(),
                        subtitle: 'Vorhanden'),
                    SmallCard(
                      title: weinModel.fach.toString(),
                      subtitle: 'Fach',
                    ),
                  ],
                ),
                WeinAvailabilityDisplay(
                    drunken: weinModel.getrunken, available: weinModel.anzahl),
                const SizedBox(height: kDefaultPadding),
                if (weinModel.weinbauer != null)
                  ExpandableWeinbauer(weinbauer: weinModel.weinbauer!),
                const SizedBox(height: kDefaultPadding),
                ExpandableSorte(sorte: weinModel.sorte),
                const SizedBox(height: kDefaultPadding),
                // const SizedBox(height: 100,),
                InformationDisplay(),
                Placeholder(
                  fallbackHeight: 1000,
                )
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
            ),
          ),
        ],
      ),
    );
  }
}
