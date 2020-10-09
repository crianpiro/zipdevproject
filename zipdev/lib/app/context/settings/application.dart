import 'package:zipdev/models/entities/user_model.dart';

import 'app_settings.dart';

class Application {

  static Application _singleton;
  UserModel user;
  
  AppSettings appSettings;

  factory Application(){
    if(_singleton == null) _singleton = new Application._();
    return _singleton;
  }
  
  Application._();
}