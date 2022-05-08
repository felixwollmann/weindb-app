import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weindb/theme/WeinFarbenUIColor.dart';
import 'package:weindb/theme/constants.dart';
import 'package:weindb/widgets/expandable_sorte.dart';
import 'package:weindb/widgets/expandable_weinbauer.dart';
import 'package:weindb/widgets/wein_availibility_display.dart';

import '../../models/models.dart';
import '../SmallCard.dart';
import '../action_button.dart';

class WeinPage extends StatefulWidget {
  const WeinPage({Key? key, required this.weinModel}) : super(key: key);

  final WeinModel weinModel;

  @override
  State<WeinPage> createState() => _WeinPageState();
}

class _WeinPageState extends State<WeinPage> {
  ActionButtonState drinkingState = ActionButtonState.standard;

  void drink() async {
    // TODO: replace me with the actual logic
    // this is just a mock

    setState(() {
      drinkingState = ActionButtonState.loading;
    });
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      drinkingState = Random().nextBool()
          ? ActionButtonState.completed
          : ActionButtonState.error;
    });

    // todo for the actual implementation:
    // right now, this right here overrides the value, even if the button was pressed again
    // which is not good

    // also: this calls setState even if the widget was already removed from the widget tree
    await Future.delayed(const Duration(seconds: 10));
    setState(() {
      drinkingState = ActionButtonState.standard;
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text('${widget.weinModel}'),
            floating: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: Text(
                    '${widget.weinModel}',
                    style: textTheme.headline3!.copyWith(
                        decoration: TextDecoration.underline,
                        decorationColor: WeinFarbenUIColor.getColor(
                            widget.weinModel.sorte.farbe),
                        decorationThickness: 2),
                  ),
                ),
                Wrap(
                  runAlignment: WrapAlignment.spaceBetween,
                  alignment: WrapAlignment.start,
                  children: [
                    if (widget.weinModel.preis != null)
                      SmallCard(
                          title: '${widget.weinModel.preis!}€',
                          subtitle: 'Preis'),
                    if (widget.weinModel.jahr != null)
                      SmallCard(
                        title: '${widget.weinModel.jahr!}',
                        subtitle: 'Jahrgang',
                      ),
                    if (widget.weinModel.fach != null)
                      SmallCard(
                          title: '${widget.weinModel.fach!}', subtitle: 'Fach'),
                    if (widget.weinModel.gekauft != null)
                      SmallCard(
                        // this is not really nice, but I don't want to set up actual i18n for just this one date format
                        title: DateFormat("d.M.y").format(widget.weinModel.gekauft!),
                        subtitle: 'Gekauft',
                      ),
                  ],
                ),
                WeinAvailabilityDisplay(
                  drunken: widget.weinModel.getrunken,
                  available: widget.weinModel.anzahl,
                ),
                const SizedBox(height: kDefaultPadding),
                if (widget.weinModel.weinbauer != null)
                  ExpandableWeinbauer(weinbauer: widget.weinModel.weinbauer!),
                const SizedBox(height: kDefaultPadding),
                ExpandableSorte(sorte: widget.weinModel.sorte),
                const SizedBox(height: kDefaultPadding),
                Container(
                  padding: const EdgeInsets.only(
                      left: kDefaultPadding, right: kDefaultPadding),
                  alignment: Alignment.center,
                  child: Text(
                    'ID: ${widget.weinModel.id}',
                    style: textTheme.caption,
                  ),
                ),
                const SizedBox(height: kDefaultPadding),
                const Divider(),
                const SizedBox(height: kDefaultPadding),
                ActionButton(
                  icon: kiWein,
                  label: 'Trinken',
                  onTap: drink,
                  state: drinkingState,
                  isFilled: true,
                ),
                const SizedBox(height: kDefaultPadding),
                ActionButton(
                  label: 'Bearbeiten',
                  isFilled: true,
                  icon: Icons.edit_rounded,
                  onTap: () {
                    // TODO: add the right Route here
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Scaffold(
                          appBar: AppBar(),
                          body: const Center(
                            child: Text('TODO\nHere should be a page to edit this wine.'),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
