import 'package:flutter/material.dart';
import 'package:sparkz/core/global/_widgets/custom_upper_button.dart';
import 'package:sparkz/core/global/_widgets/data/custom_appBar.dart';

class FrequentQuestionsPage extends StatelessWidget {
  const FrequentQuestionsPage({Key? key}) : super(key: key);

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
            title: 'Frequent Questions',
          ),
          preferredSize: Size(size.width, appBarPreferredSize)),
      backgroundColor: Color(0xFF2E3238),
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
          child: Container(
            height: (size.height - appBarPreferredSize - padding.top),
            width: size.width,
            margin: EdgeInsets.only(left: 20, right: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'These FAQ seek to clarify basic doubts about Sparkz',
                    style: TextStyle(
                      height: 1.5,
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFC0C1C2),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  buildItem(size),
                  buildItem(size),
                  buildItem(size),
                  buildItem(size),
                ],
              ),
            ),
          )),
    );
  }

  Widget buildItem(Size size) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Question',
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFFFF4F01)),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Text(
            'Do aliquip est aliqua sint ut deserunt est laboris exercitation incididunt minim aliquip. Labore excepteur amet veniam exercitation ut sit dolore nisi ullamco velit cupidatat. Velit cupidatat officia nostrud aliquip dolor mollit minim consectetur nostrud duis est elit in. Ut anim eu officia sit magna nulla velit irure ad proident duis sint.',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFFC0C1C2),
            ),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
        ],
      ),
    );
  }
}
