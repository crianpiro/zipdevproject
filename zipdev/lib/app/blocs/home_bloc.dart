import 'package:rxdart/rxdart.dart';
import 'package:zipdev/domain/user_use_case.dart';
import 'package:zipdev/models/dto/event.dart';
import 'package:zipdev/models/dto/result_model.dart';

import 'provider/bloc.dart';

class HomeBloc extends Bloc {

  final UserUseCase _userUseCase;

  HomeBloc(this._userUseCase);
  
  @override
  void dispose() {
  }

  Future<Result<Event<Map<String,dynamic>>>> getPokemons(){
    return _userUseCase.getPokemons();
  }

}