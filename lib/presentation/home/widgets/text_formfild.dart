import 'package:flutter/material.dart';

class BuildTextformFild extends StatelessWidget {
  const BuildTextformFild({
    Key? key,
    required this.hintText,
    this.controller,
    this.keyboardType
  }) : super(key: key);

  final String hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType:keyboardType ,
      controller:controller ,
     validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required';
                      }
                      return null;
                    }, 
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: hintText,
      ),
    );
  }
}