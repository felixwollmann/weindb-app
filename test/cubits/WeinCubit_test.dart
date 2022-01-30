import 'package:test/test.dart';
import 'package:weindb/cubits/DatabaseProvider.dart';
import 'package:weindb/cubits/DatabaseProviderBase.dart';
import 'package:weindb/cubits/ElementState.dart';
import 'package:weindb/cubits/WeinCubit.dart';
import 'package:weindb/models/models.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  final db = DatabaseProvider(baseURL: "http://192.168.100.10/test/");

  group('WeinCubit Unit Tests', () {
    WeinCubit weinCubit = new WeinCubit(db);
    test('Initial State', () {
      expect(weinCubit.state.isInitializing, equals(true));
      expect(weinCubit.state.isLoading, equals(true));
    });
  });

  group('Weincubit-Stream', () {
    WeinCubit weinCubit = new WeinCubit(db);

    late WeinModel addedWein;
    late WeinModel updatedWein;
    late WeinModel reloadedWein;

    blocTest(
      'save Wein',
      build: () => weinCubit,
      act: (WeinCubit cubit) async {
        final sorte = (await db.getSorten())[1];
        final weinbauer = (await db.getWeinbauern())[1];
        final jetzt = DateTime.now();
        final wein = WeinModel(
          id: 0, // it is not saved yet
          name: 'TEST-WEIN',
          sorte: sorte,
          anzahl: 10,
          getrunken: 20,
          jahr: 2020,
          weinbauer: weinbauer,
          gekauft: jetzt,
          beschreibung: 'hi there',
          inhalt: 0.75,
          fach: 10,
          preis: 10.0,
        );
        addedWein = await cubit.create(wein);
      },
      verify: (WeinCubit cubit) {
        var data = cubit.state.data;

        expect(data, contains(addedWein));
      },
    );

    blocTest(
      'edit Wein',
      build: () => weinCubit,
      act: (WeinCubit cubit) async {
        final wein = addedWein.copyWith(
          name: 'TEST-WEIN-2',
        );
        await cubit.change(wein);
        updatedWein =
            cubit.state.data.firstWhere((element) => element.id == wein.id);
      },
      verify: (WeinCubit cubit) {
        var data = cubit.state.data;

        expect(data, contains(updatedWein));
        expect(data, isNot(contains(addedWein)));
      },
    );

    blocTest(
      'reload, and make sure it is still there',
      build: () => weinCubit,
      act: (WeinCubit cubit) async {
        await cubit.reload();

        reloadedWein = cubit.state.data
            .firstWhere((element) => element.id == updatedWein.id);

        // await cubit.change(wein);
        // updatedWein = cubit.state.data.firstWhere((element) => element.id == wein.id);
      },
      verify: (WeinCubit cubit) {
        // var data = cubit.state.data;

        var wein = cubit.state.data
            .firstWhere((element) => element.id == updatedWein.id);

        expect(wein.anzahl, equals(updatedWein.anzahl));
        expect(wein.getrunken, equals(updatedWein.getrunken));
        expect(wein.name, equals(updatedWein.name));
        expect(wein.sorte, equals(updatedWein.sorte));
        expect(wein.weinbauer, equals(updatedWein.weinbauer));
        expect(wein.jahr, equals(updatedWein.jahr));
        expect(wein.beschreibung, equals(updatedWein.beschreibung));
        expect(wein.inhalt, equals(updatedWein.inhalt));
        expect(wein.fach, equals(updatedWein.fach));
        expect(wein.preis, equals(updatedWein.preis));
        expect(wein.gekauft!.difference(updatedWein.gekauft!).inMilliseconds,
            inExclusiveRange(-900, 900));

        // expect(data, contains(updatedWein));
        // expect(data, isNot(contains(addedWein)));
      },
    );

    blocTest(
      'delete Wein',
      build: () => weinCubit,
      act: (WeinCubit cubit) async {
        await cubit.remove(reloadedWein);
        // await cubit.change(wein);
        // updatedWein = cubit.state.data.firstWhere((element) => element.id == wein.id);
      },
      verify: (WeinCubit cubit) {
        // var data = cubit.state.data;

        expect(cubit.state.data, isNot(contains(reloadedWein)));
        // expect(data, contains(updatedWein));
        // expect(data, isNot(contains(addedWein)));
      },
    );
  });
}