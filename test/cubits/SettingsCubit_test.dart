import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weindb/cubits/SettingsCubit.dart';
import 'package:weindb/cubits/SettingsState.dart';
import 'package:bloc_test/bloc_test.dart';

// writing this took an enourmous amount of time, since
// a Mock Storage needed to be used, and I didn't have any 
// idea how to do that

// here are a few things that are helpful for understanding this
// https://github.com/felangel/bloc/blob/a48f2e75e40744d8a3ab21d7c6872955f9c5a8df/examples/flutter_weather/test/weather/cubit/weather_cubit_test.dart#L96
// https://github.com/felangel/bloc/blob/master/examples/flutter_weather/test/helpers/hydrated_bloc.dart
// https://pub.dev/packages/hydrated_bloc
// https://github.com/felangel/bloc/issues/2022
// https://github.com/felangel/bloc/issues/2108

void main() async {
  group('Settings-Cubit', () {
    blocTest(
      'sae',
      build: () => mockHydratedStorage(() => SettingsCubit()),
      act: (SettingsCubit cubit) async {
        cubit.setKey('hello', 'world');
        cubit.setKey('a number', 1234);
      },
    expect: () => [SettingsState({'hello': 'world', 'a number': 1234})],
    );
  });
}


// this is copied from one of the links above

class MockStorage extends Mock implements Storage {}

T mockHydratedStorage<T>(T Function() body, {Storage? storage}) {
  return HydratedBlocOverrides.runZoned<T>(
    body,
    storage: storage ?? _buildMockStorage(),
  );
}

Storage _buildMockStorage() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final storage = MockStorage();
  when(() => storage.write(any(), any<dynamic>())).thenAnswer((_) async {});
  return storage;
}