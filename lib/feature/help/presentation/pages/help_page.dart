import 'package:flutter/material.dart';
import 'package:sparkz/core/global/_widgets/custom_upper_button.dart';
import 'package:sparkz/core/global/_widgets/data/custom_appBar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sparkz/feature/help/presentation/pages/contact_page.dart';
import 'package:sparkz/feature/help/presentation/pages/frequent_questions_page.dart';
import 'package:sparkz/feature/help/presentation/pages/info_page.dart';
import 'package:sparkz/feature/help/presentation/pages/legal_documentation_page.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final appBarPreferredSize = size.height * 0.15;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
          child: CustomAppBar(
            leading: CustomUpperButton(
              icon: Icons.arrow_back,
            ),
            title: 'Help',
          ),
          preferredSize: Size(size.width, appBarPreferredSize)),
      backgroundColor: Color(0xFF2E3238),
      body: SingleChildScrollView(
        child: Container(
            height: (size.height - appBarPreferredSize - padding.top),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Color(0xFF34393F),
                  Color(0xFF1B1C20),
                ])),
            child: Container(
              child: Column(
                children: [
                  _buildMenuItem(
                      text: 'Frequent Questions',
                      icon: FontAwesomeIcons.questionCircle,
                      iconSize: 20,
                      context: context,
                      page: FrequentQuestionsPage()),
                  _buildMenuItem(
                      text: 'Contact Us',
                      icon: FontAwesomeIcons.userFriends,
                      iconSize: 18,
                      context: context,
                      page: ContactPage()),
                  _buildMenuItem(
                      text: 'Conditions and Privacy',
                      icon: FontAwesomeIcons.solidFileAlt,
                      iconSize: 20,
                      context: context,
                      page: LegalDocumentationPage()),
                  _buildMenuItem(
                      text: 'Info',
                      icon: Icons.info_outlined,
                      iconSize: 23,
                      context: context,
                      page: InfoPage())
                ],
              ),
            )),
      ),
    );
  }

  Widget _buildMenuItem(
      {required String text,
      required IconData icon,
      required double iconSize,
      required Widget page,
      required BuildContext context}) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20),
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
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
    );
  }
}
