import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nanashi_schedule/screens/home_screen.dart';


void main(){
  WidgetsFlutterBinding.ensureInitialized();
  //向き指定
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(new HomeApp());
  });
}

class HomeApp extends StatelessWidget{
  //
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: '774inc. schedule【非公式】',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Common.primaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}

class Common {
  static const int _primaryValue = 0xFF607D8B;
  static const MaterialColor primaryColor = MaterialColor(
    _primaryValue,
    <int, Color>{
      50: Color(0xFF607D8B),
      100: Color(0xFF607D8B),
      200: Color(0xFF607D8B),
      300: Color(0xFF607D8B),
      400: Color(0xFF607D8B),
      500: Color(0xFF607D8B),
      600: Color(0xFF607D8B),
      700: Color(0xFF607D8B),
      800: Color(0xFF607D8B),
      900: Color(_primaryValue),
    },
  );
}