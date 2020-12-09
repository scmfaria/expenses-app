import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AdaptativeButton extends StatelessWidget {
  final String label;
  final Function onPressed;

  AdaptativeButton({
    this.label,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS ? 
      CupertinoButton(
        child: Text(label),
        onPressed: onPressed,
        color: Theme.of(context).primaryColor,
        padding: EdgeInsets.symmetric(horizontal: 20),
    ) :
    // entra aqui caso for o android 
    RaisedButton(
      color: Theme.of(context).primaryColor,
      textColor: Colors.white,
      child: Text(label),
      onPressed: onPressed,
    );
  }
}