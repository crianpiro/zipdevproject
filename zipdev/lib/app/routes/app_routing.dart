import 'package:flutter/material.dart';
import 'package:zipdev/app/ui/screens/detail_screen.dart';
import 'package:zipdev/app/ui/screens/home_screen.dart';
import 'package:zipdev/app/ui/screens/onBoard_screen.dart';
import 'package:zipdev/app/ui/screens/signIn_screen.dart';
import 'package:zipdev/app/ui/screens/splash_screen.dart';

class AppRouting {

   Map<String, WidgetBuilder> getApplicationRoutes(){
    return {
      SplashScreen.route: (BuildContext context) => SplashScreen(),
      OnBoardScreen.route: (BuildContext context) => OnBoardScreen(),
      SignInScreen.route: (BuildContext context) => SignInScreen(),
      HomeScreen.route: (BuildContext context) => HomeScreen(),
      DetailScreen.route: (BuildContext context) => DetailScreen(),
    };
  }
  
}