import 'package:ihash/index.dart';
import 'package:ihash/models/user.dart';
import 'package:ihash/screens/authenticate/authenticate.dart';
import 'package:ihash/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
//return either Home or Authenticate Widget based on loggedin state
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
