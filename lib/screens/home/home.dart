import 'package:ihash/index.dart';

import 'package:ihash/screens/home/favorites.dart';
import 'package:ihash/services/auth.dart';
import 'package:ihash/tfmodel.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    Model(),
    Favorite(),
  ];
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          'iHash',
          style: TextStyle(
            color: Colors.black,
            fontSize: 30.0,
            fontWeight: FontWeight.w900,
          ),
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
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          backgroundColor: Colors.blueGrey[100],
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: Colors.black,
                  size: 30.0,
                ),
                title: Text(
                  'Home',
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                )),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite, color: Colors.black, size: 30.0),
              title: Text(
                'Favorites',
                style: TextStyle(color: Colors.black, fontSize: 16.0),
              ),
            ),
          ]),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
