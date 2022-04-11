class LoginEvent {}

class UsernameChangeEvent implements LoginEvent {
  String username;

  UsernameChangeEvent({required this.username}) {}
}

class PasswordChangeEvent implements LoginEvent {
  String password;

  PasswordChangeEvent({required this.password}) {}
}

class LoginRequest implements LoginEvent {}
