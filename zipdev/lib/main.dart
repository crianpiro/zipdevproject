import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'app/context/settings/app_settings.dart';
import 'app/context/settings/application.dart';
import 'app/context/settings/preferences.dart';
import 'app/context/zipdev.dart';

void main() {

  Application().appSettings = AppSettings();
  
  runZoned<Future<void>>(()async {
    WidgetsFlutterBinding.ensureInitialized();
    final prefs = new Preferences();
    await prefs.initPrefs();
    await Firebase.initializeApp();
    runApp(ZipDev());
  },
  );
}
