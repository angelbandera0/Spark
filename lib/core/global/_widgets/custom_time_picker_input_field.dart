import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class CustomTimePickerInputField extends StatelessWidget {
  const CustomTimePickerInputField(
      {Key? key,
      required this.sizeScreen,
      required this.hintText,
      required this.controller,
      required this.onTap,
      required this.changeHandler,
      required this.validatorHandler});

  final Size sizeScreen;
  final String hintText;
  final TextEditingController controller;
  final void Function() onTap;
  final Function(String)? changeHandler;
  final String? Function(String?)? validatorHandler;

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Stack(
        children: [
          Neumorphic(
              style: NeumorphicStyle(
                depth: -3,
                intensity: 1,
                shadowDarkColorEmboss: Colors.black,
                shadowLightColorEmboss: Colors.white38,
                color: Colors.transparent,
              ),
              child: Container(
                height: 45,
                width: sizeScreen.width,
              )),
          Container(
            height: MediaQuery.of(context).size.height*0.1,
            child: TextFormField(
              textAlignVertical: TextAlignVertical.top,
              enableInteractiveSelection: false,
              readOnly: true,
              onTap: onTap,
              initialValue: null,
              controller: controller,
              textInputAction: TextInputAction.next,
              validator: validatorHandler,
              style: (TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  fontFamily: 'Montserrat')),
              keyboardType: TextInputType.datetime,
              cursorColor: Colors.white,
              decoration: InputDecoration(
                errorMaxLines: 2,
                border: InputBorder.none,
                hintText: hintText,
                contentPadding: EdgeInsets.all(14),
                hintStyle: TextStyle(
                  color: Color(0xFFB5B6B8),
                ),
              ),
              onChanged: changeHandler,
            ),
          ),
        ],
      ),
    );
  }
}
