import 'package:ihash/index.dart';
import 'package:ihash/models/user.dart';
import 'package:ihash/screens/wrapper.dart';
import 'package:ihash/services/auth.dart';

void main() => runApp(
      MyApp(),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
        value: AuthService().user,
        child: MaterialApp(
          home: Wrapper(),
        ));
  }
}
