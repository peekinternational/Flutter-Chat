part of 'group_list_bloc.dart';

@immutable
abstract class GroupListEvent {}
class GetGroupsEvent extends GroupListEvent{

  final String projectId;
  final String userId;
  final bool showUsers;

  GetGroupsEvent(this.projectId, this.userId, this.showUsers);
}