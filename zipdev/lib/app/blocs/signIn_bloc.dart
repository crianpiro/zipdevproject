import 'package:rxdart/rxdart.dart';
import 'package:zipdev/domain/security_use_case.dart';
import 'package:zipdev/models/dto/event.dart';
import 'package:zipdev/models/dto/result_model.dart';
import 'package:zipdev/models/entities/user_model.dart';

import 'provider/bloc.dart';

class SignInBloc extends Bloc {

  ValueStream<bool> signUp;
  ValueStream<bool> loading;
  final _signUpSubject = BehaviorSubject<bool>();
  final _loadingSubject = BehaviorSubject<bool>();
  final SecurityUseCase _securityUseCase;

  ValueStream<bool> get signView => _signUpSubject.stream;
  ValueStream<bool> get loader => _loadingSubject.stream;

  SignInBloc(this._securityUseCase);
  
  @override
  void dispose() {
    _signUpSubject.close();
    _loadingSubject.close();
  }
  void setLoadding(){
    _loadingSubject.add(true);
  }
  
  void setLoaded(){
    _loadingSubject.add(false);
  }

  void changeToSignUp(){
    _signUpSubject.add(true);
  }

  void changeToSignIn(){
    _signUpSubject.add(false);
  }

  Future<Result<Event<UserModel>>> sigIn(String username, String password){
    return _securityUseCase.sigIn(username,password);
  }

  Future<Result<Event<UserModel>>> sigUp(UserModel user, String password){
    return _securityUseCase.signUp(user,password);
  }
  
}