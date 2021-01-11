import 'dart:async';
import 'package:flutter/material.dart';
import 'song.dart';
import 'package:audioplayer/audioplayer.dart';

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
    Song('Thème Swift', "Codabee", "images/un.jpg", "https://codabee.com/wp-content/uploads/2018/06/un.mp3"),
    Song('Thème Flutter', "Codabee", "images/deux.jpg", "https://codabee.com/wp-content/uploads/2018/06/deux.mp3")
  ];

  Song myCurrentSong;
  StreamSubscription positionSub;
  StreamSubscription stateSub;
  Duration position = Duration(seconds: 0);
  Duration duration = Duration(seconds: 10);
  AudioPlayer audioPlayer;
  PlayerState statut = PlayerState.stopped;
  int index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myCurrentSong = listOfSongs[index];
    configurationAudioPlayer();
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
                iconButton(Icons.fast_rewind, 30.0, ActionMusic.rewind),
                statut == PlayerState.playing ? iconButton(Icons.pause, 50.0, ActionMusic.pause) : iconButton(Icons.play_arrow, 50.0, ActionMusic.play),
                iconButton(Icons.fast_forward, 30.0, ActionMusic.forward),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                textWithStyle(fromDuration(position), 0.8),
                textWithStyle(fromDuration(duration), 0.8),
              ],
            ),
            Slider(
                value: position.inSeconds.toDouble(),
                min: 0.0,
                max: 22.0,
                activeColor: Colors.red,
                inactiveColor: Colors.white,
                onChanged: (double d) {
                  setState(() {
                    audioPlayer.seek(d);
                  });
                },
            ),
          ],
        ),
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
        iconSize: size,
        onPressed: () {
          switch (action) {
            case ActionMusic.play:
              play();
              print(myCurrentSong.urlSong);
              break;
            case ActionMusic.pause:
              pause();
              break;
            case ActionMusic.rewind:
              rewind();
              break;
            case ActionMusic.forward:
              forward();
              break;
          }
        }
    );
  }

  void configurationAudioPlayer() {
    audioPlayer = new AudioPlayer();
    positionSub = audioPlayer.onAudioPositionChanged.listen(
      (pos) => setState(() => position = pos)
    );
    stateSub = audioPlayer.onPlayerStateChanged.listen((state) {
      if (state == AudioPlayerState.PLAYING) {
        setState(() {
          duration = audioPlayer.duration;
        });
      }
      else if (state == AudioPlayerState.STOPPED) {
        setState(() {
          statut = PlayerState.stopped;
        });
      }
    }, onError: (msg) {
      print("erreur: $msg");
      setState(() {
        statut = PlayerState.stopped;
        duration = Duration(seconds: 0);
        position = Duration(seconds: 0);
      });
      }
    );
  }

  Future play() async {
    await audioPlayer.play(myCurrentSong.urlSong);
    setState(() {
      statut = PlayerState.playing;
    });
  }

  Future pause() async {
    await audioPlayer.pause();
    setState(() {
      statut = PlayerState.paused;
    });
  }

  void forward() {
    if (index == listOfSongs.length - 1) {
      index = 0;
    } else {
      index++;
    }
    myCurrentSong = listOfSongs[index];
    configurationAudioPlayer();
    play();
  }

  void rewind() {
    if (position > Duration(seconds: 3)) {
      audioPlayer.seek(0.0);
    } else {
      if (index == 0) {
        index = listOfSongs.length - 1;
      } else {
        index--;
      }
    }
    myCurrentSong = listOfSongs[index];
    configurationAudioPlayer();
    play();
  }

  String fromDuration(Duration durationOfSong) {
    return durationOfSong.toString().split('.').first;
  }
}

enum ActionMusic {
  play,
  pause,
  rewind,
  forward,
}

enum PlayerState {
  playing,
  stopped,
  paused,
}