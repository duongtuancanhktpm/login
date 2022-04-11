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
    print("canh.dt start setstate");
    LoginState newState = state.coppy();
    if (event is UsernameChangeEvent) newState.username = event.username;
    if (event is PasswordChangeEvent) newState.password = event.password;
    if (event is LoginRequest) {
      if (state.username == "") {
        newState.stt = "username is requered";
      } else {
        print("canh.dt start querry");
        bool check = await LoginPolicy.check(state);
        print("canh.dt query done");
        if (check) {
          ///go to home page here
          newState.stt = "login successed";
          newState.loginSuccess = true;
          yield LoginSucces(newState);
          return;
        } else {
          newState.loginSuccess = false;
          newState.stt = "wrong username or password";
        }
      }
    }
    yield newState;
  }
}
