import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:weindb/theme/constants.dart';

import '../../theme/WeinFarbenUIColor.dart';

/// List tile for displaying [Wein], [Sorte], [Weinbauer] and [Region]
/// 
/// You can either supply [openBuilder]  OR [onTap].
/// If you supply [openBuilder], a container-transform-animation (the listTile gets bigger and gets morphed into [openBuilder]).
/// If you supply [onTap], that function will be called and can do whatever it wants, e.g. select the current item in a search.
class MyListItem extends StatelessWidget {
  MyListItem(
      {Key? key,
      this.openBuilder,
      this.color,
      required this.title,
      required this.subtitle,
      this.chips = const [],
      this.enabled = true,
      void Function()? onTap})
      : assert(openBuilder != null || onTap != null,
            'Need to supply at least onTap or openBuilder'),
        assert(openBuilder == null || onTap == null,
            'Only supply onTap OR openBuilder - not both'),
        onTap = onTap ?? (openBuilder != null ? null : () {}),
        // this.openBuilder = (onTap != null) openBuilder
        super(key: key);

  final Widget Function(BuildContext, void Function({Never? returnValue}))?
      openBuilder;

  final Color? color;

  final String title;
  final String subtitle;

  final bool enabled;

  // what happens if
  final void Function()? onTap;

  final List<Widget> chips;

  @override
  Widget build(BuildContext context) {
    final hasColor = color != null;

    final hasOnTap = onTap != null;

    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: 0, horizontal: kDefaultPadding),
      child: hasOnTap
          ? _wrapInCard(
              hasColor ? _listTileWithColor(onTap!) : _listTile(onTap!))
          : OpenContainer(
              closedElevation: 0,
              closedShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kBorderRadius),
              ),
              closedColor: Theme.of(context).cardColor,
              // closedColor: Colors.transparent,
              openColor: Theme.of(context).scaffoldBackgroundColor,
              openBuilder: openBuilder!,
              closedBuilder: (context, open) =>
                  hasColor ? _listTileWithColor(open) : _listTile(open)),
    );
  }

  Widget _wrapInCard(Widget child) {
    return Card(child: child);
  }

  Widget _listTileWithColor(void Function() open) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 10,
            height: 0,
            color: color,
          ),
          Expanded(
            child: _listTile(open),
          ),
        ],
      ),
    );
  }

  ListTile _listTile(VoidCallback open) {
    return ListTile(
      title: Text(title),
      enabled: enabled,
      onTap: open,
      style: ListTileStyle.list,
      subtitle: Text(subtitle),
      trailing: Container(
        constraints: const BoxConstraints(maxWidth: 200),
        child: Wrap(
          children: chips,
          spacing: kDefaultPadding,
        ),
      ),
    );
  }
}
