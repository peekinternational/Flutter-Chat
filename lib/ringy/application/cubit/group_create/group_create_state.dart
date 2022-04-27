part of 'group_create_cubit.dart';

@immutable
abstract class GroupCreateState {}

class GroupInitial extends GroupCreateState {}
class GroupLoadingState extends GroupCreateState {}
class GroupErrorState extends GroupCreateState {
  final String error;
  GroupErrorState(this.error);
}
class ChangeIconState extends GroupCreateState {
  final String icon;
  ChangeIconState(this.icon);
}
class GroupSuccessState extends GroupCreateState {}
