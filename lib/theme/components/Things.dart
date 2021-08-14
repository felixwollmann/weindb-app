import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weindb/classes/classes.dart';
import 'package:weindb/pages/edit/edit.dart';

import 'package:weindb/pages/weine.dart' as weinComponents;
import 'package:weindb/pages/weinbauern.dart' as weinbauernComponents;
import 'package:weindb/pages/sorten.dart' as sortenComponents;
import 'package:weindb/pages/regionen.dart' as regionenComponents;

import 'package:weindb/theme/components/ThingDetails.dart';

import 'package:weindb/theme/colors.dart';

class WeinePage extends StatelessWidget {
  const WeinePage({Key? key}) : super(key: key);

  static final String appBarName = weinComponents.appBarName;

  static final IconData icon = weinComponents.icon;

  static void tapped(Wein wein, BuildContext context) {
    ThemeData theme = Theme.of(context);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return ThingDetails(
            title: Provider.of<Weine>(context)[wein.id]!.name,
            delete: Provider.of<Weine>(context)[wein.id]!.delete,
            edit: () async {
              Wein? newWein = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => WeineForm(
                            startingValue:
                                Provider.of<Weine>(context)[wein.id]!,
                          )));
              if (newWein != null) newWein.save();
            },
            children: weinComponents.detailsChildren(
                Provider.of<Weine>(context)[wein.id]!, context),
            id: Provider.of<Weine>(context)[wein.id]!.id,
            color: theme.colorScheme
                .wein(Provider.of<Weine>(context)[wein.id]!.sorte.farbenName),
            onColor: theme.colorScheme
                .onWein(Provider.of<Weine>(context)[wein.id]!.sorte.farbenName),
            brightness: theme.colorScheme.onWein(
                        Provider.of<Weine>(context)[wein.id]!
                            .sorte
                            .farbenName) ==
                    Colors.white
                ? Brightness.dark
                : Brightness.light,
            customFunctions: Provider.of<Weine>(context)[wein.id]!.anzahl <= 0 ? null : {
              'Als getrunken markieren': () async {
                try {
                  await Provider.of<Weine>(context, listen: false)[wein.id]!.drink();
                } catch (err) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          'Beim als getrunken markieren des Weines ist ein Fehler aufgetreten. Bitte überprüfe deine Internetverbindung.')));
                }
              }
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Weine weine = Provider.of<Weine>(context);
    List<Wein> weinList = weine.values.toList();
    // ThemeData theme = Theme.of(context);

    Widget listView = ListView.separated(
      itemCount: weine.length,
      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (BuildContext context, int index) {
        Wein wein = weinList[index];
        return weinComponents.listItem(wein, tapped, context);
      },
    );

    return weine.showProgress
        ? Center(child: CircularProgressIndicator())
        : Container(
            child: RefreshIndicator(
                onRefresh: weine.reload,
                child: !weine.error ? listView : _LoadingError(weine.reload)),
          );
  }
}

class WeinbauernPage extends StatelessWidget {
  const WeinbauernPage({Key? key}) : super(key: key);

  static final String appBarName = weinbauernComponents.appBarName;

  static final IconData icon = weinbauernComponents.icon;

  static void tapped(Weinbauer weinbauer, BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return ThingDetails(
            title: Provider.of<Weinbauern>(context)[weinbauer.id]!.name,
            delete: weinbauer.delete,
            edit: () async {
              Weinbauer? newWeinbauer = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => WeinbauernForm(
                            startingValue:
                                Provider.of<Weinbauern>(context)[weinbauer.id]!,
                          )));
              if (newWeinbauer != null) newWeinbauer.save();
            },
            children: weinbauernComponents.detailsChildren(
                Provider.of<Weinbauern>(context)[weinbauer.id]!, context),
            id: Provider.of<Weinbauern>(context)[weinbauer.id]!.id,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Weinbauern weinbauern = Provider.of<Weinbauern>(context);
    List<Weinbauer> weinbauernList = weinbauern.values.toList();
    // ThemeData theme = Theme.of(context);

