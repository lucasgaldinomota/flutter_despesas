import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/categories_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Color(0xFF303030),
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vamos Cozinhar?',
      theme: ThemeData(
        brightness: Brightness.dark,
        accentColor: Colors.white,
        primarySwatch: Colors.blue,
      ),
      home: CategoriesScreen(),
    );
  }
}
