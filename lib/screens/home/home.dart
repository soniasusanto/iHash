import 'package:ihash/index.dart';
import 'package:ihash/services/auth.dart';
import 'package:ihash/tfmodel.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'iHash',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.blueGrey[200],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
              icon: Icon(Icons.account_circle),
              label: Text('logout'),
              onPressed: () async {
                await _auth.logout();
              })
        ],
      ),
      body: Container(
        child: Model(),
      ),
    );
  }
}
