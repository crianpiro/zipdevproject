import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zipdev/app/context/settings/app_assets.dart';
import 'package:zipdev/app/ui/components/slider_Widget.dart';
import 'package:zipdev/app/ui/screens/signIn_screen.dart';

class OnBoardScreen extends StatefulWidget {
  static final route = "onBoardScreen";

  OnBoardScreen({Key key}) : super(key: key);

  @override
  _OnBoardScreenState createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  Size size;

  @override
  Widget build(BuildContext context) {
    if(size == null) size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(size),
          _buildSlides(),
          _buildSkipButton(size),
        ],
      ),
    );
  }
  Widget _buildSkipButton(Size size){
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Center(
          child: RaisedButton(
            padding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 5.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)
            ),
            color: Colors.white,
            onPressed: (){
              Navigator.pushReplacementNamed(context,SignInScreen.route);
            },
            child: Text("Skip",
              style: GoogleFonts.neucha(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),),),
        )
        
      ],
    );
  }

  Widget _buildSlides(){
    return Column(
      children: [
        Expanded(
          child: SliderWidget(
            primaryColor: Colors.redAccent[700],
            // pagePadding: EdgeInsets.symmetric(vertical: 70.0),
            dotsMargin: EdgeInsets.only(bottom: 70.0),
            secundaryColor: Colors.white,
            primarySize: 25.0,
              slides: [
                _buildScreen1(),
                _buildScreen2()
              ],
            ),
        ),
      ],
    );

  }

  Widget _buildScreen1(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
          Image.asset(AppAssets.pokeApi,),
          AutoSizeText("Using the RESTful Pokémon API",
            minFontSize: 24.0,
            style: GoogleFonts.neucha(
                      color: Colors.black,
                      fontSize: 27.0,
                      fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20.0,),
          AutoSizeText("'All the Pokémon data you'll ever need in one place, easily accessible through a modern RESTful API.'",
            minFontSize: 20.0,
            textAlign: TextAlign.center,
            maxLines: 4,
            style: GoogleFonts.neucha(
                      color: Colors.black,
                      fontSize: 22.0,
                      fontWeight: FontWeight.normal),
          ),
      ],
    );
  }

  Widget _buildScreen2(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
          Image.asset(AppAssets.logo,),
          AutoSizeText("A Zipdev Flutter code assessment",
            minFontSize: 24.0,
            style: GoogleFonts.neucha(
                      color: Colors.black,
                      fontSize: 27.0,
                      fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20.0,),
          AutoSizeText("To assess the expertise with Flutter and the coding skills.",
            minFontSize: 20.0,
            textAlign: TextAlign.center,
            maxLines: 4,
            style: GoogleFonts.neucha(
                      color: Colors.black,
                      fontSize: 22.0,
                      fontWeight: FontWeight.normal),
          ),
      ],
    );
  }


  Widget _buildBackground(Size size){
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.redAccent[400],
            Colors.white,
            Colors.redAccent[400],
          ]
        )
      ),
    );
  }
}