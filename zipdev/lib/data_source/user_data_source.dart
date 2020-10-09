import 'dart:collection';

import 'package:http/http.dart' as http;
import 'package:zipdev/data/user_repository.dart';
import 'package:zipdev/data_source/api_base_source.dart';
import 'package:zipdev/models/dto/event.dart';
import 'package:zipdev/models/dto/payload_event.dart';
import 'package:zipdev/models/dto/result_model.dart';
import 'package:zipdev/models/entities/pokemon_model.dart';

class UserDataSourceImpl extends ApiBaseSource implements UserDataSource {
  UserDataSourceImpl(
    String baseUrl,
    { 
      http.Client client, 
      String token
    }) : super(baseUrl, client ?? http.Client(), token);

  @override
  Future<Result<Event<Map<String,dynamic>>>> getPokemons() async {
    PayloadEvent<Map<String,dynamic>> resp = PayloadEvent({"payLoad": "injected"});

    return get<Event<Map<String,dynamic>>>(
      this.baseUrl+"pokemon/?limit=20&offset=0",(value) {
        value = (value as LinkedHashMap<String, dynamic>);
        resp.response = value;
        var event = Event("200", 200, "Succesfull Transaction", "", resp);
        return event;
      });
  }

  @override
  Future<Result<Event<PokemonModel>>> getPokemonData(String pokemon,String url) async {
    Result<Event<PokemonModel>> _result;
    final String pokemonNumber = url.split('/pokemon/')[1].split('/')[0];
    PayloadEvent<PokemonModel> resp = PayloadEvent({"payLoad": "injected"});
    
    return get<Event<PokemonModel>>(
      this.baseUrl+"/evolution-chain/$pokemonNumber",(value) {
        value = (value as LinkedHashMap<String, dynamic>);
        final PokemonModel _pokeModel = new PokemonModel(
          id: int.parse(pokemonNumber),
          evolution: value,
          img: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/$pokemonNumber.svg",
          name: pokemon
        );

        resp.response = _pokeModel;
        var event = Event("200", 200, "Succesfull Transaction", "", resp);
        return event;
      });
  }
  
}