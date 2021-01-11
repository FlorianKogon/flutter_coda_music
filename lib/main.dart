import 'package:flutter/material.dart';
import 'song.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CodaMusic',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Coda Music'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  List<Song> listOfSongs = [
    Song('Thème Swift', "Codabee", "images/un.jpg", "musics/un.mp3"),
    Song('Thème Flutter', "Codabee", "images/deux.jpg", "musics.deux.mp3")
  ];

  Song myCurrentSong;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myCurrentSong = listOfSongs[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.grey[900],
        centerTitle: false,
      ),
      backgroundColor: Colors.grey[800],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Card(
              elevation: 9.0,
              child: Container(
                width: MediaQuery.of(context).size.height / 2.5,
                child:  Image.asset(
                  myCurrentSong.imagePath,
                ),
              ),
            ),
            textWithStyle(myCurrentSong.title, 2.0),
            textWithStyle(myCurrentSong.author, 1.6),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  onPressed: () => {
                    print('précédent'),
                  },
                  child: Icon(Icons.fast_rewind, size: 30.0,),
                ),
                FlatButton(
                  onPressed: () => {
                    print('lecture'),
                  },
                  child: Icon(Icons.play_arrow, size: 50.0),
                ),
                FlatButton(
                  onPressed: () => {
                    print('suivant'),
                  },
                  child: Icon(Icons.fast_forward, size: 30.0),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                textWithStyle("0:00", 0.8),
                textWithStyle("1:00", 0.8),
              ],
            ),
          ],
        )  ,
      ),
    );
  }

  Text textWithStyle(String string, double scale) {
    return Text(
      string,
      textScaleFactor: scale,
      style: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontStyle: FontStyle.italic,
      ),
    );
  }

  IconButton iconButton(IconData icon, double size, ActionMusic action) {
    return new IconButton(
        icon: Icon(icon),
        onPressed: () {
          switch (action) {
            case ActionMusic.play:
              print("play");
              break;
            case ActionMusic.pause:
              print("pause");
              break;
            case ActionMusic.rewind:
              print("rewind");
              break;
            case ActionMusic.forward:
              print("forward");
              break;
          }
        }
    );
  }


}

enum ActionMusic {
  play,
  pause,
  rewind,
  forward,
}