import 'package:bloc/bloc.dart';
import 'package:flutter_chat/ringy/infrastructure/_repository.dart';
import 'package:flutter_chat/ringy/resources/shared_preference.dart';
import 'package:meta/meta.dart';

part 'profile_settings_state.dart';

class ProfileSettingsCubit extends Cubit<ProfileSettingsState> {
  final Repository repository;

  ProfileSettingsCubit(this.repository) : super(ProfileInitial());

  void changeProfile(
      String textName,String textIcon,String textEmail
      ) async {
    emit(ProfileLoadingState());
    var result =
    await repository.changeProfile(textName, textIcon, textEmail);
    emit(result.fold((l) => ProfileErrorState(l), (r) => ProfileSuccessState()));
  }



  void textChanged(String textName,String textIcon,String textEmail) {
    bool changeForSave = false;
    if(textName != "" && textName != Prefs.getString(Prefs.myName))
    {
      changeForSave = true;
    }
    if(textIcon != "" && textIcon != Prefs.getString(Prefs.myImage))
    {
      changeForSave = true;
    }
    if(textEmail != "" && textEmail != Prefs.getString(Prefs.myMail))
    {
      changeForSave = true;
    }
    emit(ChangeTextState(changeForSave,textIcon));
  }
}
