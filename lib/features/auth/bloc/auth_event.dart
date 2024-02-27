part of 'auth_bloc.dart';
sealed class AuthEvent {}

final class AuthLoginButtonClicked extends AuthEvent {
  final String username;
  final String password;
  AuthLoginButtonClicked({required this.username, required this.password});
}
