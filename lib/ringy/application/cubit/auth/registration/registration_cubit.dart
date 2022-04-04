

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_chat/ringy/infrastructure/_repository.dart';

part 'registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  final Repository repository;
  RegistrationCubit(this.repository) : super(RegistrationInitial());

  void registerUser(String email,String phone,String name,String userId,String password) async {
    emit(LoadingState());
    var result = await repository.registerUser(email, phone, name, userId, password);
    emit(result.fold((l) => ErrorState(l), (r) => checkStatus(r)));
  }

  checkStatus(String r) {
    r == "1" ?
    emit(SuccessState()):
    emit(AlreadyRegisteredState());
    print(r);
  }
}
