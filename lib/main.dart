import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

import './widgets/colors.dart';
import 'game.dart';
import 'credits.dart';
import './widgets/expandedbox.dart';

void main() => runApp(MyApp());

class _ThemeManager{
  int _savedTheme = 0;
  int _selectedTheme = 0;

  SharedPreferences prefs;

  void getPrefs()async{
    prefs = await SharedPreferences.getInstance();
    var saved = prefs.getInt('theme');
    _savedTheme = saved;
    updateTheme(_savedTheme);
  }

  StreamController themeController = StreamController<int>();
  Stream<int> get selectedUpdate => themeController.stream;

  void updateTheme(int newTheme){
    _selectedTheme = newTheme;
    themeController.add(_selectedTheme);
    prefs.setInt('theme', newTheme);
  }
}

var themeManager = _ThemeManager();


class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp>{

  @override
  void initState() {
    super.initState();
    themeManager.getPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: themeManager.selectedUpdate,
      initialData: 0,
      builder: (context, snapShot){
        return MaterialApp(
          routes: <String, WidgetBuilder>{
            '/game': (BuildContext context) => new MyGame(),
            '/credits': (BuildContext context) => new Credits()
          },
          home: SplashScreen(),
          theme: buildTicTheme(snapShot),
        );
      },
    );
  }

  ThemeData buildTicTheme(dynamic theme) {
    final ThemeData base = ThemeData.light();
    var theme = selectTheme(themeManager._selectedTheme);
    return base.copyWith(
      primaryColor: theme.primary,
      accentColor: theme.accent,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: theme.fbColor,
        foregroundColor: theme.ffColor
      ),
      buttonColor: theme.ffColor,
      textTheme: base.textTheme.copyWith(
        title: TextStyle(
          color: theme.primary,
          fontWeight: FontWeight.bold,
          fontSize: 60,
        ),
        subtitle: TextStyle(
          fontWeight: FontWeight.bold,
          color: theme.stColor,
          fontSize: 50
        ),
        display1: TextStyle(
          fontSize: 25,
          color: theme.accent
        )
      ),
      scaffoldBackgroundColor: theme.backgroud,
    );
  }
}

class SplashScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen>{
  AssetsAudioPlayer assetsAudioPlayer;
  @override
  void initState() {
    super.initState();
    assetsAudioPlayer = AssetsAudioPlayer();
    assetsAudioPlayer.open(
      AssetsAudio(
        asset: "audio.mp3",
        folder: "assets/audios/",
      ),
    );
    print('da');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset('assets/board.png'),
      ),
    );
  }
}

class MainMenu extends StatefulWidget {
  @override
  State<MainMenu> createState() {
    return _MainMenuState();
  }
}

class _MainMenuState extends State<MainMenu>{
  bool isMenuTime = true;

  void showThemeMenu(){
    isMenuTime = false;
    setState(() {
      
    });
  }

  void hideThemeMenu(){
    isMenuTime = true;
    setState(() {
      
    });
  }

  Widget _normalMenu(BuildContext context){
    return Flex(
      direction: Axis.vertical,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        ExpandedBox(20),
        Expanded(
          child: Text(
            'Tic Tac Toe',
            style: Theme.of(context).textTheme.title,
          ),
          flex: 20,
        ),
        ExpandedBox(5),
        Expanded(
          child: FloatingActionButton(
            // elevation: 50,
            child: Icon(
              Icons.play_arrow, 
              size: 50,
            ),
            foregroundColor: Theme.of(context).accentColor,
            backgroundColor: Theme.of(context).floatingActionButtonTheme.foregroundColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0))),
            heroTag: 'play',
            onPressed: () {
              Navigator.pushNamed(context, '/game');
            },
          ),
          flex: 15,
        ),
        ExpandedBox(10),
        Flex(
          direction: Axis.horizontal,
          children: <Widget>[
            ExpandedBox(5),
              Expanded(
              child: FloatingActionButton(
                elevation: 100,
                child: Icon(Icons.menu),
                // heroTag: 'info',
                onPressed: showThemeMenu,
              ),
              flex: 15,
            ),
            Expanded(
              child: FloatingActionButton(
                elevation: 100,
                child: Icon(Icons.info),
                heroTag: 'info',
                onPressed: () {
                  Navigator.pushNamed(context, '/credits');
                },
              ),
              flex: 15,
            ),
            ExpandedBox(5),
          ],
        ),
        ExpandedBox(5)
      ],
    );
  }

  Widget _themeMenu(){
    var minwidth = MediaQuery.of(context).size.width/1.1;
    var minHeight = MediaQuery.of(context).size.height/1.2;
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: minwidth,
        height: minHeight,
        child: Card(
          color: Theme.of(context).buttonColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: minwidth/10,
                    height: minHeight/10,
                    child: FloatingActionButton(
                      child: Icon(
                        Icons.close
                      ),
                      onPressed: (){
                        themeManager.updateTheme(themeManager._savedTheme);
                        hideThemeMenu();
                      },
                    ),
                  ),
                  SizedBox(
                    width: minwidth/50,
                  )
                ],
              ),
              Text(
                'Themes',
                style: Theme.of(context).textTheme.subtitle.copyWith(
                  fontSize: 45
                ),
              ),
              Container(
                height: minHeight/1.8,
                child: ListView.builder(
                  itemBuilder: (context, item){
                    return themeButton(item);
                  },
                  itemCount: numberOfThemes,
                ),
              ),
              Container(
                width: minwidth/8,
                height: minHeight/8,
                child: FloatingActionButton(
                  child: Icon(
                    Icons.check
                  ),
                  onPressed: (){
                    themeManager._savedTheme = themeManager._selectedTheme;
                    hideThemeMenu();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget themeButton(int themeColors){
    var theme = selectTheme(themeColors);
    return Container(
      height: MediaQuery.of(context).size.height/1.2/6,
      child: Card(
        color: theme.backgroud,
        child: InkWell(
          onTap: (){
            themeManager.updateTheme(themeColors);
            setState(() {
              
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                'Tic Tac Toe',
                style: TextStyle(
                  color: theme.stColor
                ),
              ),
              Card(
                color: theme.ffColor,
                child: Icon(null),
              ),
              Icon(
                Icons.brightness_7,
                color: theme.accent,
              ),
              Icon(
                Icons.brightness_3,
                color: theme.accent,
              )
            ],
          ),
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isMenuTime? 
      _normalMenu(context): 
      _themeMenu()
    );
  }
}


