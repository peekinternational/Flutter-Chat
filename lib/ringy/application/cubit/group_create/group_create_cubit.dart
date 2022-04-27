import 'package:bloc/bloc.dart';
import 'package:flutter_chat/ringy/domain/entities/users/chatusers/users_model.dart';
import 'package:flutter_chat/ringy/infrastructure/_repository.dart';
import 'package:meta/meta.dart';

part 'group_create_state.dart';

class GroupCreateCubit extends Cubit<GroupCreateState> {
  final Repository repository;

  GroupCreateCubit(this.repository) : super(GroupInitial());

  void createGroup(
    String groupName,
    List<UsersList> mListSelected,
    String iconPath,
  ) async {
    emit(GroupLoadingState());
    var result =
        await repository.createGroup(groupName, mListSelected, iconPath);
    emit(result.fold((l) => GroupErrorState(l), (r) => GroupSuccessState()));
  }

  void changeIcon(String icon) {
    emit(ChangeIconState(icon));
  }
}
