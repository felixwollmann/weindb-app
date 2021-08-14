import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weindb/classes/classes.dart';
// import 'package:flutter/services.dart';
// import 'package:provider/provider.dart';
// import 'package:weindb/classes.dart';
import 'package:weindb/pages/edit/weine.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ThemeData theme = Theme.of(context);
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Einstellungen'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Wein? wein = await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => WeineForm(),
              ),
            );
            if (wein != null) Provider.of<Weine>(context, listen: false).add(wein);
          },
        ),
        body: WeineForm(/*startingValue: Provider.of<Weine>(context)[2],*/),
      ),
    );
  }
}
