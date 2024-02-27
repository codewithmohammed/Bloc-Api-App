import 'dart:async';

import 'package:bloc_api_app/features/auth/model/auth_user_model.dart';
import 'package:bloc_api_app/features/auth/repository/auth_user_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginButtonClicked>(_authLoginButtonClicked);
  }

  FutureOr<void> _authLoginButtonClicked(
      AuthLoginButtonClicked event, Emitter<AuthState> emit) async {
    emit(AuthLoginLoading());
    await Future.delayed(const Duration(seconds: 3));
    var token = await AuthUser.loginUser(
        AuthUserModel(username: event.username, password: event.password));
    emit(AuthLoginSuccess());
  }
}
