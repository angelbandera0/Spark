import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sparkz/core/base/widget_base_state.dart';
import 'package:sparkz/core/global/_widgets/custom_bottom_nav_bar.dart';
import 'package:sparkz/core/global/_widgets/custom_card_auction_invitation.dart';
import 'package:sparkz/core/global/_widgets/data/custom_appBar.dart';
import 'package:sparkz/core/global/_widgets/custom_upper_button.dart';
import 'package:sparkz/core/global/navigator/router_params.dart';
import 'package:sparkz/feature/auction/domain/entity/parked_entity.dart';
import 'package:sparkz/feature/search/presentation/bloc/submit_bid/submit_bid_bloc.dart';

class AuctionInvitationsPage extends StatefulWidget {
  AuctionInvitationsPage({Key? key, this.routeParams}) : super(key: key);
  final RouteParams? routeParams;

  @override
  _AuctionInvitationsPageState createState() => _AuctionInvitationsPageState();
}

class _AuctionInvitationsPageState
    extends StateWithBloC<AuctionInvitationsPage, SubmitBidBloc> {
  final keyForm = GlobalKey<FormState>();
  final padding = EdgeInsets.symmetric(horizontal: 20);
  late ParkedEntity entity;
  late int unparkedId;

  String locality = '';
  int waitTime = 0;
  double minimunBid = 0;

  @override
  void initState() {
    super.initState();
    _parseRouteParams();
  }

  void _parseRouteParams() {
    if (widget.routeParams is ParamsFromSearchAuction) {
      final params = widget.routeParams as ParamsFromSearchAuction;
      entity = params.parkedEntity;
      unparkedId = params.unparkedId;
    }
  }

  @override
  Widget buildWidget(BuildContext context) {
    Size _sizeScreen = MediaQuery.of(context).size;
    final _padding = MediaQuery.of(context).padding.top;
    final _appBarPreferredSize = _sizeScreen.height * 0.15;

    return BlocConsumer<SubmitBidBloc, SubmitBidState>(
      listener: (context, state) {
        return;
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is SubmitBidSentState,
          child: Scaffold(
              backgroundColor: Color(0xFF2E3238),
              resizeToAvoidBottomInset: true,
              appBar: PreferredSize(
                  child: CustomAppBar(
                    leading: CustomUpperButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icons.arrow_back,
                    ),
                    title: 'Auction invitations',
                  ),
                  preferredSize: Size(_sizeScreen.width, _appBarPreferredSize)),
              body: Form(
                key: keyForm,
                child: LayoutBuilder(
                  builder: (context, constraint) {
                    return Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                            Color(0xFF34393F),
                            Color(0xFF1B1C20),
                          ])),
                      height: (_sizeScreen.height -
                          _appBarPreferredSize -
                          _padding),
                      child: SingleChildScrollView(
                        child: CustomCardAuctionInvitations(
                            changeHandler: (value) {
                              setState(() {
                                minimunBid = double.tryParse(value) ?? 0;
                              });
                            },
                            onPressed: () {
                              if (keyForm.currentState?.validate() ?? false) {
                                bloc?.add(SubmitBidSentEvent(
                                    entity.id!, unparkedId, minimunBid));
                              }
                            },
                            size: _sizeScreen,
                            entity: entity),
                      ),
                    );
                  },
                ),
              ),
              extendBody: true,
              bottomNavigationBar: CustomHomeBottomNavBar(
                isAuctionPressed: false,
                isSearchPressed: true,
              )),
        );
      },
    );
  }
}
