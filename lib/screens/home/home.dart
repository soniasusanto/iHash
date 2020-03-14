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
        title: Text('iHash'),
        backgroundColor: Colors.blueGrey[400],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('logout'),
              onPressed: () async {
                await _auth.signOut();
              })
        ],
      ),
      body: Container(
        child: Model(),
      ),
    );
  }
}
