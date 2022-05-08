import 'package:flutter/material.dart';
import 'package:weindb/theme/constants.dart';
import 'package:weindb/widgets/components/expandable_base.dart';

import '../../models/models.dart';
import '../components/colored_button.dart';

class ExpandableSorte extends StatelessWidget {
  final SorteModel sorte;
  const ExpandableSorte({Key? key, required this.sorte}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandableBase(
      title: '$sorte',
      subtitle: 'Sorte',
      icon: kiSorte,
      children: [
        Text(
          'Farbe',
          style: Theme.of(context).textTheme.subtitle2,
        ),
        Text(WeinFarbenHelper.getName(sorte.farbe)),
        const SizedBox(height: kDefaultPadding * 2),
        ColoredButton(
          icon: const Icon(Icons.open_in_new_rounded),
          title: const Text('Öfffnen'),
          onTap: () {
            // TODO: add action right here
          },
        ),
        const SizedBox(height: kDefaultPadding),
        // Card(
        //   margin: const EdgeInsets.all(0),
        //   elevation: 0,
        //   color: Theme.of(context).colorScheme.surfaceVariant,
        //   child: ListTile(
        //     leading: const Icon(kiRegion),
        //     title: Text('${weinbauer.region}'),
        //     trailing: IconButton(
        //       onPressed: () {
        //         // TODO: Add according onPressed here
        //       },
        //       icon: const Icon(Icons.open_in_new_rounded),
        //     ),
        //   ),
        // ),
        // const SizedBox(height: kDefaultPadding),
      ],
    );
  }
}
