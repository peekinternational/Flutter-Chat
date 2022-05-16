import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../infrastructure/_repository.dart';

part 'search_users_state.dart';

class SearchUsersCubit extends Cubit<SearchUsersState> {
  final Repository repository;
  SearchUsersCubit(this.repository) : super(SearchUsersInitial());


  void textChangedSearchUser(String textName) {
    if(textName != "")
    {
      //CALL API
    }

    emit(ChangeTextState(changeForSave,textIcon));
  }
}
