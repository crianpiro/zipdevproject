import 'package:zipdev/data/security_repository.dart';
import 'package:zipdev/data/user_repository.dart';
import 'package:zipdev/data_source/security_data_source.dart';
import 'package:zipdev/data_source/user_data_source.dart';

class DataSourceInjector {

  static DataSourceInjector _singleton;

  factory DataSourceInjector(){
    if(_singleton==null)_singleton= new DataSourceInjector._();
    return _singleton;
  }

  DataSourceInjector._();

  SecurityDataSource provideSecurityDataSource(){
    return SecurityDataSourceImpl("");
  }

  UserDataSource provideUserDataSource(){
    return UserDataSourceImpl("https://pokeapi.co/api/v2/");
  }
  
}