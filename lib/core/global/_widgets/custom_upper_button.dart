import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class CustomUpperButton extends StatelessWidget {
  const CustomUpperButton(
      {Key? key, required this.icon, this.onPressed, this.isLeading = true})
      : super(key: key);

  final IconData icon;
  final void Function()? onPressed;
  final bool? isLeading;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: NeumorphicButton(
        margin: EdgeInsets.only(
            top: size.height * 0.045,
            bottom: size.height * 0.045,
            right: isLeading! ? 0 : size.width * 0.05,
            left: isLeading! ? size.width * 0.05 : 0),
        onPressed: onPressed ??
            () {
              Navigator.pop(context);
            },
        style: NeumorphicStyle(
            shadowDarkColor: Colors.black,
            shadowLightColor: Colors.white38,
            depth: 4,
            intensity: 5,
            color: Color(0xFF1B1C20)),
        padding: EdgeInsets.all(6),
        child: Icon(
          icon,
          color: Color(0xFFFF4F01),
        ),
      ),
    );
  }
}
