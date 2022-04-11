import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/login_event.dart';
import 'package:login/login_state.dart';
import 'package:login/my_home_page.dart';

import 'login_policy.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(LoginState initialState) : super(initialState);

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    // TODO: implement mapEventToState
    LoginState newState = state.coppy();
    if (event is UsernameChangeEvent) newState.username = event.username;
    if (event is PasswordChangeEvent) newState.password = event.password;
    if (event is LoginRequest) {
      if (state.username == "") {
        newState.stt = "username is requered";
      } else {
        bool check = await LoginPolicy.check(state);
        if (check) {
          ///go to home page
          newState.loginSuccess = true;
        } else {
          newState.stt = "wrong username or password";
        }
      }
    }
    yield newState;
  }
}
