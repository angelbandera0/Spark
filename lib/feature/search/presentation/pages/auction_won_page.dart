import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sparkz/core/base/widget_base_state.dart';
import 'package:sparkz/core/global/_widgets/custom_bottom_nav_bar.dart';
import 'package:sparkz/core/global/_widgets/custom_upper_button.dart';
import 'package:sparkz/core/global/_widgets/data/custom_appBar.dart';
import 'package:sparkz/feature/auction/presentation/bloc/start_auction/start_auction_bloc.dart';
import 'package:sparkz/feature/search/domain/entity/auction_result_response_entity.dart';
import 'package:sparkz/feature/search/presentation/widgets/custom_card_auction_won.dart';

class AuctionWonPage extends StatefulWidget {
  AuctionWonPage({Key? key, required this.payload}) : super(key: key);
  final Map<String, String> payload;

  @override
  _AuctionWonPageState createState() => _AuctionWonPageState();
}

class _AuctionWonPageState
    extends StateWithBloC<AuctionWonPage, StartAuctionBloc> {
  final keyForm = GlobalKey<FormState>();
  final padding = EdgeInsets.symmetric(horizontal: 20);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget buildWidget(BuildContext context) {
    Size _sizeScreen = MediaQuery.of(context).size;
    final _padding = MediaQuery.of(context).padding.top;
    final _appBarPreferredSize = _sizeScreen.height * 0.15;
    ParkedUser parkedUser = ParkedUser.fromJson(widget.payload);

    return BlocConsumer<StartAuctionBloc, StartAuctionState>(
      listener: (context, state) {
        return;
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is StartAuctionSentState,
          child: Scaffold(
            backgroundColor: Color(0xFF2E3238),
            resizeToAvoidBottomInset: true,
            appBar: PreferredSize(
                child: CustomAppBar(
                  leading: CustomUpperButton(
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    icon: Icons.arrow_back,
                  ),
                  title: 'Auction won',
                ),
                preferredSize: Size(_sizeScreen.width, _appBarPreferredSize)),
            body: Form(
              key: keyForm,
              child: LayoutBuilder(
                builder: (context, constraint) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                          Color(0xFF34393F),
                          Color(0xFF1B1C20),
                        ])),
                    height:
                        (_sizeScreen.height - _appBarPreferredSize - _padding),
                    child: SingleChildScrollView(
                      child: SafeArea(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin: EdgeInsets.only(
                                    left: 20, right: 20, bottom: 10),
                                child: AutoSizeText(
                                    'You have won the Auction with a Bid of \$${parkedUser.bidWinner}',
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Color(0xFFC0C1C2),
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14))),
                            CustomCardAuctionWon(parkedUser: parkedUser),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            extendBody: true,
            bottomNavigationBar: NeumorphicBottomNavBar(
                isAuctionPressed: false,
                onPressAuction: () {},
                onPressSearch: () {},
                isSearchPressed: true),
          ),
        );
      },
    );
  }
}
