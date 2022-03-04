import 'package:flutter/material.dart';
import 'package:weindb/theme/constants.dart';
import 'package:weindb/widgets/colored_button.dart';
import 'package:weindb/widgets/expandable_base.dart';

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
      // trailing: IconButton(
      //   icon: const Icon(Icons.open_in_new_rounded),
      //   onPressed: () {
      //     // TODO: add the action here
      //   },
      // ),
      children: [
        if (weinbauer.beschreibung != null) ...[
          Text(
            'Beschreibung',
            style: Theme.of(context).textTheme.subtitle2,
          ),
          Text(weinbauer.beschreibung!),
        ],
        const SizedBox(height: kDefaultPadding),
        Card(
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
          onTap: () {
            // TODO: add action right here
          },
        ),
        const SizedBox(height: kDefaultPadding),
      ],
    );
  }
}

// class ExpandableWeinbauer extends StatefulWidget {
//   final WeinbauerModel weinbauer;

//   const ExpandableWeinbauer({Key? key, required this.weinbauer})
//       : super(key: key);

//   @override
//   State<ExpandableWeinbauer> createState() => _ExpandableWeinbauerState();
// }

// class _ExpandableWeinbauerState extends State<ExpandableWeinbauer> {
//   bool isExpanded = false;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding:
//           const EdgeInsets.only(right: kDefaultPadding, left: kDefaultPadding),
//       child: Theme(
//         data: Theme.of(context).copyWith(
//             dividerColor: Theme.of(context).cardColor,
//             dividerTheme: Theme.of(context)
//                 .dividerTheme
//                 .copyWith(thickness: 0, color: Colors.transparent)),
//         child: Card(
//           margin: EdgeInsets.zero,
//           clipBehavior: Clip.antiAlias,
//           child: ExpansionTile(
//             title: Text('${widget.weinbauer}'),
//             subtitle: const Text('Weinbgut'),
//             leading: const Icon(kiWeinbauer),
//             expandedCrossAxisAlignment: CrossAxisAlignment.start,
//             expandedAlignment: Alignment.topLeft,
//             children: [
//               Container(
//                 padding: const EdgeInsets.only(
//                     left: kDefaultPadding, right: kDefaultPadding),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     if (widget.weinbauer.beschreibung != null) ...[
//                       Text(
//                         'Beschreibung',
//                         style: Theme.of(context).textTheme.subtitle2,
//                       ),
//                       Text(widget.weinbauer.beschreibung!),
//                     ],
//                     const SizedBox(height: kDefaultPadding),
//                     Card(
//                       margin: const EdgeInsets.all(0),
//                       elevation: 0,
//                       color: Theme.of(context).colorScheme.surfaceVariant,
//                       child: ListTile(
//                         leading: const Icon(kiRegion),
//                         title: Text('${widget.weinbauer.region}'),
//                         trailing: IconButton(
//                           onPressed: () {
//                             // TODO: Add according onPressed here
//                           },
//                           icon: const Icon(Icons.open_in_new_rounded),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: kDefaultPadding),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
