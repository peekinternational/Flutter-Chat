part of 'profile_settings_cubit.dart';

@immutable
abstract class ProfileSettingsState {}

class ProfileInitial extends ProfileSettingsState {}
class ProfileLoadingState extends ProfileSettingsState {}
class ProfileErrorState extends ProfileSettingsState {
  final String error;
  ProfileErrorState(this.error);
}
class ChangeTextState extends ProfileSettingsState {
  final bool changeForSave;
  final String icon;
  ChangeTextState(this.changeForSave,this.icon);
}
class ProfileSuccessState extends ProfileSettingsState {}
