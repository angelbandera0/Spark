import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';

class CustomIntlPhone extends StatelessWidget {
  CustomIntlPhone(
      {this.labelText = '',
      this.handleCountryCode,
      this.handlePhoneNumber,
      this.validatePhone});

  final String labelText;
  final TextEditingController controller = TextEditingController();
  final Function(CountryCode)? handleCountryCode;
  final Function(String)? handlePhoneNumber;
  final String? Function(String?)? validatePhone;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xFFC0C1C2)),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                   Container(
                    height: 45,


                    child: Neumorphic(
                      style: NeumorphicStyle(
                        shadowDarkColor: Colors.black,
                        shadowLightColor: Colors.white38,
                        depth: 4,
                        intensity: 5,
                        color: Color(0xFF1D2025),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          CountryCodePicker(

                            padding: EdgeInsets.zero,
                            closeIcon: Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                            boxDecoration: BoxDecoration(
                                gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xFF34393F),
                                Color(0xFF1B1C20),
                              ],
                            )),
                            searchDecoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                              focusColor: Colors.white,
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                            ),
                            backgroundColor: Colors.transparent,
                            onChanged: handleCountryCode,
                            initialSelection: 'US',
                            searchStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFC0C1C2)),
                            dialogTextStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFC0C1C2)),
                            textStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFC0C1C2)),
                          ),

                          Row(
                            // width: 10,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children:[
                            Icon(Icons.arrow_drop_down ,
                              color: Color(0xFFC0C1C2) ,

                            ),],),
                        ],
                      ),
                    ),
                  ),

                SizedBox(
                  width: 40,
                ),
                Expanded(
                  flex: 7,
                  child: Container(
                      //height: 50,
                      child: Stack(
                    children: [
                      Container(
                          height: 45,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image:
                                  AssetImage('assets/images/input_border.png'),
                              fit: BoxFit.fill,
                            ),
                          )),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.white,
                        style: (TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            fontFamily: 'Montserrat')),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "999-999-9999",
                          contentPadding: EdgeInsets.all(14),
                          hintStyle: TextStyle(
                            color: Color(0xFFB5B6B8),
                          ),
                        ),
                        onChanged: handlePhoneNumber,
                        validator: validatePhone,
                      )
                    ],
                  )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
