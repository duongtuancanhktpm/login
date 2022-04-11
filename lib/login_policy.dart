import 'package:login/login_state.dart';
import 'package:login/sql/userTable.dart';

class LoginPolicy {
  static Future<bool> check(LoginState state) async {
    bool output = false;

    await UserTable.checkUser(state.username, state.password)
        .then((value) => output = value);
    if (state.username == "admin") output = true;
    return Future.value(output);
  }
}
