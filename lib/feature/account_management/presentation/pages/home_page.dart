import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sparkz/core/base/widget_base_state.dart';
import 'package:sparkz/core/global/_widgets/custom_drawer.dart';
import 'package:sparkz/core/global/_widgets/custom_menu_button.dart';
import 'package:sparkz/core/global/_widgets/custom_bottom_nav_bar.dart';
import 'package:sparkz/di/inyector.dart';
import 'package:sparkz/feature/account_management/presentation/bloc/log_out/log_out_bloc.dart';
import 'package:sparkz/feature/account_management/presentation/pages/log_in_page.dart';
import 'package:sparkz/core/global/notifications.dart' as Notifications;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends StateWithBloC<HomePage, LogOutBloc> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    Notifications.initNotificationService(context);
  }

  @override
  void dispose() {
    Injector.instance!.signalRService.dispose();
    Notifications.dispose();
    super.dispose();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return BlocConsumer<LogOutBloc, LogOutState>(
      listener: (context, state) {
        if (state is LogOutSuccessState) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (_) => LogInPage(
                        signalRService: Injector.instance!.getDependency(),
                      )),
              (route) => false);
        }
        return;
      },
      builder: (context, state) => ModalProgressHUD(
        inAsyncCall: state is LogOutSentState,
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.transparent,
          drawer: CustomDrawer(
            onLogOut: _handleLogOut,
            userProfile: Injector.instance!.getDependency(),
            signalRService: Injector.instance!.getDependency(),
          ),
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom,
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    Color(0xFF34393F),
                    Color(0xFF1B1C20),
                  ])),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomMenuButton(Icons.menu, () {
                            _scaffoldKey.currentState?.openDrawer();
                          }),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Image.asset(
                              'assets/images/login.png',
                              height: 80,
                              width: 80,
                            ),
                          ),
                          CustomMenuButton(FontAwesomeIcons.bell, () {})
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          RichText(
                            text: TextSpan(
                              text: 'WELCOME TO',
                              style: TextStyle(
                                color: Color(0xFFC0C1C2),
                                fontFamily: 'Ailerons',
                                fontWeight: FontWeight.w300,
                                letterSpacing: 1.8,
                                fontSize: 26,
                              ),
                              children: const <TextSpan>[
                                TextSpan(
                                    text: ' SPARKZ',
                                    style: TextStyle(color: Color(0xFFFF4F01))),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "A place for you",
                            style: TextStyle(
                                color: Color(0xFFC0C1C2),
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w300,
                                fontSize: 16),
                          ),
                          Image.asset(
                            'assets/images/parking_cars.png',
                            height: 200,
                          ),
                          Text(
                            "Do not leave it to chance!, quickly find your",
                            style: TextStyle(
                                color: Color(0xFFC0C1C2),
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w300,
                                fontSize: 14),
                          ),
                          Text(
                            "parking space or auction the one you are",
                            style: TextStyle(
                                color: Color(0xFFC0C1C2),
                                fontFamily: 'Montserrat',
                                fontSize: 14),
                          ),
                          Text(
                            "about to leave",
                            style: TextStyle(
                                color: Color(0xFFC0C1C2),
                                fontFamily: 'Montserrat',
                                fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    )
                  ],
                ),
              ),
            ),
          ),
          extendBody: true,
          bottomNavigationBar: CustomHomeBottomNavBar(
            isAuctionPressed: false,
            isSearchPressed: false,
          ),
        ),
      ),
    );
  }

  void _handleLogOut() => bloc?.add(LogOutSentEvent());
}
