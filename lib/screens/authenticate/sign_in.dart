import 'package:ihash/index.dart';
import 'package:ihash/services/auth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
            backgroundColor: Colors.black,
            elevation: 0.0,
            title: Text('Sign in to iHash')),
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: RaisedButton(
              child: Text('Sign in Anonymously'),
              onPressed: () async {
                dynamic result = await _auth.signInAnon();
                if (result == null) {
                  print('error signing in');
                } else {
                  print('signed in');
                  print(result.uid);
                }
              },
            )));
  }
}
