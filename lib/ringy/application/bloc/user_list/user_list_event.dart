part of 'user_list_bloc.dart';

@immutable
abstract class UserListEvent {}
class GetUsersEvent extends UserListEvent{

 final String projectId;
  final String userId;
  final bool showUsers;

  GetUsersEvent(this.projectId, this.userId, this.showUsers);
}

