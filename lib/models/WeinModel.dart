part of 'models.dart';

class WeinModel extends Equatable {
  /// ID dieses Weins in der Datenbank
  final int id;

  /// Name des Weins
  ///
  /// Der Name ist nur der Name ohne die Sorte: Bei einem "Gelben Muskateller Klassik" ist nur
  /// "Klassik" der Name. Das bedeutet auch, dass der Name nicht eindeutig sein muss.
  final String name;

  /// Sorte des Weins
  final SorteModel sorte;

  /// Wie viele ungeöffnete/ungetrunkene Flaschen des Weines noch vorhanden sind
  final int anzahl;

  /// Wie viele Flaschen schon getrunken wurden
  final int getrunken;

  /// Jahrgang des Weins
  final int? jahr;

  /// Weinbauer des Weins
  final WeinbauerModel? weinbauer;

  /// Datums (aka ungenauer Zeitstempel) des Kaufs
  final DateTime? gekauft;

  /// Beschreibung des Weins
  final String? beschreibung;

  /// Inhalt in l (Liter)
  final double? inhalt;

  /// Nummer des Faches, in dem sich der Wein befindet
  final int? fach;

  /// Preis des Weins in €
  final double? preis;

  WeinModel(
      {required this.id,
      required this.name,
      required this.sorte,
      required this.anzahl,
      required this.getrunken,
      this.jahr,
      this.weinbauer,
      this.gekauft,
      this.beschreibung,
      this.inhalt,
      this.fach,
      this.preis});

  @override
  List<Object?> get props => [
        id,
        name,
        sorte,
        anzahl,
        getrunken,
        jahr,
        weinbauer,
        gekauft,
        beschreibung,
        inhalt,
        fach,
        preis
      ];

  // Contructor from a JSON object  
  factory WeinModel.fromJson(Map<String, dynamic> json) => WeinModel(
        id: json['id'] as int,
        name: json['name'] as String,
        sorte: SorteModel.fromJson(json['sorten'] as Map<String, dynamic>),
        anzahl: json['anzahl'] as int,
        getrunken: json['getrunken'] as int,
        jahr: json['jahr'] as int?,
        weinbauer: json['weinbauern'] == null
            ? null
            : WeinbauerModel.fromJson(json['weinbauern'] as Map<String, dynamic>),
        gekauft: json['gekauft'] == null
            ? null
            : DateTime.parse(json['gekauft'] as String),
        beschreibung: json['beschreibung'] as String?,
        inhalt: (json['inhalt'] is double) ? json['inhalt'] as double : json['inhalt']?.toDouble(),
        fach: json['fach'] as int?,
        preis: (json['preis'] is double) ? json['preis'] as double : json['preis']?.toDouble(),
      );

  // toJson
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'sorten_id': sorte.id,
        'anzahl': anzahl,
        'getrunken': getrunken,
        'jahr': jahr,
        'weinbauern_id': weinbauer?.id,
        'gekauft': gekauft?.toIso8601String(),
        'beschreibung': beschreibung,
        'inhalt': inhalt,
        'fach': fach,
        'preis': preis,
      };

  // copyWith
  WeinModel copyWith(
          {int? id,
          String? name,
          SorteModel? sorte,
          int? anzahl,
          int? getrunken,
          int? jahr,
          WeinbauerModel? weinbauer,
          DateTime? gekauft,
          String? beschreibung,
          double? inhalt,
          int? fach,
          double? preis}) =>
      WeinModel(
        id: id ?? this.id,
        name: name ?? this.name,
        sorte: sorte ?? this.sorte,
        anzahl: anzahl ?? this.anzahl,
        getrunken: getrunken ?? this.getrunken,
        jahr: jahr ?? this.jahr,
        weinbauer: weinbauer ?? this.weinbauer,
        gekauft: gekauft ?? this.gekauft,
        beschreibung: beschreibung ?? this.beschreibung,
        inhalt: inhalt ?? this.inhalt,
        fach: fach ?? this.fach,
        preis: preis ?? this.preis,
      );
}
