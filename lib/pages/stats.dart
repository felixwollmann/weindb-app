import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';
import 'package:weindb/classes/classes.dart';




class StatsPage extends StatelessWidget {
  static const String appBarName = 'Statistik'; 
  static const IconData icon = Icons.stacked_line_chart_rounded;
  const StatsPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var weine = Provider.of<Weine>(context);
    var sorten = Provider.of<Sorten>(context);
    String data = '''
**Eingetragene Weine**: `${weine.length}`

**Flaschen**: `${weine.values.map((wein) => wein.anzahl).reduce((anzahl1, anzahl2) => anzahl1 + anzahl2)}`

**Sorten**: `${sorten.length}`
    ''';
    return Markdown(data: data);
  }
}