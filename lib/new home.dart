import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weindb/classes/classes.dart';
import 'package:weindb/pages/search.dart';
import 'package:weindb/pages/stats.dart';
// import 'package:weindb/pages/settings.dart';
// import 'package:provider/provider.dart';
// import 'package:weindb/classes.dart';
import 'package:weindb/theme/components/Things.dart';
// import 'package:weindb/theme/theme.dart' as theme;

import 'package:weindb/pages/edit/edit.dart';
import 'package:weindb/widgets/WeinListItem.dart';

import 'models/models.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemBuilder: (context, number) => WeinListItem(
          WeinModel(
            id: 1,
            name: 'Wein',
            sorte: SorteModel(id: 1, name: 'Sorte', farbe: number % 2 == 0 ? WeinFarbe.red : WeinFarbe.white),
            anzahl: number,
            getrunken: 1,
            jahr: 2020 - number,
            weinbauer: WeinbauerModel(
                id: 1,
                name: 'Weinbauer',
                region: RegionModel(id: 1, name: 'Region', land: 'AT'),
                beschreibung: 'Beschreibung des Weinguts'),
            beschreibung: 'Beschreibung',
            inhalt: 0.75,
            fach: 10,
            gekauft: DateTime.now(),
            preis: 10.0,
          ),

        ),
        itemCount: 20,
      ),
    );
  }
}

// class Page extends StatefulWidget {
//   const Page({Key? key}) : super(key: key);

//   @override
//   State<Page> createState() => _PageState();
// }

// class _PageState extends State<Page> {
//   int _selectedIndex = 0;
//   String appBarTitle = WeinePage.appBarName;
//   static List<String> appBarTitles = [
//     WeinePage.appBarName,
//     WeinbauernPage.appBarName,
//     SortenPage.appBarName,
//     RegionenPage.appBarName,
//     StatsPage.appBarName
//   ];
//   static const List<Widget> _widgetOptions = <Widget>[
//     WeinePage(),
//     WeinbauernPage(),
//     SortenPage(),
//     RegionenPage(),
//     StatsPage(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//       appBarTitle = appBarTitles[_selectedIndex];
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     ThemeData theme = Theme.of(context);

//     return Scaffold(
//       floatingActionButton: _selectedIndex >= 4
//           ? null
//           : FloatingActionButton(
//               child: Icon(Icons.add),
//               onPressed: () async {
//                 try {
//                   if (_selectedIndex == 0) {
//                     Wein? newWein = await Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => WeineForm(),
//                         fullscreenDialog: true,
//                       ),
//                     );
//                     if (newWein != null)
//                       Provider.of<Weine>(context, listen: false).add(newWein);
//                   } else if (_selectedIndex == 1) {
//                     Weinbauer? newWeinbauer = await Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => WeinbauernForm(),
//                         fullscreenDialog: true,
//                       ),
//                     );
//                     if (newWeinbauer != null)
//                       Provider.of<Weinbauern>(context, listen: false)
//                           .add(newWeinbauer);
//                   } else if (_selectedIndex == 2) {
//                     Sorte? newSorte = await Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => SortenForm(),
//                         fullscreenDialog: true,
//                       ),
//                     );
//                     if (newSorte != null)
//                       Provider.of<Sorten>(context, listen: false).add(newSorte);
//                   } else if (_selectedIndex == 3) {
//                     Region? newRegion = await Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (context) => RegionenForm(),
//                         fullscreenDialog: true,
//                       ),
//                     );
//                     if (newRegion != null)
//                       Provider.of<Regionen>(context, listen: false)
//                           .add(newRegion);
//                   }
//                 } catch (err) {
//                   print(err);
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text(
//                         'Beim Erstellen ist ein Fehler aufgetreten, bitte überprüfe deine Internetverbindung',
//                       ),
//                     ),
//                   );
//                 }
//               },
//             ),
//       appBar: AppBar(
//         title: Text(
//           appBarTitle,
//           style: theme.textTheme.headline6!
//               .copyWith(color: theme.colorScheme.onPrimary),
//         ),
//         leading: IconButton(
//           onPressed: () {
//             var delegate = MySearchDelegate();
//             showSearch(context: context, delegate: delegate);
//           },
//           icon: Icon(
//             Icons.search,
//           ),
//         ),
//         actions: [
//           IconButton(
//               onPressed: () => Navigator.of(context).pushNamed('settings'),
//               icon: Icon(Icons.settings))
//         ],
//         // actions: [
//         //   IconButton(
//         //       onPressed: () {
//         //         Navigator.of(context).push(MaterialPageRoute(
//         //             builder: (BuildContext context) => SettingsPage()));
//         //       },
//         //       icon: Icon(Icons.settings))
//         // ],
//       ),
//       body: Center(
//         child: _widgetOptions.elementAt(_selectedIndex),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(WeinePage.icon),
//             label: WeinePage.appBarName,
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(WeinbauernPage.icon),
//             label: WeinbauernPage.appBarName,
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(SortenPage.icon),
//             label: SortenPage.appBarName,
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(RegionenPage.icon),
//             label: RegionenPage.appBarName,
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(StatsPage.icon),
//             label: StatsPage.appBarName,
//           )
//         ],
//         currentIndex: _selectedIndex,
//         // selectedItemColor: Colors.amber[800],
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }
