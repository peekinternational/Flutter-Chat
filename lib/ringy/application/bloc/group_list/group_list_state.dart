part of 'group_list_bloc.dart';

@immutable
abstract class GroupListState {}

class GroupListInitial extends GroupListState {}

class LoadedState extends GroupListState{

  final List<GroupList> groups;

  LoadedState({required this.groups});

}

class ErrorState extends GroupListState{

}
class LoadingState extends GroupListState{}
class NoGroupsState extends GroupListState{}
