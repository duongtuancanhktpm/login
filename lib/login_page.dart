import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/login_bloc.dart';
import 'package:login/login_event.dart';
import 'package:login/login_state.dart';

import 'my_home_page.dart';

class LoginPage extends StatelessWidget {
  //String stt = "";
  late LoginBloc _bloc;
  late LoginState _state;
  late BuildContext _context;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    _context = context;
    //throw UnimplementedError();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocProvider<LoginBloc>(
          create: (context) =>
              LoginBloc(new LoginState(username: "", password: "", stt: "")),
          child: _loginView(),
        ));
  }

  Widget _loginView() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      _state = state;
      _bloc = BlocProvider.of(context);
      return SafeArea(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _logo(),
              _usernameField(),
              _passwordField(),
              _stt(),
              _loginBtn(),
              _help(),
            ],
          ),
        ),
      );
    });
  }

  Widget _stt() {
    return Container(
        padding: EdgeInsets.all(20),
        child: Text(
          _state.stt,
          style: TextStyle(color: Colors.red),
        ));
  }

  Widget _help() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "Sign up",
            style: TextStyle(color: Colors.blue),
          ),
          Text(
            "Forgot password?",
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _loginBtn() {
    return Container(
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextButton(
        child: Text("LOGIN"),
        onPressed: () {
          _bloc.add(LoginRequest());
          if (_state.loginSuccess == true) {
            Navigator.push(
                _context,
                MaterialPageRoute(
                    builder: (context) => MyHomePage(title: "Home page")));
          }
        },
      ),
    );
  }

  Widget _passwordField() {
    return Container(
      child: TextField(
        obscureText: true,
        autocorrect: false,
        enableSuggestions: false,
        onChanged: (value) => {_bloc.add(PasswordChangeEvent(password: value))},
        decoration:
            InputDecoration(icon: Icon(Icons.security), hintText: "PASSWORD"),
      ),
    );
  }

  Widget _usernameField() {
    return Container(
      child: TextField(
        onChanged: (value) => {_bloc.add(UsernameChangeEvent(username: value))},
        decoration:
            InputDecoration(icon: Icon(Icons.person), hintText: "USERNAME"),
      ),
    );
  }

  Widget _logo() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          shape: BoxShape.circle, border: Border.all(color: Colors.red)),
      child: FlutterLogo(),
    );
  }
}
