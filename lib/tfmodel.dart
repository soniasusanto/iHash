import 'package:ihash/index.dart';
import 'package:clipboard_manager/clipboard_manager.dart';

class Model extends StatefulWidget {
  @override
  _TfModel createState() => _TfModel();
}

class _TfModel extends State<Model> {
  List _outputs;
  File _image;
  bool _loading = false;

  FirebaseUser user;
  FirebaseAuth _auth;

  final db = Firestore.instance;

  @override
  void initState() {
    super.initState();
    _loading = true;
    _auth = FirebaseAuth.instance;

    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading
          ? Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(backgroundColor: Colors.blue),
            )
          : Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _image == null
                      ? Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 40.0),
                          child: Column(
                            children: <Widget>[
                              Text('Welcome to iHash!',
                                  style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 30.0,
                                      backgroundColor: Colors.grey[100])),
                              SizedBox(height: 40.0),
                              Text('Upload an image to begin!',
                                  style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 30.0,
                                      backgroundColor: Colors.grey[100]))
                            ],
                          ))
                      : Image.file(
                          _image,
                          height: 400.0,
                          width: 400.0,
                          alignment: Alignment.center,
                          fit: BoxFit.fitWidth,
                        ),
                  SizedBox(
                    height: 20,
                  ),
                  _outputs != null
                      ? Container(
                          child: Flexible(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "${_outputs.join(', ')}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 20.0,
                                    background: Paint()..color = Colors.white,
                                  ),
                                ),
                                SizedBox(height: 20.0),
                                Builder(
                                  builder: (context) => IconButton(
                                    alignment: Alignment.topRight,
                                    icon: Icon(Icons.content_copy),
                                    onPressed: () async {
                                      dynamic result = await ClipboardManager
                                          .copyToClipBoard(
                                              '${_outputs.join(', ')}');
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
                                              await ClipboardManager
                                                  .copyToClipBoard('');
                                            },
                                          ),
                                        );
                                        Scaffold.of(context)
                                            .showSnackBar(snackBar);
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(height: 12.0),
                                Builder(
                                    builder: (context) => RaisedButton(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 30.0),
                                          color: Colors.grey,
                                          child: Text(
                                            'Save to favorites',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18.0),
                                          ),
                                          onPressed: () async {
                                            user = await _auth.currentUser();
                                            String uid = user.uid;
                                            DocumentReference result = await db
                                                .collection('Hashtags')
                                                .add({
                                              'userId': '$uid',
                                              'hashtags':
                                                  '${_outputs.join(', ')}'
                                            });
                                            if (result != null) {
                                              final snackBar = SnackBar(
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                backgroundColor:
                                                    Colors.blueGrey,
                                                content:
                                                    Text('Saved to favorites!',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20.0,
                                                        )),
                                                action: SnackBarAction(
                                                  textColor: Colors.white,
                                                  label: 'Undo',
                                                  onPressed: () async {
                                                    await ClipboardManager
                                                        .copyToClipBoard('');
                                                  },
                                                ),
                                              );
                                              Scaffold.of(context)
                                                  .showSnackBar(snackBar);
                                            }
                                          },
                                        ))
                              ],
                            ),
                          ),
                        )
                      : Container()
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: pickImage,
        backgroundColor: Colors.black,
        child: Icon(Icons.image, color: Colors.grey),
      ),
    );
  }

  pickImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;
    setState(() {
      _loading = true;
      _image = image;
    });
    classifyImage(image);
  }

  classifyImage(File image) async {
    List output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );

    String _label = output[0]["label"];
    List _hashtagsResult = _hashtags["$_label"];
    setState(() {
      _loading = false;

      _outputs = _hashtagsResult;
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
    );
  }

  var _hashtags = {
    'Beauty': [
      '#beautylovers',
      '#intothegloss',
      '#makeuplovers',
      '#makeupflatlay',
      '#motd',
      '#makeupoftheday',
      '#makeuplife',
      '#igmakeup',
      '#instabeauty',
      '#beautyblogger'
    ],
    'Travel': [
      '#travelblogger',
      '#travellife',
      '#wanderlust',
      '#traveltheworld',
      '#igtravel',
      '#travelgram',
      '#instago',
      '#mytravelgram',
      '#worldcaptures',
      '#instavacation',
      '#vacaylife'
    ],
    'Food': [
      '#foodies',
      '#foodlovers',
      '#igfood',
      '#foodiesofinstagram',
      '#igfoodies',
      '#foodphotography',
      '#foodiesunite',
      '#foodislife'
    ],
    'Dogs': [
      '#dogsofinstagram',
      '#igdogs',
      '#doglover',
      '#instadog',
      '#petstagram',
      '#doggos',
      '#dogparent',
      '#dogs'
    ]
  };

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }
}
