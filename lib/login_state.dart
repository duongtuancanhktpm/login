class LoginState {
  String username;
  String password;
  String stt;
  bool loginSuccess = false;

  LoginState(
      {required this.username, required this.password, required this.stt});

  @override
  LoginState coppy() =>
      LoginState(username: username, password: password, stt: stt);
}
