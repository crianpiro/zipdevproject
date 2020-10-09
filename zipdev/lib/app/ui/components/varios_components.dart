import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showAlert(String title, String message, BuildContext context)
  {
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
        
    showDialog(
      context: context,
      barrierDismissible: false,
      child: AlertDialog(
        title: Text(title,style: _textStyleBold,),
        contentPadding: EdgeInsets.all(20.0),
        content: Text(message,
          style: GoogleFonts.neucha(
          fontSize: 23.0,
          fontWeight: FontWeight.normal,
          color:Colors.black
        ),
        ),
        actions: [
          RaisedButton(
      color: Colors.red[600],
      padding: EdgeInsets.symmetric(vertical: 10.0,horizontal:25.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      child: Text("Close",
        style: GoogleFonts.neucha(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color:Colors.white
        ),
      ),
      onPressed: ()=>Navigator.pop(context),
    )
        ],
      )
    );
  }