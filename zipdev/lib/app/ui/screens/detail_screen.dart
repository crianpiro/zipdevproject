import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zipdev/app/blocs/detail_bloc.dart';
import 'package:zipdev/app/injectors/injector.dart';
import 'package:zipdev/app/ui/base_state.dart';
import 'package:zipdev/app/ui/components/varios_components.dart';
import 'package:zipdev/models/dto/event.dart';
import 'package:zipdev/models/dto/result_model.dart';
import 'package:zipdev/models/entities/pokemon_model.dart';

class DetailScreen extends StatefulWidget {
  static final route = "detailScreen";
  DetailScreen({Key key}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends BaseState<DetailScreen, DetailBloc> {
  List<String> detailData;
  TextStyle _textStyleRedBold = GoogleFonts.neucha(
      fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.red[600]);
  TextStyle _textStyleBold = GoogleFonts.neucha(
      fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black);
  TextStyle _textStyleBlack = GoogleFonts.neucha(
      fontSize: 24.0, fontWeight: FontWeight.normal, color: Colors.black);

  @override
  DetailBloc getBlocInstance() {
    return DetailBloc(Injector().provideUserUseCase());
  }

  @override
  Widget build(BuildContext context) {
    if (detailData == null)
      detailData = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          detailData[0],
          style: _textStyleRedBold,
        ),
        leading: IconButton(icon: Icon(Icons.arrow_back_ios_sharp,color: Colors.black,), onPressed: ()=>Navigator.pop(context)),
        actions: [
          IconButton(icon: Icon(Icons.info_outline,color: Colors.red[600],), onPressed: ()=>showAlert("Information", "If you click the url you will go to be redirected out of the application.", context)),
        ],
      ),
      body: Stack(
        children: [_buildPokemonInfo()],
      ),
    );
  }

  Widget _buildPokemonInfo() {
    return FutureBuilder(
      future: bloc.getPokemonData(detailData[0], detailData[1]),
      builder: (BuildContext context,
          AsyncSnapshot<Result<Event<PokemonModel>>> snapshot) {
        if (snapshot.hasData) {
          final Result<Event<PokemonModel>> result = snapshot.data;
          if (result.error != null) {
            return Container(
              child: Center(
                child: Text(result.error.message),
              ),
            );
          } else {
            final PokemonModel pokemonData = result.data.payload.response;

            return SingleChildScrollView(
              child: Column(
                children: [
                  _buildPokeImg(pokemonData.img),
                  _buildPokeInfo(pokemonData),
                  _buildHint("https://pokeapi.co/api/v2/pokemon/${detailData[0]}")
                ],
              ),
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.red[800],
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          );
        }
      },
    );
  }

  Widget _buildPokeInfo(PokemonModel pokemonModel) {
    final dynamic evolutionChain = pokemonModel.evolution["chain"];
    final dynamic specie = evolutionChain["species"];
    final dynamic specieDetail = specie["url"];
    final dynamic evolvesTo = evolutionChain["evolves_to"];
    final dynamic specieEvolved = evolvesTo[0]["species"];

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Column(
        children: [
          _buildDetail("Id: ", "${pokemonModel.id}"),
          _buildDetail("Specie: ", pokemonModel.name),
          _buildDetail("Specie details: ", specieDetail),
          _buildDetail("Evolves to: ", specieEvolved["name"]),
          _buildDetail("Evolution details: ", specieEvolved["url"]),
        ],
      ),
    );
  }

  Widget _buildDetail(String title, String content) {
    return GestureDetector(
      onTap: (content.contains("https:"))?(){
        _launchURL(content);
      }:null,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AutoSizeText(
              title,
              minFontSize: 22.0,
              style: _textStyleBold,
            ),
            Flexible(
              child: AutoSizeText(
                content,
                minFontSize: 22.0,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: _textStyleBlack,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPokeImg(String imageUrl) {
    return Center(
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Container(
          margin: EdgeInsets.all(10.0),
          child: SvgPicture.network(imageUrl),
        ),
      ),
    );
  }

  Widget _buildHint(String url){
    return GestureDetector(
      child: Container(
      margin: EdgeInsets.symmetric(horizontal:15.0,vertical:10.0),
      child: Text("To see all the pokemon details please go to: $url",
      style:  GoogleFonts.neucha(
          fontSize: 23.0,
          fontWeight: FontWeight.normal,
          color:Colors.grey
        ),),
    ),
    onTap: (){
      _launchURL(url);
    },
    );
  }

  void _launchURL(String urlToLaunch) async {
  if (await canLaunch(urlToLaunch)) {
    await launch(urlToLaunch);
  } else {
    throw 'Could not launch $urlToLaunch';
  }
}
}
