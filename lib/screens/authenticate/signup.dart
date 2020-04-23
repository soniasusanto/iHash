import 'package:ihash/index.dart';
import 'package:ihash/services/auth.dart';
import 'package:ihash/constants/constants.dart';

class Signup extends StatefulWidget {
  final Function toggleView;
  Signup({this.toggleView});
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  //text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
          backgroundColor: Colors.blueGrey[200],
          elevation: 0.0,
          title: Text('iHash', style: TextStyle(color: Colors.black)),
          actions: <Widget>[
            FlatButton.icon(
                icon: Icon(Icons.account_circle),
                label: Text('Login'),
                onPressed: () {
                  widget.toggleView();
                })
          ]),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 200.0),
              TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Email'),
                  validator: (val) =>
                      val.isEmpty ? 'Enter a valid email' : null,
                  onChanged: (val) {
                    setState(() => email = val);
                  }),
              SizedBox(height: 20.0),
              TextFormField(
                  decoration:
                      textInputDecoration.copyWith(hintText: 'Password'),
                  obscureText: true,
                  validator: (val) => val.length < 8
                      ? 'Password has to be a minimum of 8 characters.'
                      : null,
                  onChanged: (val) {
                    setState(() => password = val);
                  }),
              SizedBox(height: 20.0),
              RaisedButton(
                  color: Colors.grey,
                  child: Text(
                    'Signup',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      dynamic result = await _auth.signupWithEmailAndPassword(
                          email, password);
                      if (result == null) {
                        setState(() => error = 'User already exists!');
                      }
                    }
                  }),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
