part of 'auth_bloc.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoginLoading extends AuthState{}

final class AuthLoginSuccess extends AuthState{}

final class NavigateToHome extends AuthState{}