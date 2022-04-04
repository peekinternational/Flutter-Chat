import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_chat/ringy/infrastructure/API/api_content.dart';
import 'package:flutter_chat/ringy/infrastructure/_repository.dart';
import 'package:flutter_chat/ringy/resources/constants.dart';
import 'package:flutter_chat/ringy/resources/shared_preference.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final Repository repository;

  LoginCubit(this.repository) : super(LoginInitial());

  void loginUser(String email, String password) async {
    emit(LoadingState());
    var result = await repository.loginUser(email, password);
    result.fold((l) => emit(ErrorState(l)), (r) => checkStatus(r));
  }

  checkStatus(String r) {
    r == "true"
        ? {
      emit(SuccessState())
    }
        : emit(InvalidUserState());
    print(Prefs.getString(Prefs.myUserId));
  }
}
