import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_chat/ringy/domain/entities/users/chatusers/users_model.dart';
import 'package:flutter_chat/ringy/infrastructure/_repository.dart';
import 'package:meta/meta.dart';

part 'users_list_for_group_event.dart';
part 'users_list_for_group_state.dart';

class UsersListForGroupBloc extends Bloc<UsersListForGroupEvent, UsersListForGroupState> {
  final Repository repository;
  List<UsersList> dummyList = [];
  List<UsersList> selectedUsersDummyList = [];

  UsersListForGroupBloc(this.repository) : super(UsersListForGroupInitial()) {
    on<GetUsersForGroupEvent>(_onEvent, transformer: sequential());
    on<SelectUserForGroupEvent>(_onEventSelectUser, transformer: sequential());
  }

  FutureOr<void> _onEvent(
      GetUsersForGroupEvent event, Emitter<UsersListForGroupState> emit) async {
    emit(LoadingState());

    var result = await repository.getUsersList(event.projectId, event.userId);
    result.fold((l) => emit(ErrorState()), (r) => checkUsersCount(r, emit));
  }
  FutureOr<void> _onEventSelectUser(
      SelectUserForGroupEvent event, Emitter<UsersListForGroupState> emit) async {
    bool isSelected = dummyList[event.index].selectedForGroup;
    dummyList[event.index].selectedForGroup = !isSelected;
    if(isSelected == true){
      selectedUsersDummyList.removeWhere((element) => element.selectedForGroup == false);
    }else{
      selectedUsersDummyList.add(dummyList[event.index]);
    }
    // selectedUsersDummyList = [];
    // selectedUsersDummyList.addAll(dummyList.where((a) => a.selectedForGroup == true));

    emit(LoadedState(users: dummyList,selectedUsers: selectedUsersDummyList));
  }

  checkUsersCount(List<UsersList> r, Emitter<UsersListForGroupState> emit) {
    dummyList = r;
    r.isNotEmpty ? emit(LoadedState(users: r,selectedUsers: selectedUsersDummyList)) : emit(NoUsersState());
  }
}



