
import 'package:zipdev/domain/security_use_case.dart';

import 'provider/bloc.dart';

class SplashBloc extends Bloc {

  final SecurityUseCase _securityUseCase;

  SplashBloc(this._securityUseCase);

  @override
  void dispose() {}
  

  // Future<Result<Event<List<SelectItemsModel>>>> getDeparments(){
  //   return _securityUseCase.getDepartments();
  // }

  // Future<Result<Event<List<SelectItemsModel>>>> getSectors(){
  //   return _securityUseCase.getSectors();
  // }
}