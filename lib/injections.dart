import 'package:flutter_chat/ringy/application/bloc/chat/chat_list_bloc/chat_list_bloc.dart';
import 'package:flutter_chat/ringy/application/bloc/chat/send_chat/send_chat_bloc.dart';
import 'package:flutter_chat/ringy/application/bloc/users/user_list/user_list_bloc.dart';
import 'package:flutter_chat/ringy/application/cubit/auth/login/login_cubit.dart';
import 'package:flutter_chat/ringy/application/cubit/auth/registration/registration_cubit.dart';
import 'package:flutter_chat/ringy/infrastructure/_repository.dart';
import 'package:flutter_chat/ringy/infrastructure/data_sources/api_data_source.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  chatDependencies();
}

Future<void> chatDependencies() async {
  serviceLocator.registerFactory(
    () => ChatListBloc(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => SendChatBloc(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => UserListBloc(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => RegistrationCubit(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => LoginCubit(
      serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => Repository(
      apiDataSource: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => ApiDataSource(),
  );
}
