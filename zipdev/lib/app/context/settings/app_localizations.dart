import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale)=>['en','es'].contains(locale.languageCode);
  
  @override
  Future<AppLocalizations> load(Locale locale) {

    Intl.defaultLocale = locale.languageCode;
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
     
  }
      
  @override
  bool shouldReload(AppLocalizationsDelegate old)=>false;
}
    
class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  static AppLocalizations of (BuildContext context){
    return Localizations.of<AppLocalizations>(context,AppLocalizations);
  }

  static Map<String,Map<String,String>> _localizedValues = {
    'en':{
      'fora': 'Multi-language support',
    },
    'es':{
      'fora': 'Multi-language support',
    },
  };

  String getText(String key){
    var text = _localizedValues.containsKey(locale.languageCode)
    ? _localizedValues['es'][key]
    // ? _localizedValues[locale.languageCode][key]
    : _localizedValues['es'][key];

    return text != null ? text : 'default';
  }

  String get fora{
    return getText('fora');
  }

}