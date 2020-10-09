import 'package:zipdev/app/injectors/repository_injector.dart';
import 'package:zipdev/domain/security_use_case.dart';
import 'package:zipdev/domain/user_use_case.dart';

class Injector {

  static Injector _singleton;

  factory Injector(){
    if(_singleton == null) _singleton = new Injector._();
    return _singleton;
  }

  Injector._();

  SecurityUseCase provideSecurityUseCase(){
    return SecurityUseCaseImpl(RepositoryInjector().provideSecurityRepository());
  }

  UserUseCase provideUserUseCase(){
    return UserUseCaseImpl(RepositoryInjector().provideUserRepository());
  }

}