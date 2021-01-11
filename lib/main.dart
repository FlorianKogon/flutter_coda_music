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
            Image.asset(
              "images/un.jpg",
              width: MediaQuery.of(context).size.width / 1.2,
            ),
            Text("song.title"),
            Text("song.author"),
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
                Text("durée totale"),
                Text("durée restante")
              ],
            ),
          ],
        )  ,
      ),
    );
  }
}
