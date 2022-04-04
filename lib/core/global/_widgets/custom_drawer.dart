import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:sparkz/core/global/_widgets/custom_menu_button.dart';
import 'package:sparkz/core/global/data/user_profile.dart';
import 'package:sparkz/core/global/endpoints.dart';
import 'package:sparkz/core/platform/signalr_service.dart';
import 'package:sparkz/di/inyector.dart';
import 'package:sparkz/feature/account_management/presentation/pages/edit_user_page.dart';
import 'package:sparkz/feature/car/presentation/pages/car_menu_page.dart';
import 'package:sparkz/feature/help/presentation/pages/help_page.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer(
      {Key? key,
      required this.onLogOut,
      required this.userProfile,
      required this.signalRService})
      : super(key: key);
  final VoidCallback onLogOut;
  final UserProfile userProfile;
  final SignalRService signalRService;
  final padding = EdgeInsets.symmetric(horizontal: 20);
  final String avatarDefault = 'assets/images/avatar.png';
  final String avatarBackground = 'assets/images/avatar_background.png';
  final String name = 'Robert Plant';
  final bool onLineStatus = true;
  static const double? itemSpace = 10;
  final double avatarSize = 100;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
          color: Color(0xFF1D2025),
          child: ListView(
            children: [
              _buildHeader(
                  name, loadAvatarImage(), avatarBackground, onLineStatus, () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                            EditUserPage(Injector.instance!.getDependency())));
              }),
              const SizedBox(height: 5),
              Divider(color: Color(0xFFFF4F01)),
              const SizedBox(height: itemSpace),
              _buildMenuItem(
                  text: 'My Car',
                  icon: FontAwesomeIcons.car,
                  iconSize: 25,
                  onClicked: () => selectedItem(context, 0)),
              const SizedBox(height: itemSpace),
              _buildMenuItem(
                text: 'Payment Method',
                icon: FontAwesomeIcons.creditCard,
                iconSize: 20,
                onClicked: () => selectedItem(context, 1),
              ),
              const SizedBox(height: itemSpace),
              _buildMenuItem(
                text: 'Help',
                icon: Icons.help,
                iconSize: 25,
                onClicked: () => selectedItem(context, 2),
              ),
              const SizedBox(height: itemSpace),
              _buildMenuItem(
                text: 'Logout',
                icon: Icons.logout,
                iconSize: 25,
                onClicked: () => selectedItem(context, 3),
              )
            ],
          )),
    );
  }

  Widget _buildMenuItem({
    required String text,
    required IconData icon,
    required double iconSize,
    VoidCallback? onClicked,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: Color(0xFFFF4F01),
        size: iconSize,
      ),
      title: Text(text,
          style: TextStyle(
            color: Color(0xFFC0C1C2),
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            fontSize: 16,
          )),
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CarMenuPage()));
        break;
      case 2:
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HelpPage()));
        break;
      case 3:
        this.onLogOut();
        break;
    }
  }

  Widget _buildHeader(String name, Widget avatarImage, String avatarBAckground,
          bool onlineStatus, VoidCallback? onClicked) =>
      Container(
        padding: padding.add(EdgeInsets.symmetric(vertical: 25)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                avatarImage,
                Spacer(),
                CustomMenuButton(Icons.edit, onClicked),
              ],
            ),
            const SizedBox(height: 10),
            Text(userProfile.getFullName() ?? name,
                style: TextStyle(
                    color: Color(0xFFC0C1C2),
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    fontSize: 22)),
            const SizedBox(height: 5),
            StreamBuilder<String>(
                stream: signalRService.connectionStatus.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data.toString(),
                        style: TextStyle(
                            color: Color(0xFFFF4F01),
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 16));
                  } else {
                    return Text('Offline',
                        style: TextStyle(
                            color: Color(0xFFFF4F01),
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 16));
                  }
                }),
          ],
        ),
      );

  Widget loadAvatarImage() {
    if (userProfile.getAvatar()?.isEmpty ?? true) {
      return ClipOval(
          child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image:
                          AssetImage('assets/images/avatar_background.png'))),
              child: Image.asset(avatarDefault,
                  width: avatarSize, height: avatarSize, fit: BoxFit.cover)));
    }
    final url = Endpoint.API_AZURE_STORAGE + userProfile.getAvatar()!;
    return ClipOval(
        child: Image.network(url,
            width: avatarSize, height: avatarSize, fit: BoxFit.cover));
  }
}
