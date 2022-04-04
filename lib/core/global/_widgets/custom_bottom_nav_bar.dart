import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:sparkz/core/base/widget_base_state.dart';
import 'package:sparkz/feature/auction/presentation/pages/list_auction_page.dart';
import 'package:sparkz/feature/car/presentation/bloc/get_active_car/get_active_car_bloc.dart';
import 'package:sparkz/feature/search/presentation/pages/parking_requirements_page.dart';

class CustomHomeBottomNavBar extends StatefulWidget {
  const CustomHomeBottomNavBar({
    Key? key,
    required this.isAuctionPressed,
    required this.isSearchPressed,
  }) : super(key: key);

  final bool isAuctionPressed;
  final bool isSearchPressed;

  @override
  _CustomHomeBottomNavBarState createState() => _CustomHomeBottomNavBarState();
}

class _CustomHomeBottomNavBarState
    extends StateWithBloC<CustomHomeBottomNavBar, GetActiveCarBloc> {
  @override
  Widget buildWidget(BuildContext context) {
    return BlocConsumer<GetActiveCarBloc, GetActiveCarState>(
        listener: (context, state) {
      if (state is GetActiveCarSuccessState || state is GetNoActiveCarState) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => AddUnparkedPage()));
      }
      return;
    }, builder: (context, state) {
      return NeumorphicBottomNavBar(
        isAuctionPressed: widget.isAuctionPressed,
        isSearchPressed: widget.isSearchPressed,
        onPressSearch: widget.isSearchPressed
            ? null
            : () {
                context.read<GetActiveCarBloc>().add(GetActiveCarSentEvent());
              },
        onPressAuction: widget.isAuctionPressed
            ? null
            : () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => ListAuctionPage()));
              },
      );
    });
  }
}

class NeumorphicBottomNavBar extends StatelessWidget {
  const NeumorphicBottomNavBar({
    Key? key,
    required this.isAuctionPressed,
    required this.isSearchPressed,
    this.onPressAuction,
    this.onPressSearch,
  }) : super(key: key);

  final bool isAuctionPressed;
  final bool isSearchPressed;
  final VoidCallback? onPressAuction;
  final VoidCallback? onPressSearch;

  @override
  Widget build(BuildContext context) {
    Size _sizeScreen = MediaQuery.of(context).size;
    return Neumorphic(
        style: NeumorphicStyle(
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.only(
                topRight: Radius.circular(15), topLeft: Radius.circular(15))),
            depth: 4,
            shadowDarkColor: Colors.black,
            shadowLightColor: Colors.black54,
            color: Color(0xFF34393F)),
        child: Container(
            height: kBottomNavigationBarHeight + _sizeScreen.height * 0.022,
            width: _sizeScreen.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    end: Alignment.topCenter,
                    begin: Alignment.bottomCenter,
                    colors: [
                  const Color(0xff181e23),
                  const Color(0xff343b46)
                ])),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                (isAuctionPressed)
                    ? Neumorphic(
                        style: NeumorphicStyle(
                          depth: -4,
                          shadowDarkColorEmboss: Colors.black87,
                          shadowLightColorEmboss: Colors.white54,
                          color: Color(0xFF2E3238),
                        ),
                        child: Container(
                          width: _sizeScreen.width * 0.4,
                          height: kBottomNavigationBarHeight -
                              _sizeScreen.height * 0.005,
                          child: TextButton(
                              onPressed: onPressAuction,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/money_orange.png',
                                    height: 24,
                                    fit: BoxFit.fitHeight,
                                  ),
                                  const SizedBox(width: 8),
                                  Text('Auction',
                                      style: TextStyle(
                                          color: Color(0xFFFF4F01),
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                                ],
                              )),
                        ),
                      )
                    : Container(
                        width: _sizeScreen.width * 0.4,
                        height: kBottomNavigationBarHeight,
                        child: TextButton(
                            onPressed: onPressAuction,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/money.png',
                                  height: 24,
                                  fit: BoxFit.fitHeight,
                                ),
                                const SizedBox(width: 8),
                                Text('Auction',
                                    style: TextStyle(
                                        color: Color(0xFFC0C1C2),
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                              ],
                            )),
                      ),
                (isSearchPressed)
                    ? Neumorphic(
                        style: NeumorphicStyle(
                          depth: -4,
                          shadowDarkColorEmboss: Colors.black87,
                          shadowLightColorEmboss: Colors.white54,
                          color: Color(0xFF2E3238),
                        ),
                        child: Container(
                          width: _sizeScreen.width * 0.4,
                          height: kBottomNavigationBarHeight -
                              _sizeScreen.height * 0.005,
                          child: TextButton(
                              onPressed: onPressSearch,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.search_outlined,
                                    color: Color(0xFFFF4F01),
                                  ),
                                  const SizedBox(width: 8),
                                  Text('Search',
                                      style: TextStyle(
                                          color: Color(0xFFFF4F01),
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16)),
                                ],
                              )),
                        ),
                      )
                    : Container(
                        width: _sizeScreen.width * 0.4,
                        height: kBottomNavigationBarHeight,
                        child: TextButton(
                            onPressed: onPressSearch,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.search_outlined,
                                  color: Color(0xFFC0C1C2),
                                ),
                                const SizedBox(width: 8),
                                Text('Search',
                                    style: TextStyle(
                                        color: Color(0xFFC0C1C2),
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                              ],
                            )),
                      )
              ],
            )));
  }
}
