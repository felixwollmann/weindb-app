import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weindb/classes/classes.dart';
import 'package:weindb/pages/search.dart';
// import 'package:weindb/pages/settings.dart';
// import 'package:provider/provider.dart';
// import 'package:weindb/classes.dart';
import 'package:weindb/theme/components/Things.dart';
// import 'package:weindb/theme/theme.dart' as theme;

import 'package:weindb/pages/edit/edit.dart';

class Page extends StatefulWidget {
  const Page({Key? key}) : super(key: key);

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> {
  int _selectedIndex = 0;
  String appBarTitle = WeinePage.appBarName;
  static List<String> appBarTitles = [
    WeinePage.appBarName,
    WeinbauernPage.appBarName,
    SortenPage.appBarName,
    RegionenPage.appBarName
  ];
  static const List<Widget> _widgetOptions = <Widget>[
    WeinePage(),
    WeinbauernPage(),
    SortenPage(),
    RegionenPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      appBarTitle = appBarTitles[_selectedIndex];
    });
  }

  @override
  Widget build(BuildContext context) {

    ThemeData theme = Theme.of(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          try {
            if (_selectedIndex == 0) {
              Wein? newWein = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => WeineForm(),
                ),
              );
              if (newWein != null)
                Provider.of<Weine>(context, listen: false).add(newWein);
            } else if (_selectedIndex == 1) {
              Weinbauer? newWeinbauer = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => WeinbauernForm(),
                ),
              );
              if (newWeinbauer != null)
                Provider.of<Weinbauern>(context, listen: false)
                    .add(newWeinbauer);
            } else if (_selectedIndex == 2) {
              Sorte? newSorte = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SortenForm(),
                ),
              );
              if (newSorte != null)
                Provider.of<Sorten>(context, listen: false)
                    .add(newSorte);
            } else if (_selectedIndex == 3) {
              Region? newRegion = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => RegionenForm(),
                ),
              );
              if (newRegion != null)
                Provider.of<Regionen>(context, listen: false).add(newRegion);
            }
          } catch (err) {
            print(err);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Beim Erstellen ist ein Fehler aufgetreten, bitte überprüfe deine Internetverbindung',
                ),
              ),
            );
          }
        },
      ),
      appBar: AppBar(
        title: Text(
          appBarTitle,
          style: theme.textTheme.headline6!
              .copyWith(color: theme.colorScheme.onPrimary),
        ),
        leading: IconButton(
          onPressed: () {
            var delegate = MySearchDelegate();
            showSearch(context: context, delegate: delegate);
          },
          icon: Icon(
            Icons.search,
          ),
        ),
        actions: [
          IconButton(onPressed: () => Navigator.of(context).pushNamed('settings'), icon: Icon(Icons.settings))
        ],
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         Navigator.of(context).push(MaterialPageRoute(
        //             builder: (BuildContext context) => SettingsPage()));
        //       },
        //       icon: Icon(Icons.settings))
        // ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(WeinePage.icon),
            label: WeinePage.appBarName,
          ),
          BottomNavigationBarItem(
            icon: Icon(WeinbauernPage.icon),
            label: WeinbauernPage.appBarName,
          ),
          BottomNavigationBarItem(
            icon: Icon(SortenPage.icon),
            label: SortenPage.appBarName,
          ),
          BottomNavigationBarItem(
            icon: Icon(RegionenPage.icon),
            label: RegionenPage.appBarName,
          ),
        ],
        currentIndex: _selectedIndex,
        // selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
