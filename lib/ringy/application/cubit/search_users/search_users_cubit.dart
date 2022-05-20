import 'package:bloc/bloc.dart';
import 'package:flutter_chat/ringy/domain/entities/add_friends/searched_users.dart';
import 'package:flutter_chat/ringy/infrastructure/API/api_content.dart';
import 'package:meta/meta.dart';

import '../../../infrastructure/_repository.dart';

part 'search_users_state.dart';

class SearchUsersCubit extends Cubit<SearchUsersState> {
  final Repository repository;

  SearchUsersCubit(this.repository) : super(SearchUsersInitial());
  String text = "";
  List<Datum> dummyList = [];

  Future<void> textChangedSearchUser(String userId, String textName) async {
    if (textName != text) {
      text = textName;
      if (textName != "") {
        emit(SearchUsersLoadingState());
        var result = await repository.searchUser(userId, textName);
        emit(result.fold((l) => SearchUsersErrorState(l), (r) => checkList(r, "")));
      } else {
        emit(SearchUsersSuccessState(users: []));
      }
    }
  }


  Future<void> sendFriendRequest(String userId, String friendId) async {
    if (friendId != userId) {
      if (friendId != "") {
        emit(SearchUsersSendingRequest(users: dummyList));
        var result = await repository.sendFriendRequest(userId, friendId);
        emit(result.fold((l) => checkLeft(l), (r) => checkList(dummyList,friendId)));
      }
    }
  }

  checkList(List<Datum> r ,String friendId) {
    dummyList = r;
    if(friendId != ""){
      dummyList[dummyList
          .indexWhere((element) => element.id == friendId)]
          .friendStatus = 2;
    }
    dummyList.isNotEmpty
        ? emit(SearchUsersSuccessState(users: r))
        : emit(NoUsersState());
  }

  checkLeft(String l) {}


}
