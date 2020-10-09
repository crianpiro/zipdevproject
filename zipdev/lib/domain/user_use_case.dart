import 'package:zipdev/models/dto/event.dart';
import 'package:zipdev/models/dto/result_model.dart';
import 'package:zipdev/models/entities/pokemon_model.dart';

abstract class UserRepository {
  Future<Result<Event<Map<String,dynamic>>>> getPokemons();
  Future<Result<Event<PokemonModel>>> getPokemonData(String pokemon, String url);
}

abstract class UserUseCase {
  Future<Result<Event<Map<String,dynamic>>>> getPokemons();
  Future<Result<Event<PokemonModel>>> getPokemonData(String pokemon, String url);
}

class UserUseCaseImpl implements UserUseCase {

  final UserRepository _userRepository;

  UserUseCaseImpl(this._userRepository);

  @override
  Future<Result<Event<Map<String,dynamic>>>> getPokemons() {
    return _userRepository.getPokemons();
  }

  Future<Result<Event<PokemonModel>>> getPokemonData(String pokemon, String url) {
    return _userRepository.getPokemonData(pokemon,url);
  }
  
  
}