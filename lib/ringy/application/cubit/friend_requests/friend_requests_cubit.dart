import 'package:bloc/bloc.dart';
import 'package:flutter_chat/ringy/domain/entities/add_friends/friend_requests.dart';
import 'package:flutter_chat/ringy/domain/entities/add_friends/friend_requests.dart';
import 'package:meta/meta.dart';

import '../../../infrastructure/_repository.dart';
import '../../../resources/shared_preference.dart';

part 'friend_requests_state.dart';

class FriendRequestsCubit extends Cubit<FriendRequestsState> {

  final Repository repository;

  FriendRequestsCubit(this.repository) : super(FriendRequestsInitial()){
    getFriendRequests(Prefs.getString(Prefs.myUserId)!);
  }

  List<FriendRequests> dummyList = [];

  Future<void> getFriendRequests(String userId) async {
    emit(FriendRequestsLoadingState());
    var result = await repository.getFriendRequests(userId);
   return emit(result.fold((l) => checkLeft(l), (r) => checkList(r, "")));
  }


  // Future<void> sendFriendRequest(String userId, String friendId) async {
  //   if (friendId != userId) {
  //     if (friendId != "") {
  //       emit(SearchUsersSendingRequest(users: dummyList));
  //       var result = await repository.sendFriendRequest(userId, friendId);
  //       emit(result.fold((l) => checkLeft(l), (r) => checkList(dummyList,friendId)));
  //     }
  //   }
  // }

  checkList(List<FriendRequests> r ,String friendId) {
    dummyList = r;
    // if(friendId != ""){
    //   dummyList[dummyList
    //       .indexWhere((element) => element.id == friendId)]
    //       .friendStatus = 2;
    // }
    dummyList.isNotEmpty
        ? emit(FriendRequestsSuccessState(users: r))
        : emit(NoUsersState());
  }

  checkLeft(String l) {
    emit(NoUsersState());
  }
}
