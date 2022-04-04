import 'package:flutter/material.dart';

class GenericInput extends StatefulWidget {
  GenericInput({
    this.labelText = '',
    this.nameNode,
    this.changeHandler,
    this.validatorHandler,
    this.keyType = TextInputType.text,
    this.fieldHint = '',
    this.isFieldPassword = false,
    this.iconLink = '',
    this.iconWidth = 16,
    this.iconHeight = 16,
    this.initialValue = '',
    this.controller,
    this.readOnly = false,
    this.fontSize = 16,
  });

  final String labelText;
  final FocusNode? nameNode;
  final Function(String)? changeHandler;
  final String? Function(String?)? validatorHandler;
  final TextInputType? keyType;
  final String? fieldHint;
  final bool isFieldPassword;
  final String iconLink;
  final double? iconWidth;
  final double? iconHeight;
  final String? initialValue;
  final TextEditingController? controller;
  final bool readOnly;
  final double? fontSize;
  @override
  _GenericInputState createState() => _GenericInputState();
}

class _GenericInputState extends State<GenericInput> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.labelText,
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: widget.fontSize,
                fontWeight: FontWeight.w500,
                color: Color(0xFFC0C1C2)),
          ),
          SizedBox(
            height: 12,
          ),
          Stack(
            children: [
              Container(
                  height: 45,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/input_border.png'),
                      fit: BoxFit.fill,
                    ),
                  )),
              TextFormField(
                readOnly: widget.readOnly,
                controller: widget.controller,
                textInputAction: TextInputAction.next,
                focusNode: widget.nameNode,
                validator: widget.validatorHandler,
                autofocus: true,
                style: (TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: widget.fontSize! - 2,
                    fontFamily: 'Montserrat')),
                keyboardType: widget.keyType,
                cursorColor: Colors.white,
                obscureText: widget.isFieldPassword ? !_isVisible : false,
                initialValue: widget.initialValue,
                decoration: InputDecoration(
                  errorMaxLines: 2,
                  border: InputBorder.none,
                  hintText: widget.fieldHint,
                  contentPadding: EdgeInsets.all(14),
                  hintStyle: TextStyle(
                    color: Color(0xFFB5B6B8),
                  ),
                  prefixIcon: widget.iconLink.length > 0
                      ? Container(
                          alignment: Alignment.center,
                          width: widget.iconWidth,
                          height: widget.iconHeight,
                          child: Image.asset(
                            widget.iconLink,
                            width: widget.iconWidth,
                            height: widget.iconHeight,
                            fit: BoxFit.cover,
                          ))
                      : null,
                  suffixIcon: widget.isFieldPassword
                      ? GestureDetector(
                          onTap: () {
                            widget.nameNode?.unfocus();
                            widget.nameNode?.canRequestFocus = false;
                            setState(() {
                              print('click');
                              _isVisible = !_isVisible;
                            });
                            Future.delayed(Duration(milliseconds: 100), () {
                              widget.nameNode?.canRequestFocus = true;
                            });
                          },
                          child: _iconEyesChange(_isVisible),
                        )
                      : null,
                ),
                onChanged: widget.changeHandler,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _iconEyesChange(bool isVisible) {
    double _height = isVisible ? 14 : 18;
    double _width = isVisible ? 22 : 22;

    return Container(
      alignment: Alignment.center,
      height: _height,
      width: _width,
      child: Image.asset(
        isVisible
            ? 'assets/images/icon_remove_red_eye.png'
            : 'assets/images/icon_eye_off.png',
        height: _height,
        width: _width,
        fit: BoxFit.cover,
      ),
    );
  }
}
