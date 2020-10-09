import 'dart:async';
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zipdev/app/blocs/splash_bloc.dart';
import 'package:zipdev/app/context/settings/app_assets.dart';
import 'package:zipdev/app/context/settings/application.dart';
import 'package:zipdev/app/context/settings/preferences.dart';
import 'package:zipdev/app/injectors/injector.dart';
import 'package:zipdev/app/ui/base_state.dart';
import 'package:zipdev/app/ui/screens/home_screen.dart';
import 'package:zipdev/app/ui/screens/onBoard_screen.dart';
import 'package:zipdev/models/entities/user_model.dart';

class SplashScreen extends StatefulWidget {
  static final route = "splashScreen";

  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends BaseState<SplashScreen,SplashBloc> {

  Size size;
  final Preferences _preferences = new Preferences();

  @override
  void initState() { 
    super.initState();
    initApp();
  }

  Future<Timer> initApp() async{
    if(_preferences.userInfo != null){
      final UserModel _user = UserModel.fromJson(json.decode(_preferences.userInfo));
      Application().user = _user;
      
      return Timer(Duration(seconds: 3),()=>Navigator.pushReplacementNamed(context, HomeScreen.route));
    }else{
      return Timer(Duration(seconds: 3),()=>Navigator.pushReplacementNamed(context, OnBoardScreen.route));
    }
  }

  @override
  SplashBloc getBlocInstance() {
    return SplashBloc(Injector().provideSecurityUseCase());
  }

  @override
  Widget build(BuildContext context) {
    if(size==null)size= MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(size),
          _buildContent(),
        ],
      ),
    );
  }

  Widget _buildContent(){
    return SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Container()),
            Image.asset(
              AppAssets.pokeBall,
              width: 150.0,
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              child: Center(
                child: AutoSizeText(
                  'Welcome to the ZipDev Poké-App',
                  maxLines: 3,
                  minFontSize: 25.0,
                  style: GoogleFonts.neucha(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
            Divider(color: Colors.black,thickness: 1.0,indent: 20.0,endIndent: 20.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15.0),
              child: Center(
                child: AutoSizeText(
                  'Please wait...',
                  maxLines: 3,
                  minFontSize: 20.0,
                  style: GoogleFonts.neucha(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
            CircularProgressIndicator(
              backgroundColor: Colors.red[800],
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
            )
              ],
            ),
            Expanded(child: Container()),
            Image.asset(
              AppAssets.logo,
              width: 150.0,
            ),
          ],
        ),
      );
  }
  Widget _buildBackground(Size size){
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromRGBO(0xF2,0x2E,0x5D,1),
            Colors.redAccent[400],
            Colors.white,
          ]
        )
      ),
    );
  }

 
}
