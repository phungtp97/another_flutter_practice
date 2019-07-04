import 'package:flutter/material.dart';

// ignore: slash_for_doc_comments
/**
 * created by phungtp.
 * Date: 03/06/2018.
 * Inspired: Android-boiler-plate.
 */

class ResourceStyles {


  BorderRadius baseRadius(double radius){
    return BorderRadius.all(Radius.circular(radius));
  }

  Widget textFieldBuilder(IconData icon, String text, {bool dot, Function callbackText}) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: new BoxDecoration(
            color: Color(0x40ffffff),
            borderRadius: new BorderRadius.all(Radius.circular(20.0))),
        child: TextField(
          onTap: (){},
          onChanged: (text) => callbackText?? callbackText(text),
          decoration: InputDecoration(
            fillColor: Colors.transparent,
            prefixIcon: Icon(icon),
            border: InputBorder.none,
            hintText: text,
          ),
          obscureText: dot,
        ),
      ),
    );
  }
}