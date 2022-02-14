import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:weindb/cubits/SettingsState.dart';

class SettingsCubit extends HydratedCubit<SettingsState> {
  SettingsCubit()
      : super(SettingsState({}));

  void setKey(String key, dynamic value) {
    final settings = state.settings;
    settings[key] = value;
    emit(state.copyWith(settings: settings));
  }

  dynamic getKey(String key) => state.settings[key];

  @override
  SettingsState fromJson(Map<String, dynamic> json) =>
      SettingsState.fromJson(json);

  @override
  Map<String, dynamic> toJson(SettingsState state) => state.toJson();
}