part of 'registration_cubit.dart';

@immutable
abstract class RegistrationState {}

class RegistrationInitial extends RegistrationState {}
class LoadingState extends RegistrationState {}
class AlreadyRegisteredState extends RegistrationState {}
class ErrorState extends RegistrationState {
  final String error;

  ErrorState(this.error);
}
class SuccessState extends RegistrationState {}
