part of 'users_list_for_group_bloc.dart';

@immutable
abstract class UsersListForGroupEvent {}
class GetUsersForGroupEvent extends UsersListForGroupEvent{

  final String projectId;
  final String userId;

  GetUsersForGroupEvent(this.projectId, this.userId);
}

class SelectUserForGroupEvent extends UsersListForGroupEvent{

  final int index;

  SelectUserForGroupEvent(this.index);
}