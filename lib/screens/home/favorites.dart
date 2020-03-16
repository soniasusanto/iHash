import 'package:ihash/index.dart';
import 'package:clipboard_manager/clipboard_manager.dart';

class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  final db = Firestore.instance;
  FirebaseUser user;
  FirebaseAuth _auth;
  dynamic getUser() async {
    user = await _auth.currentUser();
    String uid = user.uid;
    return uid;
  }

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    getUser();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
          padding: const EdgeInsets.all(10.0),
          child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('Hashtags').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return new Text('No hashtag favorites.');
                }
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return new Text('Loading...');

                  default:
                    return Column(
                      children: <Widget>[
                        Text(
                          'Favorite Hashtags',
                          style: TextStyle(
                            fontSize: 30.0,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          '${snapshot.data.documents[0]['hashtags']}',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Builder(
                          builder: (context) => IconButton(
                            alignment: Alignment.topRight,
                            icon: Icon(Icons.content_copy),
                            onPressed: () async {
                              dynamic result =
                                  await ClipboardManager.copyToClipBoard(
                                      '${snapshot.data.documents[0]['hashtags']}');
                              if (result) {
                                final snackBar = SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.blueGrey,
                                  content: Text('Copied to Clipboard!',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                      )),
                                  action: SnackBarAction(
                                    textColor: Colors.white,
                                    label: 'Undo',
                                    onPressed: () async {
                                      await ClipboardManager.copyToClipBoard(
                                          '');
                                    },
                                  ),
                                );
                                Scaffold.of(context).showSnackBar(snackBar);
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          '${snapshot.data.documents[1]['hashtags']}',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Builder(
                          builder: (context) => IconButton(
                            alignment: Alignment.topRight,
                            icon: Icon(Icons.content_copy),
                            onPressed: () async {
                              dynamic result =
                                  await ClipboardManager.copyToClipBoard(
                                      '${snapshot.data.documents[1]['hashtags']}');
                              if (result) {
                                final snackBar = SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.blueGrey,
                                  content: Text('Copied to Clipboard!',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                      )),
                                  action: SnackBarAction(
                                    textColor: Colors.white,
                                    label: 'Undo',
                                    onPressed: () async {
                                      await ClipboardManager.copyToClipBoard(
                                          '');
                                    },
                                  ),
                                );
                                Scaffold.of(context).showSnackBar(snackBar);
                              }
                            },
                          ),
                        ),
                      ],
                    );
                }
              })),
    ));
  }
}
