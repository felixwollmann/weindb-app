import 'package:test/test.dart';
import 'package:weindb/cubits/DatabaseProvider.dart';
// import 'package:weindb/cubits/DatabaseProviderBase.dart';
// import 'package:weindb/cubits/ElementState.dart';
import 'package:weindb/cubits/SorteCubit.dart';
import 'package:weindb/models/models.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  final db = DatabaseProvider(baseURL: "http://192.168.100.10/test/");

  group('SorteCubit Unit Tests', () {
    test('Initial State', () {
      SorteCubit sorteCubit = new SorteCubit(db);

      expect(sorteCubit.state.isInitializing, equals(true));
      expect(sorteCubit.state.isLoading, equals(true));
      expect(sorteCubit.state.isError, equals(false));
    });
  });

  group('SorteCubit-Stream', () {
    late SorteModel addedSorte;
    late SorteModel updatedSorte;
    late SorteModel reloadedSorte;

    blocTest(
      'save Sorte',
      build: () => SorteCubit(db),
      act: (SorteCubit cubit) async {
        await cubit.awaitInitialization;
        final sorte = SorteModel(
          id: 0,
          name: "Test-Sorte",
          farbe: WeinFarbenHelper.fromString("Rot")!,
        );
        addedSorte = await cubit.create(sorte);
      },
      verify: (SorteCubit cubit) {
        var data = cubit.state.data;

        expect(data, contains(addedSorte));
      },
    );

    blocTest(
      'edit Sorte',
      build: () => SorteCubit(db),
      act: (SorteCubit cubit) async {
        await cubit.awaitInitialization;
        final sorte = addedSorte.copyWith(
          name: 'Test-Sorte-2',
        );
        await cubit.change(sorte);
        updatedSorte =
            cubit.state.data.firstWhere((element) => element.id == sorte.id);
      },
      verify: (SorteCubit cubit) {
        var data = cubit.state.data;

        expect(data, contains(updatedSorte));
        expect(data, isNot(contains(addedSorte)));
      },
    );

    blocTest(
      'reload, and make sure it is still there',
      build: () => SorteCubit(db),
      act: (SorteCubit cubit) async {
        await cubit.awaitInitialization;
        await cubit.reload();

        reloadedSorte = cubit.state.data
            .firstWhere((element) => element.id == updatedSorte.id);

        // await cubit.change(wein);
        // updatedWein = cubit.state.data.firstWhere((element) => element.id == wein.id);
      },
      verify: (SorteCubit cubit) {
        // var data = cubit.state.data;

        var sorte = cubit.state.data
            .firstWhere((element) => element.id == updatedSorte.id);

        expect(sorte.name, equals(updatedSorte.name));
        expect(sorte.farbe, equals(updatedSorte.farbe));
      },
    );

    blocTest(
      'delete Sorte',
      build: () => SorteCubit(db),
      act: (SorteCubit cubit) async {
        await cubit.awaitInitialization;
        await cubit.remove(reloadedSorte);
      },
      verify: (SorteCubit cubit) {
        // var data = cubit.state.data;

        expect(cubit.state.data, isNot(contains(reloadedSorte)));
        // expect(data, contains(updatedWein));
        // expect(data, isNot(contains(addedWein)));
      },
    );
  });
}
