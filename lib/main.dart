import 'package:flutter/material.dart';
import 'package:weindb/pages/settings.dart';
import 'package:weindb/settings_generation/settings_generation.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:weindb/theme/theme.dart' as theme;
import 'package:weindb/home.dart' as home;
import 'package:provider/provider.dart';
import 'package:weindb/classes/classes.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(App(
    settings: AppSettings(sharedPreferences: prefs, settingsEntries: [
      AppSettingsEntry('api-host',
          defaultValue: 'http://192.168.100.10/',
          title: 'Datenbank-Server',
          type: AppSettingsEntryType.String,
          icon: Icon(Icons.memory_outlined),
          description:
              'Der Server, auf dem die API läuft. Wirkt erst nach Neustart der App. Wenn du nicht weißt, was diese Einstellung bewirkt, lasse sie auf dem Standard, da sonst die App nicht mehr funktioniert.')
    ]),
  ));
}

class App extends StatelessWidget {
  // This widget is the root of your application.

  final AppSettings settings;

  App({required this.settings});

  @override
  Widget build(BuildContext context) {
    // Using MultiProvider is convenient when providing multiple objects.
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Sorten>(
          create: (context) => Sorten.get(),
        ),
        ChangeNotifierProvider<Regionen>(
          create: (context) => Regionen.get(),
        ),
        ChangeNotifierProxyProvider<Regionen, Weinbauern>(
            create: (context) => Weinbauern.get(),
            update: (context, regionen, weinbauern) {
              weinbauern?.regionen = regionen;
              return weinbauern!;
            }),
        ChangeNotifierProvider<AppSettings>.value(value: settings),
        ChangeNotifierProxyProvider2<Sorten, Weinbauern, Weine>(
          create: (context) => Weine.get(),
          update: (context, sorten, weinbauern, weine) {
            weine?.sorten = sorten;
            weine?.weinbauern = weinbauern;
            return weine!;
          },
        ),
        // In this sample app, CatalogModel never changes, so a simple Provider
        // is sufficient.
        // Provider(create: (context) => CatalogModel()),
        // CartModel is implemented as a ChangeNotifier, which calls for the use
        // of ChangeNotifierProvider. Moreover, CartModel depends
        // on CatalogModel, so a ProxyProvider is needed.
        // ChangeNotifierProxyProvider<CatalogModel, CartModel>(
        // create: (context) => CartModel(),
        // update: (context, catalog, cart) {
        // if (cart == null) throw ArgumentError.notNull('cart');
        // cart.catalog = catalog;
        // return cart;
        // },
        // ),
      ],
      child: MaterialApp(
        theme: theme.themeDataLight,
        darkTheme: theme.themeDataDark,
        themeMode: ThemeMode.system,
        title: 'Wein-Datenbank',
        home: home.Page(),
        routes: {'settings': (BuildContext context) => SettingsPage()},
        // bottomNavigationBar:
      ),
    );
  }
}



/*
int _selectedIndex = 0;
static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
static const List<Widget> _widgetOptions = <Widget>[
  Text(
    'Index 0: Home',
    style: optionStyle,
  ),
  Text(
    'Index 1: Business',
    style: optionStyle,
  ),
  Text(
    'Index 2: School',
    style: optionStyle,
  ),
  Text(
    'Index 3: Settings',
    style: optionStyle,
  ),
];

void _onItemTapped(int index) {
  setState(() {
    _selectedIndex = index;
  });
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('BottomNavigationBar Sample'),
    ),
    body: Center(
      child: _widgetOptions.elementAt(_selectedIndex),
    ),
    bottomNavigationBar: BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
          backgroundColor: Colors.red,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          label: 'Business',
          backgroundColor: Colors.green,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          label: 'School',
          backgroundColor: Colors.purple,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
          backgroundColor: Colors.pink,
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
    ),
  );
}
*/

/* /// Ab hier die Sachen, die beim Erstellen der App schon da waren
class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
*/
