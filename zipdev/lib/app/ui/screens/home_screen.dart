import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zipdev/app/blocs/home_bloc.dart';
import 'package:zipdev/app/context/settings/preferences.dart';
import 'package:zipdev/app/injectors/injector.dart';
import 'package:zipdev/app/ui/base_state.dart';
import 'package:zipdev/app/ui/screens/detail_screen.dart';
import 'package:zipdev/app/ui/screens/signIn_screen.dart';
import 'package:zipdev/models/dto/event.dart';
import 'package:zipdev/models/dto/result_model.dart';

class HomeScreen extends StatefulWidget {
  static final route = "homeScreen";
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeScreen,HomeBloc> {

  final Preferences _preferences = new Preferences();

  TextStyle _textStyleBold = GoogleFonts.neucha(
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
          color:Colors.red[600]
        );
        
  @override
  HomeBloc getBlocInstance() {
    return HomeBloc(Injector().provideUserUseCase());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Zipdev Poké-App',
        style:_textStyleBold,),
        actions: [
          IconButton(icon: Icon(Icons.logout,color: Colors.black,), onPressed: (){
            _preferences.userInfo = null;
            Navigator.pushReplacementNamed(context, SignInScreen.route);
          })
        ],
      ),
      body: Stack(
        children: [
            Column(
              children: [
                _buildHint(),
                Expanded(child: _buildPokemonList(),)
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildHint(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal:15.0,vertical:10.0),
      child: Text("The data of the first 20 Pokémon in one place, easily accessible through a modern Flutter application.",
      style:  GoogleFonts.neucha(
          fontSize: 23.0,
          fontWeight: FontWeight.normal,
          color:Colors.grey
        ),),
    );
  }

  Widget _buildPokemonList(){
    return FutureBuilder(
      future: bloc.getPokemons(),
      builder: (BuildContext context, AsyncSnapshot<Result<Event<Map<String, dynamic>>>> snapshot){
        if(snapshot.hasData){
          final Result<Event<Map<String, dynamic>>> result = snapshot.data;
          if(result.error != null){
            return Container(
              child: Center(
                child: Text(result.error.message),
              ),
            );
          }else{
            final Map<String,dynamic> responseData = result.data.payload.response;
            final List pokemonList = responseData["results"];
            final List<Widget> itemsList = new List();
            pokemonList.forEach((element) { 
              itemsList.add(
                _buildItem(element["name"],element["url"])
              );
            });
            return ListView(
              children: itemsList,
            );
          }
        }else{
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

  Widget _buildItem(String title, String url){
    return GestureDetector(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)
                    ),
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical:10.0, horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(title,
                        style:GoogleFonts.neucha(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color:Colors.black
                        )
                        ),
                        Icon(Icons.arrow_forward_ios)
                      ],
                    ),
                    )
                  ),
                  onTap: (){
                    Navigator.pushNamed(context, DetailScreen.route ,arguments: [title,url]);
                  },
                );
  }
  
}