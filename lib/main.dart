import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/signIn/signInScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        accentColor: Colors.transparent,
        scaffoldBackgroundColor: Color(0xff18172E),
        appBarTheme: AppBarTheme(
          color: Color(0xff18172E),
        ),
        cardTheme:
            CardTheme(color: Color(0xff1C1C3C), margin: EdgeInsets.all(0)),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color(0xffBCA961),
        ),
        buttonTheme: ButtonThemeData(buttonColor: Color(0xffBCA961)),
      ),
      initialRoute: '/login',
      routes: {'/login': (context) => SignInScreen()},
    );
  }
}
