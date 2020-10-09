import 'package:zipdev/domain/user_use_case.dart';
import 'package:zipdev/models/dto/event.dart';
import 'package:zipdev/models/dto/result_model.dart';
import 'package:zipdev/models/entities/pokemon_model.dart';

abstract class UserDataSource {
  Future<Result<Event<Map<String,dynamic>>>> getPokemons();
  Future<Result<Event<PokemonModel>>> getPokemonData(String pokemon, String url);
}

class UserRepositoryImpl implements UserRepository {

  final UserDataSource _userDataSource;

  UserRepositoryImpl(this._userDataSource);

  @override
  Future<Result<Event<Map<String,dynamic>>>> getPokemons() {
    return _userDataSource.getPokemons();
  }

  @override
  Future<Result<Event<PokemonModel>>> getPokemonData(String pokemon,String url){
    return _userDataSource.getPokemonData(pokemon,url);
  }
  
  
}