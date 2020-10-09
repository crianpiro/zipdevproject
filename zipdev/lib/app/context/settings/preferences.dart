import 'package:shared_preferences/shared_preferences.dart';

/*
  Recordar instalar el paquete de:
    shared_preferences:
  Inicializar en el main
  WidgetsFlutterBinding.ensureInitialized();
    final prefs = new Preferences();
    await prefs.initPrefs();
    
    Recuerden que el main() debe de ser async {...
*/

class Preferences {

  static final Preferences _instance = new Preferences._internal();

  factory Preferences() {
    return _instance;
  }

  Preferences._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  get userInfo {
    return _prefs.getString('userInfo') ?? null;
  }

  set userInfo( String value ) {
    _prefs.setString('userInfo', value);
  }

}
