part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}
class LoadingState extends LoginState {}
class InvalidUserState extends LoginState {}
class ErrorState extends LoginState {
  final String error;
  ErrorState(this.error);
}
class SuccessState extends LoginState {}