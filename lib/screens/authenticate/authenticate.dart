import 'package:ihash/index.dart';
import 'package:ihash/screens/authenticate/login.dart';
import 'package:ihash/screens/authenticate/signup.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showLogin = true;
  void toggleView() {
    setState(() => showLogin = !showLogin);
  }

  @override
  Widget build(BuildContext context) {
    return showLogin
        ? Login(toggleView: toggleView)
        : Signup(toggleView: toggleView);
  }
}
