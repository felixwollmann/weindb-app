import 'package:test/test.dart';
import 'package:weindb/cubits/DatabaseProvider.dart';
// import 'package:weindb/cubits/DatabaseProviderBase.dart';
// import 'package:weindb/cubits/ElementState.dart';
import 'package:weindb/cubits/WeinbauerCubit.dart';
import 'package:weindb/models/models.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  final db = DatabaseProvider(baseURL: "http://192.168.100.10/test/");

  group('WeinbauerCubit Unit Tests', () {
    // WeinbauerCubit weinbauerCubit = new WeinbauerCubit(db);
    test('Initial State', () {
      // if the variable is initilized outside this method, it will already have loaded the data by the time the test runs
      WeinbauerCubit freshWeinbauerCubit = new WeinbauerCubit(db);
      
      expect(freshWeinbauerCubit.state.data, equals(<WeinbauerModel>[]), reason: "weinbauerCubit.state.data");
      expect(freshWeinbauerCubit.state.isInitializing, equals(true), reason: "weinbauerCubit.state.isInitializing");
      expect(freshWeinbauerCubit.state.isLoading, equals(true), reason: "weinbauerCubit.state.isLoading");
      expect(freshWeinbauerCubit.state.isError, equals(false), reason: "weinbauerCubit.state.isError");
    });
  });

  group('Weincubit-Stream', () {
    // WeinCubit weinCubit = new WeinCubit(db);

    late WeinbauerModel addedWeinbauer;
    late WeinbauerModel updatedWeinbauer;
    late WeinbauerModel reloadedWeinbauer;

    blocTest(
      'save Weinbauer',
      build: () => WeinbauerCubit(db),
      act: (WeinbauerCubit cubit) async {
        await cubit.awaitInitialization;
        final region = (await db.getRegionen()).first;
        final weinbauer = WeinbauerModel(
          id: 0,
          name: "TestWeinbauer",
          beschreibung: 'So eine schöne Beschreibung',
          region: region,
        );
        addedWeinbauer = await cubit.create(weinbauer);
      },
      verify: (WeinbauerCubit cubit) {
        var data = cubit.state.data;

        expect(data, contains(addedWeinbauer));
      },
    );

    blocTest(
      'edit Weinbauer',
      build: () => WeinbauerCubit(db),
      act: (WeinbauerCubit cubit) async {
        await cubit.awaitInitialization;
        final wein = addedWeinbauer.copyWith(
          name: 'TEST-Weinbauer-2',
        );
        await cubit.change(wein);
        updatedWeinbauer =
            cubit.state.data.firstWhere((element) => element.id == wein.id);
      },
      verify: (WeinbauerCubit cubit) {
        var data = cubit.state.data;

        expect(data, contains(updatedWeinbauer));
        expect(data, isNot(contains(addedWeinbauer)));
      },
    );

    blocTest(
      'reload, and make sure it is still there',
      build: () => WeinbauerCubit(db),
      act: (WeinbauerCubit cubit) async {
        await cubit.awaitInitialization;
        await cubit.reload();

        reloadedWeinbauer = cubit.state.data
            .firstWhere((element) => element.id == updatedWeinbauer.id);

        // await cubit.change(wein);
        // updatedWein = cubit.state.data.firstWhere((element) => element.id == wein.id);
      },
      verify: (WeinbauerCubit cubit) {
        // var data = cubit.state.data;

        var weinbauer = cubit.state.data
            .firstWhere((element) => element.id == updatedWeinbauer.id);

        expect(weinbauer.name, equals(updatedWeinbauer.name));
        expect(weinbauer.beschreibung, equals(updatedWeinbauer.beschreibung));
        expect(weinbauer.region, equals(updatedWeinbauer.region));

      },
    );

    blocTest(
      'delete Weinbauer',
      build: () => WeinbauerCubit(db),
      act: (WeinbauerCubit cubit) async {
        await cubit.awaitInitialization;
        await cubit.remove(reloadedWeinbauer);

      },
      verify: (WeinbauerCubit cubit) {
        // var data = cubit.state.data;

        expect(cubit.state.data, isNot(contains(reloadedWeinbauer)));
        // expect(data, contains(updatedWein));
        // expect(data, isNot(contains(addedWein)));
      },
    );
  });
}
