import 'package:bloc/bloc.dart';

part 'friend_pages_state.dart';

class FriendPagesCubit extends Cubit<FriendPagesInitial> {

  int val;
  FriendPagesCubit(this.val) : super(FriendPagesInitial(pageValue: val));



  void changePage(int value) => emit(FriendPagesInitial(pageValue: value));
}
