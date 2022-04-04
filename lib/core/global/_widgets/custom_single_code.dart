import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class CustomSingleCode extends StatelessWidget {
  CustomSingleCode({this.node, this.onChange});

  final FocusNode? node;
  final Function(String)? onChange;

  @override
  Widget build(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;
    return Neumorphic(
      style: NeumorphicStyle(
          depth: -3,
          intensity: 1,
          shadowDarkColorEmboss: Colors.black87,
          shadowLightColorEmboss: Colors.white54,
          color: Colors.transparent,
          lightSource: LightSource.topLeft),
      child: Container(
        width: _screenSize.width * 0.11,
        height: _screenSize.height * 0.072,
        child: Center(
          child: TextFormField(
            textInputAction: TextInputAction.next,
            textAlignVertical: TextAlignVertical.center,
            focusNode: node,
            textAlign: TextAlign.center,
            expands: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              filled: true,
            ),
            inputFormatters: [
              LengthLimitingTextInputFormatter(1), // for mobile
            ],
            maxLines: null,
            minLines: null,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 20,
                fontFamily: 'Montserrat'),
            keyboardType: TextInputType.number,
            cursorColor: Colors.white,
            onChanged: onChange,
          ),
        ),
      ),
    );
  }
}
