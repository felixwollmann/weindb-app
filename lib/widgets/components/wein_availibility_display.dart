import 'package:flutter/material.dart';
import 'package:weindb/theme/constants.dart';

class WeinAvailabilityDisplay extends StatelessWidget {
  const WeinAvailabilityDisplay(
      {required this.drunken, required this.available, Key? key})
      : super(key: key);

  final int available;
  final int drunken;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Column(
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            // constraints: BoxConstraints(minHeight: 50),
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(kBorderRadius),
              color: theme.cardColor,
            ),
            // padding: EdgeInsets.all(8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                text(context, '$available', available > 0),
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        flex: available,
                        child: Container(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      Expanded(
                        flex: drunken,
                        child: Container(),
                      )
                    ],
                  ),
                ),
                text(context, '$drunken', drunken == 0),
              ],
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Verfügbar',
                    style: theme.textTheme.subtitle2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Getrunken',
                    style: theme.textTheme.subtitle2,
                    overflow: TextOverflow.ellipsis,

                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget text(BuildContext context, String string, bool isOn) {
    var theme = Theme.of(context);
    return Container(
      child: Text(
        string,
        style: theme.textTheme.displaySmall!.copyWith(
          color:
              isOn ? theme.colorScheme.onPrimary : theme.colorScheme.onSurface,
          fontSize: 25,
        ),
      ),
      alignment: Alignment.center,
      width: 50,
      color: isOn ? theme.colorScheme.primary : Colors.transparent,
    );
  }
}
