import 'package:flutter/material.dart';

class ButtonConfirmCustom extends StatelessWidget {
  final String text;
  final Function onPressed;

  ButtonConfirmCustom({this.text = 'Confirmar', this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RaisedButton(
        color: Colors.blue,
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2),
        ),
        child: Container(
          constraints: BoxConstraints(maxWidth: 200, minHeight: 50),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
            ),
          ),
        ),
      ),
    );
  }
}
