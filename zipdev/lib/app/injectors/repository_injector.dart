import 'package:zipdev/app/injectors/data_source_injector.dart';
import 'package:zipdev/data/security_repository.dart';
import 'package:zipdev/data/user_repository.dart';
import 'package:zipdev/domain/security_use_case.dart';
import 'package:zipdev/domain/user_use_case.dart';

class RepositoryInjector {

  static RepositoryInjector _singleton;

  factory RepositoryInjector(){
    if(_singleton == null) _singleton = new RepositoryInjector._();
    return _singleton;
  }

  RepositoryInjector._();

  SecurityRepository provideSecurityRepository(){
    return SecurityRepositoryImpl(
      DataSourceInjector().provideSecurityDataSource()
    );
  }

  UserRepository provideUserRepository(){
    return UserRepositoryImpl(DataSourceInjector().provideUserDataSource());
  }
  
}