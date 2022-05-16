part of 'search_users_cubit.dart';

@immutable
abstract class SearchUsersState {}

class SearchUsersInitial extends SearchUsersState {}
class SearchUsersLoadingState extends SearchUsersState {}
class SearchUsersErrorState extends SearchUsersState {
  final String error;
  SearchUsersErrorState(this.error);
}
class ChangeTextState extends SearchUsersState {
  final bool changeForSave;
  final String icon;
  ChangeTextState(this.changeForSave,this.icon);
}
class SearchUsersSuccessState extends SearchUsersState {}
class NoUsersState extends SearchUsersState {}