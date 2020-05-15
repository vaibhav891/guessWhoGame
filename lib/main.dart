import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guess_who_game/characters.dart';
import 'package:guess_who_game/questions.dart';

void main() {
  runApp(MyApp());
  //runApp(MaterialApp(home: RadialExpansionDemo()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Guess Who Game!'),
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
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Container(
        //color: Colors.black,
        child: GridView.count(
            //padding: EdgeInsets.all(2.0),
            scrollDirection: Axis.vertical,
            crossAxisCount: 3,
            children: origCharacters
                .map((e) => Hero(
                      tag: e['name'],
                      child: SingleImageLayout(
                          imageUri: 'assets/images/' + e['imageFile']),
                    ))
                .toList()),
      ),
    );
  }
}

class SingleImageLayout extends StatefulWidget {
  final String imageUri;
  const SingleImageLayout({
    Key key,
    this.imageUri,
  }) : super(key: key);

  @override
  _SingleImageLayoutState createState() => _SingleImageLayoutState();
}

class _SingleImageLayoutState extends State<SingleImageLayout> {
  @override
  void initState() {
    //  implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            opaque: false,
            pageBuilder: (context, _, __) {
              return GameStartScreen(
                imageUri: widget.imageUri,
              );
            },
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(blurRadius: 0, color: Colors.orange, spreadRadius: 0)
          ],
          // border: Border.all(
          //   color: Colors.blue,
          //   width: 1.0,
          // ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          child: Image.asset(
            widget.imageUri,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class GameStartScreen extends StatelessWidget {
  final String imageUri;

  GameStartScreen({
    Key key,
    this.imageUri,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    characters= List<Map<String, Object>>.from(origCharacters);

    return Hero(
        tag: imageUri,
        child: Scaffold(
          backgroundColor: Color(0xc0fffde7),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                flex: 4,
                child: Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(75.0),
                          child: Image.asset(imageUri)),
                    ),
                  ),
                ),
              ),
              Flexible(flex: 2, child: QuestionWidget())
            ],
          ),
        ));
  }
}
