part of 'friend_requests_cubit.dart';

@immutable
abstract class FriendRequestsState {}

class FriendRequestsInitial extends FriendRequestsState {}
class FriendRequestsLoadingState extends FriendRequestsState {}
class FriendRequestsErrorState extends FriendRequestsState {
  final String error;
  FriendRequestsErrorState(this.error);
}
class FriendRequestsSuccessState extends FriendRequestsState {
  final List<FriendRequests> users;

  FriendRequestsSuccessState({required this.users});
}

class FriendRequestsAcceptRequest extends FriendRequestsState {
  final List<FriendRequests> users;

  FriendRequestsAcceptRequest({required this.users});
}
class NoUsersState extends FriendRequestsState {}
