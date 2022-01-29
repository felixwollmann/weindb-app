part of 'models.dart';

class RegionModel extends Equatable {
  final int id;
  final String name;
  final String land;
  final String? beschreibung;

  @override
  List<Object?> get props => [id, name, land, beschreibung];

  RegionModel(
    {
    required this.id,
    required this.name,
    required this.land,
    this.beschreibung,
  });

  // Contructor from a JSON object  
  factory RegionModel.fromJson(Map<String, dynamic> json) => RegionModel(
    id: json['id'] as int,
    name: json['name'] as String,
    land: json['land'] as String,
    beschreibung: json['beschreibung'] as String?,
  );

  // toJson
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'land': land,
    'beschreibung': beschreibung,
  };

  // copyWith
  RegionModel copyWith({
    int? id,
    String? name,
    String? land,
    String? beschreibung,
  }) =>
      RegionModel(
        id: id ?? this.id,
        name: name ?? this.name,
        land: land ?? this.land,
        beschreibung: beschreibung ?? this.beschreibung,
      );

}