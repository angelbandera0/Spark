import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class CustomTextBox extends StatelessWidget {
  const CustomTextBox({Key? key, this.changeHandler, this.validatorHandler})
      : super(key: key);

  final Function(String)? changeHandler;
  final String? Function(String?)? validatorHandler;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Stack(
        children: [
          Neumorphic(
              style: NeumorphicStyle(
                depth: -3,
                intensity: 1,
                shadowDarkColorEmboss: Colors.black,
                shadowLightColorEmboss: Colors.white54,
                color: Colors.transparent,
              ),
              child: Container(
                height: size.height * 0.4,
              )),
          Container(
            height: size.height * 0.4,
            child: TextFormField(
              textInputAction: TextInputAction.newline,
              expands: true,
              maxLines: null,
              minLines: null,
              keyboardType: TextInputType.multiline,
              style: (TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  fontFamily: 'Montserrat')),
              cursorColor: Colors.white,
              onChanged: changeHandler,
              validator: validatorHandler,
              decoration: InputDecoration(
                errorMaxLines: 2,
                border: InputBorder.none,
                hintText: 'Describe the problem...',
                contentPadding: EdgeInsets.all(14),
                hintStyle: TextStyle(
                  color: Color(0xFFB5B6B8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
