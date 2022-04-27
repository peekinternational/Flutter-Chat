part of 'users_list_for_group_bloc.dart';

@immutable
abstract class UsersListForGroupState {}

class UsersListForGroupInitial extends UsersListForGroupState {}

class LoadedState extends UsersListForGroupState{

  final List<UsersList> users;
  final List<UsersList> selectedUsers;

  LoadedState({required this.users,required this.selectedUsers});

}

class ErrorState extends UsersListForGroupState{

}
class LoadingState extends UsersListForGroupState{}
class NoUsersState extends UsersListForGroupState{}
