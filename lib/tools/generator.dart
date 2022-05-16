import 'dart:math';

import 'package:weindb/models/models.dart';
import 'package:faker/faker.dart';
// import 'package:faker/faker.dart';

/// Generates fake [Wein]s, [Weinbauer]s and so on.
///
/// Every ID will be **unique**.
class Generator {
  Generator(
    int? seed,
  )   : random = Random(seed),
        faker = Faker.withGenerator(RandomGenerator(seed: seed));

  Random random;
  Faker faker;

  /// Highest ID used; starts at 1000 to not collide with ones in tests
  ///
  /// Every ID will be unique, even though in reality e.g. a [WeinbauerModel] & a [WeinModel] could actually have the same ID.
  /// This implementation is just easier.
  static int hightestId = 1000;

  /// Generates a random [WeinModel]
  WeinModel randomWein() {
    return WeinModel(
        id: _randomId(),
        name: faker.food.dish(),
        sorte: randomSorte(),
        anzahl: random.nextInt(100),
        getrunken: random.nextInt(100),
        jahr: _nullable(1990 + random.nextInt(100)),
        weinbauer: _nullable(randomWeinbauer()),
        gekauft: _nullable(DateTime.now()),
        beschreibung: _nullableFunction(faker.lorem.sentence),
        inhalt: _nullable(
            (random.nextDouble().clamp(0.25, 1.0) * 1000).roundToDouble() /
                1000), // 0.25 <= inhalt < 1; rounded to 3 digits
        fach: _nullable(random.nextInt(100)),
        preis: _nullable((random.nextDouble() * 100).roundToDouble()));
  }

  WeinbauerModel randomWeinbauer() {
    return WeinbauerModel(
        id: _randomId(),
        name: _weingutName(),
        region: _nullableFunction(randomRegion),
        beschreibung: _nullableFunction(faker.lorem.sentence));
  }

  int _randomId() {
    return hightestId++;
  }

  String _weingutName() =>
      "${_twoOptions(0.2, "Familienweingut", "Weingut")} ${faker.person.lastName()}";

  /// Generate either [option1] or [option2].
  ///
  /// ```dart
  /// String name = "${_twoOptions(0.2, "Familienweingut", "Weingut")} Peter Skoff"
  /// ```
  String _twoOptions(double chanceOfOption1, String option1,
      [String option2 = ""]) {
    return random.nextDouble() < chanceOfOption1 ? option1 : option2;
  }

  /// Returns [value] with a chance of [chanceOfNotNull], otherwise null
  T? _nullable<T>(T value, [double chanceOfNotNull = 0.8]) {
    return random.nextDouble() < chanceOfNotNull ? value : null;
  }

  /// Calls the function and return the result with a chance of [chanceOfNotNull], otherwise null will be returned
  T? _nullableFunction<T>(T Function() function,
          [double chanceOfNotNull = 0.8]) =>
      _nullable(function, chanceOfNotNull)?.call();

  /// Generates a random [SorteModel]
  SorteModel randomSorte() {
    return SorteModel(
      id: _randomId(),
      name: _sortenName(),
      farbe: randomWeinFarbe(),
    );
  }

  /// returns a most likely nonsensical name for a [SorteModel]
  String _sortenName() {
    var farben = [
      'Blauer',
      'Grüner',
      'Gelber',
      'Roter',
      'Pinker',
      'Weißer',
      'Schwarzer',
      'Brauner',
      'Grauer'
    ];
    var namen = [
      'Veltliner',
      'Saugivnong Blanc',
      'Zweigelt',
      'Blaufränkisch',
      'Muskateller',
      'Welschriesling',
      'Gemischter Satz',
      'Chardonnay',
      'Gewürztraminer'
    ];
    return '${_twoOptions(0.2, faker.randomGenerator.element(farben) + ' ')}${faker.randomGenerator.element(namen)}';
  }

  /// get a random [WeinFarbe]
  WeinFarbe randomWeinFarbe() =>
      faker.randomGenerator.element(WeinFarbe.values);

  /// Returns a random region
  RegionModel randomRegion() {
    return RegionModel(
      id: _randomId(),
      name: faker.address.neighborhood(),
      land: faker.address.countryCode(),
      beschreibung: _nullableFunction(faker.lorem.sentence),
    );
  }
}
