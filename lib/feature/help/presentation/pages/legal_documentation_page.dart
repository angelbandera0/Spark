import 'package:flutter/material.dart';
import 'package:sparkz/core/global/_widgets/custom_upper_button.dart';
import 'package:sparkz/core/global/_widgets/data/custom_appBar.dart';

class LegalDocumentationPage extends StatelessWidget {
  const LegalDocumentationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final appBarPreferredSize = size.height * 0.15;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        child:Container(
          margin: EdgeInsets.only(right:60.0),
          child: CustomAppBar(
            leading: CustomUpperButton(
              icon: Icons.arrow_back,
            ),
            title: 'Privacy Policy',
          ),),
          preferredSize: Size(size.width, appBarPreferredSize)),
      backgroundColor:Color(0xFF34393F),
      body: Container(
          height: (size.height - appBarPreferredSize - padding.top),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Color(0xFF34393F),
                Color(0xFF1B1C20),
              ])),
          child: SingleChildScrollView(
            child: Container(
              width: size.width,
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sparkz Privacy Policy',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFC0C1C2)),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Text(
                    'Lorem ipsum dolor',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFFF4F01)),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Text(
                    '''Do aliquip est aliqua sint ut deserunt est laboris exercitation incididunt minim aliquip. Labore excepteur amet veniam exercitation ut sit dolore nisi ullamco velit cupidatat. Velit cupidatat officia nostrud aliquip dolor mollit minim consectetur nostrud duis est elit in. Ut anim eu officia sit magna nulla velit irure ad proident duis sint.
                
Nostrud sint proident esse exercitation magna. Amet anim occaecat nulla anim. Qui ullamco nulla veniam sit sit occaecat.
                
Laboris tempor consectetur commodo est. Commodo esse ullamco do veniam laboris. Laboris ad ex veniam minim officia esse mollit ea sit consequat ex aliquip id. Nostrud dolor sit occaecat consequat exercitation pariatur eu consectetur cillum voluptate.
                
Aliqua reprehenderit aliquip in cupidatat ut ut dolor aliqua. Dolor id amet dolor reprehenderit cillum. Cupidatat ex officia anim et cupidatat ut proident dolor excepteur. Incididunt do veniam ullamco ullamco nostrud minim. Non quis labore exercitation minim eiusmod nostrud adipisicing proident velit quis nostrud sint reprehenderit. Eiusmod irure minim esse esse amet ullamco ex.''',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFFC0C1C2)),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
