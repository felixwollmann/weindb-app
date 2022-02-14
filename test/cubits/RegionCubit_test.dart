import 'package:test/test.dart';
import 'package:weindb/cubits/DatabaseProvider.dart';
import 'package:weindb/cubits/RegionCubit.dart';
import 'package:weindb/models/models.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  final db = DatabaseProvider(baseURL: "http://192.168.100.10/test/");

  group('RegionCubit Unit Tests', () {
    test('Initial State', () {
      RegionCubit regionCubit = new RegionCubit(db);

      expect(regionCubit.state.isInitializing, equals(true));
      expect(regionCubit.state.isLoading, equals(true));
      expect(regionCubit.state.isError, equals(false));
    });
  });

  group('RegionCubit-Stream', () {
    late RegionModel addedRegion;
    late RegionModel updatedRegion;
    late RegionModel reloadedRegion;

    blocTest(
      'save Region',
      build: () => RegionCubit(db),
      act: (RegionCubit cubit) async {
        await cubit.awaitInitialization;
        final region = RegionModel(
          id: 0,
          name: "Test-Region",
          land: "AT",
          beschreibung: "Hallo Welt",
        );
        addedRegion = await cubit.create(region);
      },
      verify: (RegionCubit cubit) {
        var data = cubit.state.data;

        expect(data, contains(addedRegion));
      },
    );

    blocTest(
      'edit Region',
      build: () => RegionCubit(db),
      act: (RegionCubit cubit) async {
        await cubit.awaitInitialization;
        final region = addedRegion.copyWith(
          name: 'Test-Region-2',
        );
        await cubit.change(region);
        updatedRegion =
            cubit.state.data.firstWhere((element) => element.id == region.id);
      },
      verify: (RegionCubit cubit) {
        var data = cubit.state.data;

        expect(data, contains(updatedRegion));
        expect(data, isNot(contains(addedRegion)));
      },
    );

    blocTest(
      'reload, and make sure it is still there',
      build: () => RegionCubit(db),
      act: (RegionCubit cubit) async {
        await cubit.awaitInitialization;
        await cubit.reload();

        reloadedRegion = cubit.state.data
            .firstWhere((element) => element.id == updatedRegion.id);

      },
      verify: (RegionCubit cubit) {
        var region = cubit.state.data
            .firstWhere((element) => element.id == updatedRegion.id);

        expect(region.name, equals(updatedRegion.name));
        expect(region.beschreibung, equals(updatedRegion.beschreibung));
        expect(region.land, equals(updatedRegion.land));
      },
    );

    blocTest(
      'delete Region',
      build: () => RegionCubit(db),
      act: (RegionCubit cubit) async {
        await cubit.awaitInitialization;
        await cubit.remove(reloadedRegion);
      },
      verify: (RegionCubit cubit) {
        expect(cubit.state.data, isNot(contains(reloadedRegion)));
      },
    );
  });
}
