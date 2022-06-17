import 'package:flutter_chat/ringy/application/bloc/chat_list_bloc/chat_list_bloc.dart';
import 'package:flutter_chat/ringy/application/bloc/group_list/group_list_bloc.dart';
import 'package:flutter_chat/ringy/application/bloc/user_list/user_list_bloc.dart';
import 'package:flutter_chat/ringy/application/bloc/users_list_for_group_bloc/users_list_for_group_bloc.dart';
import 'package:flutter_chat/ringy/application/cubit/auth/login/login_cubit.dart';
import 'package:flutter_chat/ringy/application/cubit/auth/registration/registration_cubit.dart';
import 'package:flutter_chat/ringy/application/cubit/friend_requests/friend_requests_cubit.dart';
import 'package:flutter_chat/ringy/application/cubit/group_create/group_create_cubit.dart';
import 'package:flutter_chat/ringy/application/cubit/profile_settings/profile_settings_cubit.dart';
import 'package:flutter_chat/ringy/application/cubit/search_users/search_users_cubit.dart';
import 'package:flutter_chat/ringy/infrastructure/_repository.dart';
import 'package:flutter_chat/ringy/infrastructure/data_sources/api_data_source.dart';
import 'package:flutter_chat/ringy/presentation/core/socket/users_socket_utils.dart';
import 'package:flutter_chat/ringy/presentation/routes/router.dart';
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
    () => UserListBloc(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => UsersListForGroupBloc(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => GroupListBloc(
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

  serviceLocator.registerFactory(
    () => GroupCreateCubit(
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => ProfileSettingsCubit(
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => SearchUsersCubit(
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => FriendRequestsCubit(
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
  serviceLocator.registerSingleton<AppRouter>(AppRouter());
  serviceLocator.registerSingleton<SocketProviderUsers>(SocketProviderUsers());
}