    var listView = ListView.separated(
      itemCount: weinbauern.length,
      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (BuildContext context, int index) {
        Weinbauer weinbauer = weinbauernList[index];
        return weinbauernComponents.listItem(weinbauer, tapped, context);
      },
    );
    return weinbauern.showProgress
        ? Center(child: CircularProgressIndicator())
        : Container(
            child: RefreshIndicator(
                onRefresh: weinbauern.reload,
                child: !weinbauern.error
                    ? listView
                    : _LoadingError(weinbauern.reload)),
          );
  }
}

class SortenPage extends StatelessWidget {
  const SortenPage({Key? key}) : super(key: key);

  static final String appBarName = sortenComponents.appBarName;

  static final IconData icon = sortenComponents.icon;

  static void tapped(Sorte sorte, BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return ThingDetails(
            title: Provider.of<Sorten>(context)[sorte.id]!.name,
            delete: Provider.of<Sorten>(context)[sorte.id]!.delete,
            edit: () async {
              Sorte? newSorte = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => SortenForm(
                            startingValue:
                                Provider.of<Sorten>(context)[sorte.id]!,
                          )));
              if (newSorte != null) newSorte.save();
            },
            color: Theme.of(context)
                .colorScheme
                .wein(Provider.of<Sorten>(context)[sorte.id]!.farbenName),
            onColor: Theme.of(context)
                .colorScheme
                .onWein(Provider.of<Sorten>(context)[sorte.id]!.farbenName),
            children: sortenComponents.detailsChildren(
                Provider.of<Sorten>(context)[sorte.id]!, context),
            id: Provider.of<Sorten>(context)[sorte.id]!.id,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Sorten sorten = Provider.of<Sorten>(context);
    List<Sorte> sortenList = sorten.values.toList();
    // ThemeData theme = Theme.of(context);

    var listView = ListView.separated(
      itemCount: sorten.length,
      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (BuildContext context, int index) {
        Sorte sorte = sortenList[index];
        return sortenComponents.listItem(sorte, tapped, context);
      },
    );
    return sorten.showProgress
        ? Center(child: CircularProgressIndicator())
        : Container(
            child: RefreshIndicator(
                onRefresh: sorten.reload,
                child: !sorten.error ? listView : _LoadingError(sorten.reload)),
          );
  }
}

class RegionenPage extends StatelessWidget {
  const RegionenPage({Key? key}) : super(key: key);

  static final String appBarName = regionenComponents.appBarName;

  static final IconData icon = regionenComponents.icon;

  static void tapped(Region region, BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return ThingDetails(
            title: Provider.of<Regionen>(context)[region.id]!.name,
            delete: Provider.of<Regionen>(context)[region.id]!.delete,
            edit: () async {
              Region? newSorte = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => RegionenForm(
                            startingValue:
                                Provider.of<Regionen>(context)[region.id]!,
                          )));
              if (newSorte != null) newSorte.save();
            },
            children: regionenComponents.detailsChildren(
                Provider.of<Regionen>(context)[region.id]!, context),
            id: Provider.of<Regionen>(context)[region.id]!.id,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Regionen regionen = Provider.of<Regionen>(context);
    List<Region> regionenList = regionen.values.toList();
    // ThemeData theme = Theme.of(context);

    var listView = ListView.separated(
      itemCount: regionen.length,
      separatorBuilder: (context, index) => Divider(),
      itemBuilder: (BuildContext context, int index) {
        Region region = regionenList[index];
        return regionenComponents.listItem(region, tapped, context);
      },
    );
    return regionen.showProgress
        ? Center(child: CircularProgressIndicator())
        : Container(
            child: RefreshIndicator(
                onRefresh: regionen.reload,
                child: !regionen.error
                    ? listView
                    : _LoadingError(regionen.reload)),
          );
  }
}

class _LoadingError extends StatelessWidget {
  final void Function({bool show}) onTryAgain;

  _LoadingError(this.onTryAgain, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Fehler beim Laden'),
          ElevatedButton(
              onPressed: () {
                onTryAgain(show: true);
              },
              child: Text('Nochmal versuchen'))
        ],
      ),
    );
  }
}
