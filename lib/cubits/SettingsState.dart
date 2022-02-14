import 'package:equatable/equatable.dart';

class SettingsState extends Equatable {
  final Map<String, dynamic> settings;

  SettingsState(this.settings);

  factory SettingsState.fromJson(Map<String, dynamic> json) {
    return SettingsState(json);
  }

  Map<String, dynamic> toJson() {
    return settings;
  }

  SettingsState copyWith({
    Map<String, dynamic>? settings,
  }) {
    return SettingsState(
      settings ?? this.settings,
    );
  }

  @override
  List<Object?> get props => [settings];
}
