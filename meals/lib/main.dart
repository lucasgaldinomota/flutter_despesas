import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/categories_screen.dart';
import 'screens/categories_meals_screen.dart';
import 'utils/app_routes.dart';

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
        primarySwatch: Colors.pink,
        accentColor: Colors.black,
        fontFamily: 'Raleway',
        textTheme: ThemeData.dark().textTheme.copyWith(
              title: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
              ),
            ),
      ),
      routes: {
        AppRoutes.HOME: (ctx) => CategoriesScreen(),
        AppRoutes.CATEGORIES_MEALS: (ctx) => CategoriesMealsScreen(),
      },
    );
  }
}
