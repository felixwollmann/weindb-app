import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import '../theme/WeinFarbenUIColor.dart';

class MyListItem extends StatelessWidget {
  const MyListItem(
      {Key? key,
      required this.openBuilder,
      this.color,
      required this.title,
      required this.subtitle,
      this.chips = const [],
      this.enabled = true})
      : super(key: key);

  final Widget Function(BuildContext, void Function({Never? returnValue}))
      openBuilder;

  final Color? color;

  final String title;
  final String subtitle;

  final bool enabled;

  final List<Widget> chips;

  @override
  Widget build(BuildContext context) {
    final hasColor = color != null;

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: OpenContainer(
        closedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        closedColor: Theme.of(context).cardColor,
        // closedColor: Colors.transparent,
        openColor: Theme.of(context).scaffoldBackgroundColor,
        openBuilder: openBuilder,
        closedBuilder: (context, open) => hasColor
            ? IntrinsicHeight(
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
                      child: ListTile(
                        title: Text(title),
                        enabled: enabled,
                        onTap: open,
                        style: ListTileStyle.list,
                        subtitle: Text(subtitle),
                        trailing: Container(
                          constraints: BoxConstraints(maxWidth: 200),
                          child: Wrap(
                            children: chips,
                            spacing: 10,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : ListTile(
                title: Text(title),
                enabled: enabled,
                onTap: open,
                style: ListTileStyle.list,
                subtitle: Text(subtitle),
                trailing: Container(
                  constraints: BoxConstraints(maxWidth: 200),
                  child: Wrap(
                    children: chips,
                    spacing: 10,
                  ),
                ),
              ),
      ),
    );
  }
}
