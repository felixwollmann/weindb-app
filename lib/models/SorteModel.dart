part of 'models.dart';

class SorteModel extends Equatable {
  final int id;
  final String name;
  final WeinFarbe farbe;

  SorteModel({
    required this.id,
    required this.name,
    required this.farbe,
  });

  @override
  List<Object> get props => [id, name, farbe];

  // Constructor from a JSON object
  factory SorteModel.fromJson(Map<String, dynamic> json) => SorteModel(
        id: json['id'] as int,
        name: json['name'] as String,
        farbe: WeinFarbenHelper.fromInt(json['farbe'] as int),);


  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'farbe': WeinFarbenHelper.toInt(farbe),
      };

  // copyWith
  SorteModel copyWith({
    int? id,
    String? name,
    WeinFarbe? farbe,
  }) {
    return SorteModel(
      id: id ?? this.id,
      name: name ?? this.name,
      farbe: farbe ?? this.farbe,
    );
  }

}
