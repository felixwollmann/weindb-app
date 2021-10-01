import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// import 'package:weindb/theme/colors.dart';
// ignore: must_be_immutable
class ThingDetails extends StatelessWidget {
  /// Funktion, die das [Thing] löscht
  final Future<void> Function() delete;
  final List<Widget> children;

  /// Funktion, die das [Thing] neu lädt
  final Future<void> Function()? refresh;

  final Future<void> Function()? edit;

  /// Titel, der in der Appbar angezeigt wird
  final String title;
  Color? color;
  Color? onColor;

  final Brightness brightness;

  final Map<String, Future<void> Function()>? customFunctions;

  // ID des [Thing]s
  final int id;

  ThingDetails({
    required this.title,
    required this.delete,
    this.refresh,
    required this.children,
    required this.id,
    this.brightness = Brightness.light,
    this.customFunctions,
    this.color,
    this.onColor,
    this.edit,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    color ??= theme.colorScheme.primary;
    onColor ??= theme.colorScheme.onPrimary;

    // ColorScheme newColorScheme = Theme.of(context).colorScheme.copyWith(
    //       // primary: farbe,
    //       // onPrimary: onFarbe,
    //     );
    return /*RefreshIndicator(
        onRefresh: refresh,
        child: */
        Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: theme.textTheme.headline6!.copyWith(color: onColor),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        // brightness: brightness,
        backgroundColor: color,
        iconTheme: IconThemeData(color: onColor),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (String value) {
              handleClick(value, context, customFunctions);
            },
            itemBuilder: (BuildContext context) {
              return {
                'Bearbeiten',
                'Löschen',
                if (customFunctions != null) ...customFunctions!.keys,
                'ID anzeigen',
              }.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface)),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: ListView(children: [SizedBox(height: 10), ...children]),
      ),
    ) /*)*/;
  }

  void handleClick(String value, BuildContext context,
      Map<String, Function>? customFunctions) async {
    var theme = Theme.of(context);
    if (value == 'Löschen') {
      AlertDialog dialog = AlertDialog(
        title: Text('$title löschen',
            style: TextStyle(color: theme.colorScheme.onSurface)),
        content: Text(
            'Willst du $title wirklich löschen? Diese Aktion kann nicht rückgängig gemacht werden.',
            style: TextStyle(color: theme.colorScheme.onSurface)),
        actions: [
          TextButton(
              onPressed: () async {
                try {
                  await delete();
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('$title erfolgreich gelöscht')));
                } catch (exeption) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          'Beim Löschen von $title ist ein Fehler aufgetreten. Das könnte daran liegen, dass deine Internetverbindung nicht funktioniert oder, dass noch Daten mit dem Element, welches du löschen wolltest, verknüpft waren.')));
                } finally {
                  Navigator.of(context)..pop()..pop();
                }
              },
              child: Text('Löschen')),
          ElevatedButton(
              onPressed: Navigator.of(context).pop, child: Text('Abbrechen'))
        ],
      );
      showDialog(context: context, builder: (_) => dialog);
    } else if (value == 'Bearbeiten') {
      if (edit != null)
        try {
          await edit!();
        } catch (err) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'Beim Bearbeiten ist ein Fehler aufgetreten. Bitte überprüfe deine Internetverbindung.'),
            ),
          );
        }
      else
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Noch nicht eingebaut'),
          ),
        );
    } else if (value == 'ID anzeigen') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'ID: $id',
          ),
        ),
      );
    } else if (customFunctions != null &&
        customFunctions.keys.toList().contains(value)) {
      customFunctions[value]!();
    }
  }
}
