import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weindb/settings_generation/settings_generation.dart';
// import 'package:weindb/classes/classes.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';
// import 'package:weindb/classes.dart';
// import 'package:weindb/pages/edit/weine.dart';
// import 'package:settings_ui/settings_ui.dart';
// import 'package:flutter_settings_screens/flutter_settings_screens.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppSettings prefs = Provider.of<AppSettings>(context);
    final TextEditingController tempController = TextEditingController()
    ..text = prefs.getString('api-host');
    // ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Einstellungen'),
      ),
      body: ListView(
        children: [
          // ListTile(
          //   leading: Icon(Icons.memory_outlined),
          //   title: Text('Datenbank-Server', maxLines: 1),
          //   subtitle: Text(prefs.getString('api-host')),
          //   onTap: () async {
          //     showDialog(
          //       context: context,
          //       builder: (_) => AlertDialog(
          //         title: Text('Datenbank-Server'),
          //         content: TextField(
          //           controller: tempController,
          //         ),
          //         actions: [
          //           TextButton(
          //               onPressed: () => Navigator.of(context).pop(),
          //               child: Text('ABBRECHEN')),
          //           TextButton(
          //               onPressed: () {
          //                 prefs.setString('api-host', tempController.text);

          //                 Navigator.of(context).pop();
          //               },
          //               child: Text('SPEICHERN'))
          //         ],
          //       ),
          //     );
          //   },
          // ),
          ...prefs.generate(context)
        ],
      ),
    );
  }
}
