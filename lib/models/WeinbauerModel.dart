part of 'models.dart';

class WeinbauerModel extends Equatable {
  /// Einzigartige ID des Weinbauers
  final int id;

  /// Name des Weinbauers
  /// 
  /// Muss nicht eindeutig sein, allerdings kann davon ausgegangen werden, da zwei Weinbauern mit dem gleichen Namen
  /// sehr verwirrend wären
  final String name;

  /// Region des Weinbauers
  final RegionModel? region;

  /// Beschreibung des Weinbauers
  final String? beschreibung;

  WeinbauerModel({
    required this.id,
    required this.name,
    this.region,
    this.beschreibung,
  });


  @override
  List<Object?> get props => [id, region, name, beschreibung];


  // Contructor from a JSON object  
  factory WeinbauerModel.fromJson(Map<String, dynamic> json) => WeinbauerModel(
    id: json['id'] as int,
    name: json['name'] as String,
    region: json['regionen'] == null ? null : RegionModel.fromJson(json['regionen'] as Map<String, dynamic>),
    beschreibung: json['beschreibung'] as String?,
  );

  // toJson
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'regionen_id': region?.id,
    'beschreibung': beschreibung,
  };
}
