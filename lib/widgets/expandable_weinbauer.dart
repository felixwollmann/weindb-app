import 'package:flutter/material.dart';
import 'package:weindb/theme/constants.dart';
import 'package:weindb/widgets/colored_button.dart';
import 'package:weindb/widgets/expandable_base.dart';
import 'package:weindb/widgets/pages/weinbauer_page.dart';

import '../models/models.dart';

class ExpandableWeinbauer extends StatelessWidget {
  final WeinbauerModel weinbauer;
  const ExpandableWeinbauer({Key? key, required this.weinbauer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandableBase(
      title: '$weinbauer',
      subtitle: 'Weingut',
      icon: kiWeinbauer,
      children: [
        if (weinbauer.beschreibung != null) ...[
          Text(
            'Beschreibung',
            style: Theme.of(context).textTheme.subtitle2,
          ),
          Text(weinbauer.beschreibung!),
        ],
        const SizedBox(height: kDefaultPadding),
        if (weinbauer.region != null) Card(
          margin: const EdgeInsets.all(0),
          elevation: 0,
          color: Theme.of(context).colorScheme.surfaceVariant,
          child: ListTile(
            leading: const Icon(kiRegion),
            title: Text('${weinbauer.region}'),
            trailing: IconButton(
              onPressed: () {
                // TODO: Add according onPressed here
              },
              icon: const Icon(Icons.open_in_new_rounded),
            ),
          ),
        ),
        const SizedBox(height: kDefaultPadding * 2),
        ColoredButton(
          icon: const Icon(Icons.open_in_new_rounded),
          title: const Text('Öfffnen'),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => WeinbauernPage(weinbauer),
            ),
          ),
        ),
        const SizedBox(height: kDefaultPadding),
      ],
    );
  }
}