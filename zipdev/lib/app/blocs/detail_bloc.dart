import 'package:zipdev/domain/user_use_case.dart';
import 'package:zipdev/models/dto/event.dart';
import 'package:zipdev/models/dto/result_model.dart';
import 'package:zipdev/models/entities/pokemon_model.dart';

import 'provider/bloc.dart';

class DetailBloc extends Bloc {

  final UserUseCase _userUseCase;

  DetailBloc(this._userUseCase);
  
  @override
  void dispose() {
  }

  Future<Result<Event<PokemonModel>>> getPokemonData(String pokemon,String url){
    return _userUseCase.getPokemonData(pokemon,url);
  }

}