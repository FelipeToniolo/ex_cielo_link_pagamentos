import 'package:flutter/material.dart';

class TextFormFieldCustom extends StatelessWidget {
  TextEditingController controller;
  String labelText;
  TextInputType keyboardType;

  TextFormFieldCustom(
      {this.controller,
      this.labelText,
      this.keyboardType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.vertical(top: Radius.zero)),
          labelStyle: TextStyle(fontSize: 25),
          hintStyle: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
