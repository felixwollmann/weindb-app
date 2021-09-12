import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class AppSettings extends ChangeNotifier {
  final SharedPreferences sharedPreferences;
  List<AppSettingsEntry> settingsEntries;
  AppSettings(
      {required this.sharedPreferences, required this.settingsEntries}) {
    prefs = sharedPreferences;
    entries = settingsEntries;
  }

  String getString(String key) {
    assert(settingsEntries.any((element) => element.key == key));
    String? fromPrefs = sharedPreferences.getString(key);
    return fromPrefs ??
        settingsEntries
            .where((element) => element.key == key)
            .first
            .defaultValue as String;
  }

  void setString(String key, String value) {
    assert(settingsEntries.any((element) => element.key == key));
    sharedPreferences.setString(key, value);
    notifyListeners();
  }

  List<Widget> generate(BuildContext context) {
    List<Widget> widgets = [];
    for (int i = 0; i < settingsEntries.length; i++) {
      AppSettingsEntry currentEntry = settingsEntries[i];
      final TextEditingController controller = TextEditingController()
        ..text = currentEntry.defaultValue as String;

      AppSettings appSettings = Provider.of<AppSettings>(context);

      Widget widget = ListTile(
        leading: currentEntry.icon,
        title: Text(currentEntry.title, maxLines: 1),
        subtitle: Text(appSettings.getString(currentEntry.key)),
        onTap: () async {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text(currentEntry.title),
              content: TextField(
                controller: controller,
              ),
              actions: [
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('ABBRECHEN')),
                TextButton(
                    onPressed: () {
                      appSettings.setString(currentEntry.key, controller.text);

                      Navigator.of(context).pop();
                    },
                    child: Text('SPEICHERN'))
              ],
            ),
          );
        },
        trailing: currentEntry.description == null ? null : IconButton(icon: Icon(Icons.info_outline_rounded), onPressed: () => showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text(currentEntry.title),
              content: Text(currentEntry.description!),
              actions: [
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    
                    child: Text('OK'))
              ],
            ),
          ),),
      );

      widgets.add(widget);
    }
    return widgets;
  }
}

SharedPreferences? prefs;
List<AppSettingsEntry>? entries;

abstract class AppSettingsNoContext {
  static String getString(String key) {
    assert(prefs != null && entries != null,
        "[AppSettings] wasn't instansiated yet, make sure it");
    assert(entries!.any((element) => element.key == key));
    String? fromPrefs = prefs!.getString(key);
    return fromPrefs ??
        entries!.where((element) => element.key == key).first.defaultValue
            as String;
  }
}

class AppSettingsEntry {
  final AppSettingsEntryType type;
  final Widget? icon;
  final String key;
  final String title;
  final Object defaultValue;
  final String? description;
  AppSettingsEntry(
    this.key, {
    required this.defaultValue,
    required this.title,
    required this.type,
    this.icon,
    this.description,
  });
}

enum AppSettingsEntryType { String }
