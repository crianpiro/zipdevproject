
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:zipdev/app/context/settings/app_localizations.dart';
import 'package:zipdev/app/routes/app_routing.dart';
import 'package:zipdev/app/ui/screens/splash_screen.dart';

class ZipDev extends StatelessWidget {
  const ZipDev({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale("en"),
        const Locale("es"),
      ],
      debugShowCheckedModeBanner: false,
      // initialRoute: SplashScreen.route,
      home: SplashScreen(),
      routes: AppRouting().getApplicationRoutes(),
      themeMode: ThemeMode.light,
      theme: ThemeData(
        cupertinoOverrideTheme: CupertinoThemeData(
          primaryColor: Colors.white,
          brightness: Brightness.light,
        ),
        brightness: Brightness.light,
        fontFamily: 'Open Sans',
      ),
    );
  }
}