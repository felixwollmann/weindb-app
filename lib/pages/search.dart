// import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:weindb/classes/classes.dart';

import 'package:weindb/pages/weine.dart' as weineComponents;
import 'package:weindb/pages/weinbauern.dart' as weinbauernComponents;
import 'package:weindb/pages/sorten.dart' as sortenComponents;
import 'package:weindb/pages/regionen.dart' as regionenComponents;
import 'package:weindb/theme/components/AllComponents.dart';

// class SearchPage extends StatefulWidget {
//   const SearchPage({ Key? key }) : super(key: key);

//   @override
//   _SearchPageState createState() => _SearchPageState();
// }

// class _SearchPageState extends State<SearchPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Sea
//   }
// }

class MySearchDelegate extends SearchDelegate<String> {
   MySearchDelegate() : super(
     searchFieldLabel: 'Suche',
     keyboardType: TextInputType.text,
     textInputAction: TextInputAction.search,
   );

  Widget searchResults = ListView(
    children: [
      Container(
        height: 10,
        color: Colors.blue,
      )
    ],
  );

  // @override
  // ThemeData appBarTheme(BuildContext context) {
  //   var superTheme = super.appBarTheme(context);
  //   var theme = Theme.of(context);
  //   ColorScheme colorScheme = theme.colorScheme;
  //   return superTheme.copyWith(
  //     appBarTheme: superTheme.appBarTheme.copyWith(
  //       color: theme.colorScheme.primary,
  //     ),
  //     inputDecorationTheme: superTheme.inputDecorationTheme.copyWith(
  //       // hintStyle: TextStyle()
        
  //     )
  //   );
  // }

  @override
  Widget buildLeading(BuildContext context) => IconButton(
      onPressed: () => this.close(context, ''), icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.primary,));

  // @override
  // PreferredSizeWidget buildBottom(BuildContext context) {
  //   return const PreferredSize(
  //      preferredSize: Size.fromHeight(56.0),
  //      child: Text('bottom'));
  // }

  @override
  Widget buildSuggestions(BuildContext context) => _getSearchResults(context);

  @override
  Widget buildResults(BuildContext context) => _getSearchResults(context);

  @override
  List<Widget> buildActions(BuildContext context) => <Widget>[
    IconButton(onPressed: () => query = '', icon: Icon(Icons.close, color: Theme.of(context).colorScheme.primary,))
  ];

  Widget _getSearchResults(BuildContext context) {
    // _test(context);
    return _SearchResults(query, () {
      this.close(context, query);
    });
  }

  // _test(BuildContext context) async {
  //   Timer(Duration(seconds: 1), () {
  //     searchResults = ListView(
  //       children: [
  //         Container(
  //           height: 10,
  //           color: Colors.red,
  //         )
  //       ],
  //     );
  //     showSuggestions(context);
  //   });
  
}

class _SearchResults extends StatefulWidget {
  final String query;
  final Function close;
  _SearchResults(this.query, this.close, {Key? key}) : super(key: key);

  @override
  __SearchResultsState createState() => __SearchResultsState();
}

class __SearchResultsState extends State<_SearchResults> {
  Widget cachedSearchResults = ListView();
  String cashedQuery = '';
  @override
  Widget build(BuildContext context) {
    updateSearch(context);
    return cachedSearchResults;
  }

  updateSearch(BuildContext context) async {
    if (this.widget.query == cashedQuery) return;
    if (this.widget.query == '') return setState(() {
      cachedSearchResults = ListView();
      cashedQuery = '';
    });
    var response =  
        await http.get(Uri.parse(base + 'search/' + this.widget.query));

    var body = jsonDecode(response.body);

    List? weineRaw = body['weine'];
    List? weinbauern = body['weinbauern'];
    List? sorten = body['sorten'];
    List? regionen = body['regionen'];

    Iterable<Wein>? weineIterable = weineRaw?.map((data) =>
        Wein.fromMap(data, Provider.of<Weine>(context, listen: false)));
    Iterable<Weinbauer>? weinbauerIterable = weinbauern?.map((data) =>
        Weinbauer.fromMap(
            data, Provider.of<Weinbauern>(context, listen: false)));
    Iterable<Sorte>? sorteIterable = sorten?.map((data) =>
        Sorte.fromMap(data, Provider.of<Sorten>(context, listen: false)));
    Iterable<Region>? regionIterable = regionen?.map((data) =>
        Region.fromMap(data, Provider.of<Regionen>(context, listen: false)));

    List elemente = [];

    if (weineIterable != null) elemente.addAll(weineIterable);
    if (weinbauerIterable != null) elemente.addAll(weinbauerIterable);
    if (sorteIterable != null) elemente.addAll(sorteIterable);
    if (regionIterable != null) elemente.addAll(regionIterable);

    elemente.sort((el1, el2) => el2.relevance.compareTo(el1.relevance));

    setState(() {
      cashedQuery = this.widget.query;
      cachedSearchResults = ListView(
        children: [
          for (int i = 0; i < elemente.length; i++) renderElement(elemente[i], context)
        ],
      );
    });
  }

  Widget renderElement(dynamic element, BuildContext context) {
    if (element.runtimeType == Wein) {
      return weineComponents.listItem(
          element, getTapped(WeinePage.tapped), context);
    } else if (element.runtimeType == Weinbauer) {
      return weinbauernComponents.listItem(
          element, getTapped(WeinbauernPage.tapped), context);
    } else if (element.runtimeType == Sorte) {
      return sortenComponents.listItem(
          element, getTapped(SortenPage.tapped), context);
    } else if (element.runtimeType == Region) {
      return regionenComponents.listItem(
          element, getTapped(RegionenPage.tapped), context);
    } else {
      throw Error();
    }
  }

  void Function(dynamic, BuildContext) getTapped(Function showPage) {
    return (val, context) {
      this.widget.close();

      showPage(val, context);
    };
  }
}
