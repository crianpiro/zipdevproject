import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zipdev/app/blocs/signIn_bloc.dart';
import 'package:zipdev/app/context/settings/app_assets.dart';
import 'package:zipdev/app/context/settings/application.dart';
import 'package:zipdev/app/context/settings/preferences.dart';
import 'package:zipdev/app/injectors/injector.dart';
import 'package:zipdev/app/ui/base_state.dart';
import 'package:zipdev/app/ui/components/varios_components.dart';
import 'package:zipdev/app/ui/screens/home_screen.dart';
import 'package:zipdev/models/entities/user_model.dart';

class SignInScreen extends StatefulWidget {
  static final route = "signInScreen";
  SignInScreen({Key key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends BaseState<SignInScreen,SignInBloc> {

  Size size;
  GlobalKey _formKey = new GlobalKey();
  Preferences _prefs = new Preferences();
  
  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _passwdController = new TextEditingController();

  TextStyle _textStyleBold = GoogleFonts.neucha(
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
          color:Colors.red[600]
        );
  TextStyle _textStyleRegular = GoogleFonts.neucha(
          fontSize: 23.0,
          fontWeight: FontWeight.normal,
          color:Colors.red[600]
        );
  

  @override
  getBlocInstance() {
    return SignInBloc(Injector().provideSecurityUseCase());
  }

  @override
  Widget build(BuildContext context) {
    if(size == null)size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Zipdev Poké-App',
        style:_textStyleBold,),
      ),
      body: Stack(
        children: [
          SafeArea(child: _buildContent(size)),
          _buildLoading(size),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget _buildContent(Size size){
    return Center(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(AppAssets.pokeBall,width: size.width*0.4,),
            SizedBox(height: 20.0,),
            _buildSignUpView(),
            _buildLabel("Username"),
            _buildInput("example@example.com", _usernameController, false,TextInputType.emailAddress),
            _buildLabel("Password"),
            _buildInput("eWera456", _passwdController, true,TextInputType.text),
            _labelBuilder(),
            _buttonBuilder()
          ],
        ),
        )
      ),
    );
  }

  Widget _buildLoading(Size size){
    return StreamBuilder(
      stream: bloc.loader,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot){
        if(snapshot.hasData && snapshot.data){
          return Container(
            height: size.height,
            width: size.width,
            color: Colors.white,
            child: Center(child: CircularProgressIndicator(
              backgroundColor: Colors.red[800],
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
            ),),
          );
        }else{
          return Container(width: 0.0,height: 0.0,);
        }
      },
    );
  }

  Widget _buildSignUpView(){
    return StreamBuilder(
      stream: bloc.signView,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot){
        if(snapshot.hasData && snapshot.data){
          return Column(
            children: [
              _buildLabel("Name"),
              _buildInput("Cristian", _nameController, false,TextInputType.text),
            ],
          );
        }else{
          return Container();
        }
      },
    );
  }
  Widget _buildInput(String placeholder, TextEditingController _controller, bool isPasswd, TextInputType keyboardType){
    return Container(
      padding: EdgeInsets.symmetric(horizontal:20.0,vertical: 20.0),
      alignment: Alignment.center,
      child: TextField(
        controller: _controller,
        obscureText: isPasswd,
        keyboardType: keyboardType,        
        decoration: InputDecoration(
          hintText: placeholder,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
          )
        ),
      )
    );
  }

  Widget _buildLabel(String textLabel){
    return Container(
      padding: EdgeInsets.symmetric(horizontal:20.0),
      alignment: Alignment.centerLeft,
      child: AutoSizeText(
        textLabel,
            textAlign: TextAlign.left,
            style: _textStyleRegular,),
    );
  }

  Widget _labelBuilder(){
     return StreamBuilder(
      stream: bloc.signView,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot){
        if(snapshot.hasData && snapshot.data){
          return _buildSignUpLinkRel("Already have an account? Sign In",()=>bloc.changeToSignIn());
        }else{
          return _buildSignUpLinkRel("Don't have an account? Sign Up",()=>bloc.changeToSignUp());
        }
      });  
  }

  Widget _buildSignUpLinkRel(String label, Function changeView){
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal:20.0,vertical: 5.0),
        alignment: Alignment.center,
        child: AutoSizeText(
          label,
              textAlign: TextAlign.center,
              style: GoogleFonts.neucha(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color:Colors.red[600]
        ),),
      ),
      onTap: changeView,
    );
    
  }
  Widget _buttonBuilder(){
     return StreamBuilder(
      stream: bloc.signView,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot){
        if(snapshot.hasData && snapshot.data){
          return _buildButton("Sign Up",1);
        }else{
          return _buildButton("Sign In",0);
        }
      });  
  }

  Widget _buildButton(String label, int subCase){
    return RaisedButton(
      color: Colors.red[600],
      padding: EdgeInsets.symmetric(vertical: 10.0,horizontal:25.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      child: Text(label,
        style: GoogleFonts.neucha(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color:Colors.white
        ),
      ),
      onPressed: (){
        bloc.setLoadding();
        _submit(subCase);},
    );
  }
  void _submit(int subCase)async {
    switch (subCase) {
      case 0:
        final result = await bloc.sigIn(_usernameController.text.trim(), _passwdController.text.trim());
        if(result.error != null){
          bloc.setLoaded();
          showAlert("¡Something went wrong!", result.error.message,context);
        }else{
          _prefs.userInfo = json.encode(result.data.payload.response.toJson());
          Application().user = result.data.payload.response;
          Navigator.pushReplacementNamed(context, HomeScreen.route);
        }

        break;
      case 1:
        final _user = new UserModel(
          name: _nameController.text.trim(),
          username: _usernameController.text.trim()
        );
        final result = await bloc.sigUp(_user, _passwdController.text.trim());
        if(result.error != null){
          bloc.setLoaded();
          showAlert("¡Something went wrong!", result.error.message,context);
        }else{
          _prefs.userInfo = json.encode(result.data.payload.response.toJson());
          Application().user = result.data.payload.response;
          Navigator.pushReplacementNamed(context, HomeScreen.route);
        }
        break;
      default:
    }

  }
}