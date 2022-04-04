import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class CustomDropDownButton extends StatelessWidget {
  const CustomDropDownButton(
      {Key? key,
      required this.onPressDropDown,
      this.itemSelected,
      required this.dropdownItems})
      : super(key: key);
  final Function(String?)? onPressDropDown;
  final String? itemSelected;
  final List<DropdownMenuItem<String>> dropdownItems;
  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
        shadowDarkColor: Colors.black,
        shadowLightColor: Colors.white38,
        depth: 4,
        intensity: 5,
        color: Color(0xFF1D2025),
      ),
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.only(left: 15, right: 15),
      child: DropdownButtonFormField<String>(
          decoration: InputDecoration(border: InputBorder.none),
          dropdownColor: Color(0xFF1D2025),
          icon: const Icon(Icons.arrow_drop_down),
          iconEnabledColor: Color(0xFFC0C1C2),
          style: TextStyle(
            color: Color(0xFFC0C1C2),
            fontSize: 16,
          ),
          value: itemSelected ?? dropdownItems.first.value,
          items: dropdownItems,
          onChanged: onPressDropDown),
    );
  }
}
